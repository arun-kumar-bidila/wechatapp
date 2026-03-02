import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wechat/common/widgets/common_icon.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';

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
            padding: const EdgeInsets.all( 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (user.profilePic.isEmpty)
                  Container(
                    width: 45,
                    height: 45,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).colorScheme.surfaceContainer,
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
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.fullName,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
            
                    Text(user.bio, style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                Spacer(),
                CommonIcon(icon: Icons.add),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
