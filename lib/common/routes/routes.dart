import 'package:flutter/material.dart';
import 'package:todo_with_riverpod/features/auth/pages/login_page.dart';
import 'package:todo_with_riverpod/features/auth/pages/otp_page.dart';
import 'package:todo_with_riverpod/features/onboarding/pages/onboarding.dart';
import 'package:todo_with_riverpod/features/todo/pages/home_page.dart';

class Routes {
  static const String onboarding = 'onboarding';
  static const String login = 'login';
  static const String otp = 'otp';
  static const String home = 'home';

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case 'onboarding':
        return MaterialPageRoute(
          builder: (context) => const Onboarding(),
        );

      case 'login':
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case 'otp':
        final Map args = settings.arguments as Map;
        return MaterialPageRoute(
          builder: (context) => OtpPage(
            phone: args['phone'],
            smsCodeId: args['smsCodeId'],
          ),
        );
      case 'home':
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
