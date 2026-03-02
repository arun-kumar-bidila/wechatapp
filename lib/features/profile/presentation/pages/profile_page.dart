import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:wechat/common/widgets/common_button.dart';
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
        child: Column(
          children: [
            ProfileImgName(),
            
            ProfileFeature(
              featureName: "Password",
              featureDesc: "Change your Password",
              icon: Icons.visibility_outlined,
            ),
            ThemeSwitch(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CommonButton(buttonName: "LogOut", onTap: (){}),
            )
          ],
        ),
      ),
    );
  }
}
