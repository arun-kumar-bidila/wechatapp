import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wechat/features/auth/domain/entities/user.dart';

class ChatTile extends StatelessWidget {
  final User user;
  const ChatTile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),

      child: Row(
        children: [
          user.profilePic.isEmpty
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
                  child: Image.network(user.profilePic, fit: BoxFit.cover),
                ),
              ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 4),
                Text(user.bio, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
