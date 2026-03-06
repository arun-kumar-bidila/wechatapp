import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_svg/svg.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';

import 'package:wechat/features/home/presentation/widgets/profile_skeleton.dart';

class PersonalChatPage extends StatefulWidget {
  final User selectedUser;
  const PersonalChatPage({super.key, required this.selectedUser});

  @override
  State<PersonalChatPage> createState() => _PersonalChatPageState();
}

class _PersonalChatPageState extends State<PersonalChatPage> {
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
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                return Container(
                  width: 12,
                  height: 12,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: state.onlineUsers.contains(widget.selectedUser.id)
                        ? Colors.green
                        : Colors.red,
                  ),
                );
              },
            ),
          ),
        ],
      ),

      body: SafeArea(child: Column(children: [SizedBox()])),
    );
  }
}
