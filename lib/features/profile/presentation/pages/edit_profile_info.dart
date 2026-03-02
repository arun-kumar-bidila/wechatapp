import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_icon.dart';
import 'package:wechat/common/widgets/common_text_field.dart';
import 'package:wechat/core/utils/image_picker.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';

class EditProfileInfo extends StatefulWidget {
  const EditProfileInfo({super.key});

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? image;

  Future<void> selectImage() async {
    final pickedImg = await pickImage();
    if (pickedImg != null) {
      setState(() {
        image = pickedImg;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        title: Text(
          "Edit Info",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthUserLoggedIn) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Hero(
                      tag: 'location-profile',
                      child: image != null
                          ? SizedBox(
                              width: 120,
                              height: 120,
                              child: ClipOval(
                                child: Image.file(image!, fit: BoxFit.cover),
                              ),
                            )
                          : Container(
                              width: 60,
                              height: 60,
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainer,
                              ),
                              child: SvgPicture.asset(
                                "assets/icons/profile.svg",
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.secondary,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: selectImage,
                      child: CommonIcon(icon: Icons.add),
                    ),
                    SizedBox(height: 24),
                    CommonTextField(
                      controller: nameController,
                      hintText: state.user.fullName,
                      label: "Name",
                    ),
                    SizedBox(height: 24),
                    CommonTextField(
                      controller: bioController,
                      hintText: state.user.bio,
                      label: "Bio",
                    ),
                    SizedBox(height: 24),
                    CommonButton(buttonName: 'Update Info', onTap: () {}),
                  ],
                ),
              );
            }
            return SizedBox();
          },
        ),
      ),
    );
  }
}
