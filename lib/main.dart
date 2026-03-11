import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wechat/common/theme/app_theme.dart';
import 'package:wechat/common/theme/theme_cubit.dart';
import 'package:wechat/core/router/app_router.dart';
import 'package:wechat/core/utils/socket_service.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:wechat/features/home/presentation/bloc/home_bloc.dart';
import 'package:wechat/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:wechat/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
        BlocProvider(create: (_) => serviceLocator<ProfileBloc>()),
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => serviceLocator<HomeBloc>()),
        BlocProvider(create: (_) => serviceLocator<ChatBloc>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  @override
  void initState() {
    _router = createRouter(serviceLocator<AuthBloc>());
    serviceLocator<AuthBloc>().add(AuthCheck());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUserLoggedIn) {
          serviceLocator<SocketService>().connect(state.user.id);
        } else if (state is AuthUserLoggedOut) {
          serviceLocator<SocketService>().disconnect();
        }
      },
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, state) {
          return MaterialApp.router(
            title: "WeChat",
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightThemeMode,
            darkTheme: AppTheme.darkThemeMode,
            themeMode: state,
            // home: SignUpPage(),
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
