import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_text_field.dart';

class AddBioPage extends StatefulWidget {
  const AddBioPage({super.key});

  @override
  State<AddBioPage> createState() => _AddBioPageState();
}

class _AddBioPageState extends State<AddBioPage> {
  final TextEditingController _bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/logo.svg", height: 150),
                SizedBox(height: 24),
                Text(
                  "Add Bio .",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 24),
                CommonTextField(
                  controller: _bioController,
                  hintText: "Say something about yourself to us",
                  label: "Bio",
                  maxLines: 2,
                ),
                SizedBox(height: 24),
                CommonButton(
                  buttonName: "Sign Up .",
                  onTap: () {
                    // context.push("/");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
