import 'package:flutter/material.dart';
import 'package:task/core/routing/routes.dart';
import 'package:task/feature/auth/ui/page/login_view.dart';

import '../../feature/auth/ui/page/register_view.dart';

class AppRouter {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginView:
       return MaterialPageRoute(builder: (_) => const LoginView());

       case Routes.registerView:
       return MaterialPageRoute(builder: (_) => const RegisterView());

      //  case Routes.chatScreen:
      //  return MaterialPageRoute(builder: (_) => const ChatScreen());
    }
    return null;
  }
}
