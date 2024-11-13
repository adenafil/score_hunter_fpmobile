import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:soccer_live_score/firebase_options.dart';
import 'package:soccer_live_score/screens/login_screen.dart';
import 'package:soccer_live_score/screens/main_screen.dart';

import 'controller/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Root widget of the app
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserController.user != null
          ? const AppMainScreen()
          : const LoginScreen(),
    );
  }
}
