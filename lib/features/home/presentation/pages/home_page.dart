import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wechat/core/utils/snackbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 16),

        leading: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            child: SvgPicture.asset(
              "assets/icons/profile.svg",
              width: 16,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.secondary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        title: Text("Message", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: SvgPicture.asset(
                "assets/icons/notification.svg",
                width: 20,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Text("Home Page")
            ElevatedButton(
              onPressed: () {
                showSnackabr(context, "Login Success");
              },
              child: Text("press me"),
            ),
          ],
        ),
      ),
    );
  }
}
