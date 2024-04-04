
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

import 'feature/auth/ui/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental in',
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
      ),
      routes: {
        "/": (context) => WelcomeScreen(),
        // "/auth": (context) => LoginScreen(),
        // "/Reg": (context) => RegScreen(),
        // "/Reg2": (context) => registerSecondScreen(),
        // "/UserProfile": (context) => TestApp(),
      },
    );
  }
}