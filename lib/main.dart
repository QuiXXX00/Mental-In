
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:smart/feature/Profile/ui/profile.dart';
import 'package:smart/feature/SpidTest/ui/Testik2.dart';


import 'feature/Calendar/ui/Calendar_main.dart';
import 'feature/Recimendation/ui/MeditationScreen.dart';
import 'feature/Recimendation/ui/Recimendation_main.dart';
import 'feature/SpidTest/ui/Testik3.dart';
import 'feature/SpidTest/ui/Testiki.dart';
import 'feature/SpidTest/ui/Tests_main.dart';
import 'feature/Theory/ui/ArticleScreen.dart';
import 'feature/Theory/ui/Theory_main.dart';
import 'feature/auth/firebase/firebase_stream.dart';
import 'feature/home/ui/home_screen.dart';
import 'feature/auth/ui/regestration_screen.dart';
import 'feature/auth/ui/auth_screen.dart';
import 'feature/auth/ui/login_screen_avatar.dart';
import 'feature/auth/ui/welcome_screen.dart';
import 'feature/home/widget/bar.dart';
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
        "/": (context) => const FirebaseStream(),
        "/Reg": (context) => RegestrationScreen(),
        "/Auth": (context) => AuthScreen(),
        "/home": (context) => HomeScreen(),
        "/Reg2": (context) => LoginScreenAvatar(),
        "/Well" : (context) => const WelcomeScreen(),
        "/rec" : (context) =>Rec(),
        "/theory" : (context) =>Theory(),
        "/test" : (context) =>Test(),
        "/calendar" : (context) =>Calendar1(),
        "/bp" : (context) => BottonBar(),
        "/profile" : (context) => Profile(),
        "/testik" : (context) => EysenckTestScreen(),
        "/testik2" : (context) => PsychologicalAgeTestScreen(),
        "/testik3" : (context) => AnxietyTestScreen(),
        "/stat" : (context) => ArticleScreen(txt: 'ssss.txt', description: 'Стресс',),
        "/stat2" : (context) => ArticleScreen(txt: 'qqq.txt', description: 'Выгорание',),
        "/stat3" : (context) => ArticleScreen(txt: 'medetacia.txt', description: 'Медитации',),
        // "/meditationscreen": (context) => MeditationScreen(),

        //
      },

    );
  }
}