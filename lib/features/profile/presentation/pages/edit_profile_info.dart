import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/cubit/app_user/app_user_cubit.dart';
import 'package:wechat/common/widgets/common_button.dart';
import 'package:wechat/common/widgets/common_icon.dart';
import 'package:wechat/common/widgets/common_text_field.dart';
import 'package:wechat/common/widgets/loader.dart';
import 'package:wechat/core/utils/image_picker.dart';
import 'package:wechat/core/utils/snackbar.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/common/widgets/profile_skeleton.dart';
import 'package:wechat/features/profile/presentation/bloc/profile_bloc.dart';

class EditProfileInfo extends StatefulWidget {
  const EditProfileInfo({super.key});

  @override
  State<EditProfileInfo> createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  File? image;
  final _formKey = GlobalKey<FormState>();

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
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateSuccess) {
              context.read<AuthBloc>().add(AuthCheck());
              nameController.clear();
              bioController.clear();
              showSnackabr(context, 'Profile updated');
            }
            if (state is ProfileUpdateFailure) {
              showSnackabr(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is ProfileUptadeLoading) {
              return Loader();
            }
            return BlocBuilder<AppUserCubit, AppUserState>(
              builder: (context, state) {
                if (state is AppUserLoggedIn) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
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
                                        child: Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : state.user.profilePic.isEmpty
                                  ? Container(
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
                                          Theme.of(
                                            context,
                                          ).colorScheme.secondary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    )
                                  : SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: ClipOval(
                                        child: Image.network(
                                          state.user.profilePic,
                                          fit: BoxFit.cover,
                                          loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }

                                        return ProfileSkeleton(
                                          width: 120,
                                          height: 120,
                                        );
                                      },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  width: 60,
                                                  height: 60,
                                                  padding: EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .surfaceContainer,
                                                  ),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/profile.svg",
                                                    fit: BoxFit.contain,
                                                    colorFilter:
                                                        ColorFilter.mode(
                                                          Theme.of(context)
                                                              .colorScheme
                                                              .secondary,
                                                          BlendMode.srcIn,
                                                        ),
                                                  ),
                                                );
                                              },
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
                              maxLines: 2,
                            ),
                            SizedBox(height: 24),
                            CommonButton(
                              buttonName: 'Update Info',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<ProfileBloc>().add(
                                    ProfileUpdateEvent(
                                      fullName: nameController.text,
                                      bio: bioController.text,
                                      image: image,
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox();
              },
            );
          },
        ),
      ),
    );
  }
}
