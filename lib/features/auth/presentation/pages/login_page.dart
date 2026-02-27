import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/theme/app_colors.dart';
import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_text_field.dart';
import 'package:wechat/core/utils/snackbar.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double _opacity = 0.5;
  void _checkFormValidity() {
    final isValid =
        emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    setState(() {
      _opacity = isValid ? 1 : 0.5;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthUserLoggedIn) {
                showSnackabr(context, "SignUp Success");
                
              }
            },
            buildWhen: (previous, current) =>
                current is AuthLoginLoading || current is AuthLoginFailure,
            builder: (context, state) {
              if (state is AuthLoginLoading) {
                return CircularProgressIndicator();
              }
              return SingleChildScrollView(
                padding: EdgeInsetsGeometry.all(16),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/images/logo.svg", height: 100),
                      SizedBox(height: 24),
                      Text(
                        "Login .",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: 24),

                      CommonTextField(
                        controller: emailController,
                        hintText: "enter your email",
                        label: "Email",
                        onChanged: (value) => _checkFormValidity(),
                      ),
                      SizedBox(height: 24),
                      CommonTextField(
                        controller: passwordController,
                        hintText: "enter your password",
                        label: "Password",
                        isObscureText: true,
                        onChanged: (value) => _checkFormValidity(),
                      ),
                      SizedBox(height: 24),
                      AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 500),
                        child: CommonButton(
                          buttonName: "Login .",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthUserLoginEvent(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
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
              );
            },
          ),
        ),
      ),
    );
  }
}
