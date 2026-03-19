import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/common/entities/user.dart';
import 'package:wechat/features/home/domain/entity/last_message_entity.dart';
import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';
import 'package:wechat/features/home/presentation/widgets/profile_skeleton.dart';

class ChatTile extends StatefulWidget {
  final User user;
  final int unseenCount;
  final bool onlineStatus;
  final LastMessageEntity? lastMessage;
  const ChatTile({
    super.key,
    required this.user,
    required this.unseenCount,
    required this.onlineStatus,
    required this.lastMessage,
  });

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final homeBloc = context.read<HomeBloc>();
        homeBloc.add(HomeResetUnseenEvent(selectedUserId: widget.user.id));
        context.push('/personal-chat', extra: widget.user).then((_) {
          homeBloc.add(HomeOnFetchAllUsers());
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        color: AppColors.transparentColor,

        child: Row(
          children: [
            widget.user.profilePic.isEmpty
                ? Container(
                    padding: EdgeInsets.all(12),

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
                : SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipOval(
                      child: Image.network(
                        widget.user.profilePic,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;

                          return ProfileSkeleton(width: 40, height: 40);
                        },
                      ),
                    ),
                  ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.user.fullName,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(width: 8,),
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.onlineStatus
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.done_all, color: AppColors.appColor, size: 16),
                      SizedBox(width: 8),
                      if (widget.lastMessage != null)
                        Text(
                          widget.lastMessage!.lastMessage,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      if (widget.lastMessage == null)
                        Text(
                          'Start conversation',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 12),
            widget.unseenCount == 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.appColor,
                    ),
                    child: Text(
                      widget.unseenCount.toString(),
                      style: TextStyle(color: AppColors.white, fontSize: 14),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
