import 'package:go_router/go_router.dart';
import 'package:wechat/core/router/go_router_refresh_stream.dart';
import 'package:wechat/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:wechat/features/auth/presentation/pages/add_bio_page.dart';
import 'package:wechat/features/auth/presentation/pages/login_page.dart';
import 'package:wechat/features/auth/presentation/pages/sign_up_page.dart';
import 'package:wechat/features/home/presentation/pages/home_page.dart';
import 'package:wechat/features/profile/presentation/pages/edit_profile_info.dart';
import 'package:wechat/features/profile/presentation/pages/profile_page.dart';
import 'package:wechat/splash_screen.dart';

GoRouter createRouter(AuthBloc authBloc) {
  return GoRouter(
    initialLocation: "/splash",
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final authState = authBloc.state;
      final location = state.matchedLocation;

      final isPublic =
          location == '/login' ||
          location == '/signup' ||
          location == '/add-bio' ||
          location == '/splash';

      final isAuth =
          location == '/login' ||
          location == '/signup' ||
          location == '/add-bio';

      final isSplash = location == '/splash';

      if (authState is AuthInitial) {
        return isSplash ? null : '/splash';
      }

      if (authState is AuthUserLoggedIn && isPublic) {
        return '/home';
      }
      if (authState is AuthUserLoggedOut && !isAuth) {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(path: "/splash", builder: (context, state) => SplashScreen()),
      GoRoute(path: "/signup", builder: (context, state) => SignUpPage()),
      GoRoute(path: "/login", builder: (context, state) => LoginPage()),
      GoRoute(
        path: "/add-bio",
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return AddBioPage(
            email: data['email'],
            fullName: data['fullName'],
            password: data['password'],
          );
        },
      ),
      GoRoute(path: '/home', builder: (context, state) => HomePage()),
      GoRoute(path: '/profile', builder: (context, state) => ProfilePage()),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => EditProfileInfo(),
      ),
    ],
  );
}
