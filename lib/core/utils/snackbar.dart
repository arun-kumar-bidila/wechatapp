import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

void showSnackabr(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Center(
          child: Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
          ),
        ),
        elevation: 0,

        backgroundColor: AppColors.appColor,

        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 12),
      ),
    );
}
