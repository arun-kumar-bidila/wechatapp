import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;
  const CommonButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.appColor,
      ),
      child: Center(
        child: Text(
          buttonName,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
