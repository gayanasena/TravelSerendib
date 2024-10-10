import 'package:flutter/material.dart';
import 'package:travelapp/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  runApp(const App());
}

configureDependencies() {}
