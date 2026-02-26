import 'package:go_router/go_router.dart';
import 'package:wechat/features/auth/presentation/pages/add_bio_page.dart';
import 'package:wechat/features/auth/presentation/pages/login_page.dart';
import 'package:wechat/features/auth/presentation/pages/sign_up_page.dart';
import 'package:wechat/splash_screen.dart';

GoRouter createRouter() {
  
  return GoRouter(
    initialLocation: "/splash",
    routes: [
      GoRoute(path: "/splash",builder: (context, state) => SplashScreen(),),
      GoRoute(path: "/signup", builder: (context, state) => SignUpPage()),
      GoRoute(path: "/login", builder: (context, state) => LoginPage()),
      GoRoute(path: "/add-bio",builder: (context, state) => AddBioPage(),)
    ],
  );
}
