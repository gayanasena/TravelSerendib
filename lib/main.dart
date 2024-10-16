import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:travelapp/app/app.dart';
import 'package:travelapp/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const App());
}

configureDependencies() {}
