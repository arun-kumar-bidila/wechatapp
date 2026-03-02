import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

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
          child: GestureDetector(
            onTap: () {
              context.push('/profile');
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: SvgPicture.asset(
                "assets/icons/profile.svg",
                width: 14,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.secondary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
        title: Text("Message", style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,
        actions: [
          Center(
            child: Container(
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.only(left: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              child: Icon(
                Icons.notifications_none,
                size: 20,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/search.svg",
                      width: 16,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.secondary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search People",
                          hintStyle: Theme.of(context).textTheme.bodySmall,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
