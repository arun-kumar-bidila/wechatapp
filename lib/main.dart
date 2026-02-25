import 'package:flutter/material.dart';
import 'package:wechat/common/theme/app_theme.dart';
import 'package:wechat/core/router/router.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "WeChat",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightThemeMode,
      darkTheme: AppTheme.darkThemeMode,
      // home: SignUpPage(),
      routerConfig: createRouter(),
    );
  }
}
