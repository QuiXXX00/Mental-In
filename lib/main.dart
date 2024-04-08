
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';


import 'feature/auth/firebase/firebase_stream.dart';
import 'feature/home/ui/home_screen.dart';
import 'feature/auth/ui/regestration_screen.dart';
import 'feature/auth/ui/auth_screen.dart';
import 'feature/auth/ui/login_screen_avatar.dart';
import 'feature/auth/ui/welcome_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,);
  runApp(MyApp());
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
      initialRoute: "/",
      routes: {
        "/": (context) => FirebaseStream(),
        "/Reg": (context) => RegestrationScreen(),
        "/Auth": (context) => AuthScreen(),
        "/home": (context) => HomeScreen(),
        "/Reg2": (context) => LoginScreenAvatar(),
        "/Well" : (context) => WelcomeScreen(),
        // "/Reg2": (context) => registerSecondScreen(),
        // "/UserProfile": (context) => TestApp(),
        //
      },

    );
  }
}