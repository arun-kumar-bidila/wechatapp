import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_text_field.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsetsGeometry.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/logo.svg", height: 100),
                SizedBox(height: 24),
                Text(
                  "Sign Up .",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 24),
                CommonTextField(
                  controller: nameController,
                  hintText: "enter your name",
                  label: "Name",
                ),
                SizedBox(height: 24),
                CommonTextField(
                  controller: emailController,
                  hintText: "enter your email",
                  label: "Email",
                ),
                SizedBox(height: 24),
                CommonTextField(
                  controller: passwordController,
                  hintText: "enter your password",
                  label: "Password",
                  isObscureText: true,
                ),
                SizedBox(height: 24),
                CommonButton(buttonName: "Sign Up .", onTap: () {}),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push("/login");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Already have an account ? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Login",
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColors.appColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
