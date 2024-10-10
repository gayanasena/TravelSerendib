import 'package:flutter/material.dart';
import 'package:travelapp/features/home/presentation/pages/home_screen.dart';

import '../features/auth/presentation/pages/login_screen.dart';
import '../features/auth/presentation/pages/splash_screen.dart';

class ScreenRoutes {
  static const String toSplashScreen = 'toSplashScreen';

  static const String toSettingsScreen = 'toSettingsScreen';

  static const String toLoginScreen = 'toLoginScreen';

  static const String toHomeScreen = 'toHomeScreen';
}

class Router {
  static bool isGuestUser = true;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.toSplashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case ScreenRoutes.toLoginScreen:
        var args = settings.arguments != null ? settings.arguments as Map : {};
        bool isForceLogout = args["isForceLogout"] ?? false;

        return MaterialPageRoute(
            builder: (_) => LoginScreen(
                  isForceLogout: isForceLogout,
                ));

      case ScreenRoutes.toHomeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      default:
        return null;
    }
  }
}
