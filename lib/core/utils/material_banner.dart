import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

void showMaterialbanner(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
  ..hideCurrentMaterialBanner()
  ..showMaterialBanner(

    MaterialBanner(
      content: Text(
        content,
        style: Theme.of(
          context,
        ).textTheme.bodySmall!.copyWith(color: AppColors.white),
      ),
      elevation: 0,
      dividerColor: AppColors.transparentColor,
      backgroundColor: AppColors.appColor,

      padding: EdgeInsets.symmetric(horizontal: 16),

      actions: [
        GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: Text(
            "X",
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: AppColors.white),
          ),
        ),
      ],
    ),
  );
}
