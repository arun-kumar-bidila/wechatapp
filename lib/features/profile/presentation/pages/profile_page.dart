import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/cubit/app_user/app_user_cubit.dart';

import 'package:wechat/common/widgets/common_button.dart';

import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/profile/presentation/widgets/profile_feature.dart';
import 'package:wechat/features/profile/presentation/widgets/profile_img_name.dart';
import 'package:wechat/features/profile/presentation/widgets/theme_switch.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
        title: Text("Profile", style: Theme.of(context).textTheme.titleMedium),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthUserLoggedOutSuccess) {
              context.read<AppUserCubit>().updateUser(null);
              // showSnackabr(context, 'logout success');
            }
          },
          buildWhen: (previous, current) => current is AuthUserLoggedOutFailure,
          builder: (context, state) {
            return Column(
              children: [
                ProfileImgName(),

                GestureDetector(
                  onTap: () {
                    context.push('/change-password');
                  },
                  child: ProfileFeature(
                    featureName: "Password",
                    featureDesc: "Change your Password",
                    icon: Icons.visibility_outlined,
                  ),
                ),
                ThemeSwitch(),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CommonButton(
                    buttonName: "LogOut",
                    onTap: () {
                      context.read<AuthBloc>().add(AuthUserLoggedOutEvent());
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
