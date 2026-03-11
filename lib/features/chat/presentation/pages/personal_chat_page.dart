import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/common/widgets/loader.dart';
import 'package:wechat/core/utils/image_picker.dart';
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
  final ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  File? image;

  Future<void> selectImage() async {
    final pickedImg = await pickImage();
    if (pickedImg != null) {
      setState(() {
        image = pickedImg;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(
      ChatInitializeEvent(selectedUserId: widget.selectedUser.id),
    );
    context.read<ChatBloc>().add(
      ChatMessagesFetchEvent(selectedUserId: widget.selectedUser.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: Center(
          child: GestureDetector(
            onTap: () {
              context.push(
                '/selected-user-profile',
                extra: {
                  'selectedUser': widget.selectedUser,
                  'messages': context.read<ChatBloc>().state.messages,
                },
              );
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(8),
          child: Container(height: 1, color: AppColors.greyColor),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    scrollToBottom();
                  });
                  if (state.isLoading) {
                    return Loader();
                  }
                  if (state.messages.isNotEmpty) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: state.messages.length,

                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        final isMe = message.senderId != widget.selectedUser.id;
                        return MessageTile(message: message, isMe: isMe);
                      },
                    );
                  }
                  if (state.messages.isEmpty) {
                    return 
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Say Hello ! 👋 to ${widget.selectedUser.fullName} ',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                          GestureDetector(
                            onTap: () async {
                              final chatBloc = context.read<ChatBloc>();
                              await selectImage();

                              if (image != null) {
                                chatBloc.add(
                                  ChatImageMessageSendEvent(
                                    selectedUserId: widget.selectedUser.id,
                                    image: image!,
                                  ),
                                );
                                setState(() {
                                  image = null;
                                });
                                return;
                              }
                            },
                            child: SvgPicture.asset(
                              "assets/icons/gallery_icon.svg",
                              width: 16,
                              colorFilter: ColorFilter.mode(
                                Theme.of(context).colorScheme.secondary,
                                BlendMode.srcIn,
                              ),
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
                      _messageController.clear();
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
