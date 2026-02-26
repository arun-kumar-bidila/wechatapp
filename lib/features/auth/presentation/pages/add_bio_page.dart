import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_text_field.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';

class AddBioPage extends StatefulWidget {
  final String email;
  final String password;
  final String fullName;
  const AddBioPage({
    super.key,
    required this.email,
    required this.fullName,
    required this.password,
  });

  @override
  State<AddBioPage> createState() => _AddBioPageState();
}

class _AddBioPageState extends State<AddBioPage> {
  final TextEditingController _bioController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  double _opacity = 0.5;
  void _checkFormValidity() {
    final isValid = _bioController.text.isNotEmpty;
    setState(() {
      _opacity = isValid ? 1 : 0.5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AuthSignUpLoading) {
                return CircularProgressIndicator();
              }
              return SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: formKey,
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
                        onChanged: (value) => _checkFormValidity(),
                      ),
                      SizedBox(height: 24),
                      AnimatedOpacity(
                        opacity: _opacity,
                        duration: Duration(milliseconds: 500),
                        child: CommonButton(
                          buttonName: "Sign Up .",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                AuthUserSignUpEvent(
                                  email: widget.email,
                                  password: widget.password,
                                  fullName: widget.fullName,
                                  bio: _bioController.text.trim(),
                                ),
                              );
                            }
                            // context.push("/");
                          },
                        ),
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
