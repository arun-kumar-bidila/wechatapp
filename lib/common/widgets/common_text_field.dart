import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.isObscureText=false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

        hintStyle: TextStyle(color: AppColors.greyColor,fontSize: 16),
        hintText: hintText,
      ),
      cursorColor: AppColors.appColor,
      
    );
  }
}
