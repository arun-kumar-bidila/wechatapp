import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                Text("Login .", style: Theme.of(context).textTheme.titleLarge),
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
                CommonButton(buttonName: "Login .", onTap: () {
                  
                }),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        context.push("/signup");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don't have an account ? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "SignUp",
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
