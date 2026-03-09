import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';

class MessageTile extends StatelessWidget {
  final MessageEntity message;
  const MessageTile({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.appColor,
            ),
            child: Text(
              message.text!,
              style: Theme.of(context).textTheme.bodyMedium,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
