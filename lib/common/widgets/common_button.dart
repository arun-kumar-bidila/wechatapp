import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

class CommonButton extends StatefulWidget {
  final String buttonName;
  final VoidCallback onTap;
  const CommonButton({
    super.key,
    required this.buttonName,
    required this.onTap,
  });

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.appColor,
        ),
        child: Center(
          child: Text(
            widget.buttonName,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
