import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wechat/common/theme/app_theme.dart';
import 'package:wechat/core/router/router.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_)=>serviceLocator<AuthBloc>())
     
    ],
    child:  MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

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
