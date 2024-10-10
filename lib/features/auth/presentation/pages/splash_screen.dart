import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isGuestUser = true;
  @override
  initState() {
    reRoute(isGuestUseer: true, isLoggedIn: false);
    super.initState();
  }

  void reRoute({required bool isGuestUseer, required bool isLoggedIn}) async {
    if (isGuestUser) {
      Timer(const Duration(seconds: 1),
          () => context.pushReplacementNamed(ScreenRoutes.toHomeScreen));
    } else {
      if (isLoggedIn) {
        Timer(const Duration(seconds: 1),
            () => context.pushReplacementNamed(ScreenRoutes.toHomeScreen));
      } else {
        Timer(const Duration(seconds: 1),
            () => context.pushReplacementNamed(ScreenRoutes.toLoginScreen));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_city_outlined,
              size: 60,
            ),
          ],
        ),
      ),
    );
  }
}
