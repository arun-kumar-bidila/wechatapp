import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/core/utils/snackbar.dart';
import 'package:wechat/features/chat/domain/entities/message_entity.dart';

class MessageTile extends StatelessWidget {
  final MessageEntity message;
  final bool isMe;
  const MessageTile({super.key, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          isMe
              ? SizedBox()
              : Row(
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/avatar_icon.png', width: 28),
                        SizedBox(height: 4),
                        Text(
                          DateFormat('hh:mm').format(message.createdAt),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(fontSize: 8),
                        ),
                      ],
                    ),

                    SizedBox(width: 8),
                  ],
                ),
          message.text != null
              ? Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      bottomLeft: isMe ? Radius.circular(16) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : Radius.circular(16),
                    ),
                    color: isMe
                        ? AppColors.appColor
                        : Theme.of(context).colorScheme.surfaceContainer,
                  ),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(
                        ClipboardData(text: message.text ?? ''),
                      );
                      showSnackabr(context, 'Copied !');
                    },

                    child: Text(
                      message.text ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: isMe ? AppColors.white : null,
                      ),
                    ),
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    message.image!,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
          isMe
              ? Row(
                  children: [
                    SizedBox(width: 8),
                    Column(
                      children: [
                        Image.asset('assets/images/avatar_icon.png', width: 28),
                        SizedBox(height: 4),
                        Text(
                          DateFormat('hh:mm').format(message.createdAt),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(fontSize: 8),
                        ),
                      ],
                    ),
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
