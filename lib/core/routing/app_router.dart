import 'package:flutter/material.dart';
import 'package:task/core/routing/routes.dart';
import 'package:task/feature/auth/ui/page/login_view.dart';
import 'package:task/feature/auth/ui/page/otp_view.dart';
import 'package:task/feature/main_screen/ui/main_screen.dart';

import '../../feature/auth/ui/page/register_view.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView:
        return MaterialPageRoute(builder: (_) => const LoginView());

      case Routes.registerView:
        return MaterialPageRoute(builder: (_) => const RegisterView());

      case Routes.otpView:
        final email = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => OtpView(email: email));

      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
    }
    return null;
  }
}
