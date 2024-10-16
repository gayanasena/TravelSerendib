import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:travelapp/routes/routes.dart';
import 'package:travelapp/routes/routes_extension.dart';
import 'package:travelapp/utils/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late FlutterSecureStorage secureStorage;
  @override
  initState() {
    secureStorage = const FlutterSecureStorage();
    reRoute();
    super.initState();
  }

  Future<String> getSecureStorageData() async {
    return await secureStorage.read(key: 'isGuestMode') ?? "false";
  }

Future<bool> getAuthState() async {
  User? user = await FirebaseAuth.instance.authStateChanges().first;

  if (user == null) {
    if (kDebugMode) {
      print('User is currently signed out!');
    }
    return false;
  } else {
    if (kDebugMode) {
      print('User is signed in!');
    }
    return true;
  }
}


  void reRoute() async {
    // Note - initially 'isGuestMode' is 'true', when once logged in it will 'false' and when user logged out it will turn back to 'true'.
    String isGuestMode = await getSecureStorageData();
    bool isLoggedIn = await getAuthState();
    if (isGuestMode == "true") {
      Timer(const Duration(seconds: 1),
          () => context.pushReplacementNamed(ScreenRoutes.toWelcomeScreen));
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
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              Assets(context).appLogo,
              width: 200.0,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
