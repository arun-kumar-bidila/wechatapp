import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/widgets/common_icon.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/home/presentation/widgets/profile_skeleton.dart';

class ProfileImgName extends StatefulWidget {
  const ProfileImgName({super.key});

  @override
  State<ProfileImgName> createState() => _ProfileImgNameState();
}

class _ProfileImgNameState extends State<ProfileImgName> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthUserLoggedIn) {
          final user = state.user;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(
                  tag: 'location-profile',
                  child: user.profilePic.isEmpty
                      ? Container(
                          width: 45,
                          height: 45,
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
                        )
                      : SizedBox(
                          width: 45,
                          height: 45,
                          child: ClipOval(
                            child: Image.network(
                              state.user.profilePic,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;

                                    return ProfileSkeleton(
                                      width: 40,
                                      height: 40,
                                    );
                                  },
                            ),
                          ),
                        ),
                ),

                TweenAnimationBuilder(
                  duration: Duration(milliseconds: 500),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Padding(
                        padding: EdgeInsetsGeometry.only(left: value * 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              user.fullName,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                            Text(
                              user.bio,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.push('/edit-profile');
                  },
                  child: CommonIcon(icon: Icons.add),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
