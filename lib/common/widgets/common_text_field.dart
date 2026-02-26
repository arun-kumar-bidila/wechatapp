import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_colors.dart';

class CommonTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isObscureText;
  final int maxLines;
  final ValueChanged? onChanged;
  const CommonTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.label,
    this.isObscureText = false,
    this.maxLines = 1,
    this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),

        hintStyle: TextStyle(color: AppColors.greyColor, fontSize: 16),
        hintText: hintText,
      ),
      cursorColor: AppColors.appColor,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      validator: (value) {
        if (value!.isEmpty) {
          return "Required*";
        } else {
          return null;
        }
      },
    );
  }
}
