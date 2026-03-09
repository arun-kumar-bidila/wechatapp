import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/common/widgets/loader.dart';
import 'package:wechat/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:wechat/features/chat/presentation/widgets/message_tile.dart';

import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';

import 'package:wechat/features/home/presentation/widgets/profile_skeleton.dart';

class PersonalChatPage extends StatefulWidget {
  final User selectedUser;
  const PersonalChatPage({super.key, required this.selectedUser});

  @override
  State<PersonalChatPage> createState() => _PersonalChatPageState();
}

class _PersonalChatPageState extends State<PersonalChatPage> {
  final TextEditingController _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(
      ChatMessagesFetchEvent(selectedUserId: widget.selectedUser.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: GestureDetector(
            onTap: () {
              // context.push('/profile');
            },
            child: Hero(
              tag: 'user-profile-${widget.selectedUser.id}',
              child: widget.selectedUser.profilePic.isEmpty
                  ? Container(
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/profile.svg",
                        width: 18,
                        colorFilter: ColorFilter.mode(
                          Theme.of(context).colorScheme.secondary,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: ClipOval(
                          child: Image.network(
                            widget.selectedUser.profilePic,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }

                              return ProfileSkeleton(width: 40, height: 40);
                            },
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ),

        title: Text(
          widget.selectedUser.fullName,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          Center(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              state.onlineUsers.contains(widget.selectedUser.id)
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        state.onlineUsers.contains(widget.selectedUser.id)
                            ? 'Online'
                            : 'Offline',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatMessagesLoading) {
                    return Loader();
                  }
                  if (state is ChatMessagesFetchSuccess) {
                    return ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        final isMe = message.senderId != widget.selectedUser.id;
                        return MessageTile(message: message, isMe: isMe);
                      },
                    );
                  }
                  return SizedBox();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainer,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: InputDecoration(
                                hintText: "Type Here....",
                                hintStyle: Theme.of(
                                  context,
                                ).textTheme.bodySmall,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          SizedBox(width: 16),
                          SvgPicture.asset(
                            "assets/icons/gallery_icon.svg",
                            width: 16,
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).colorScheme.secondary,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      if (_messageController.text.isEmpty) {
                        return;
                      }
                      context.read<ChatBloc>().add(
                        ChatTextMessageSendEvent(
                          selectedUserId: widget.selectedUser.id,
                          message: _messageController.text.trim(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/icons/send_button.svg",
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
