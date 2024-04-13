import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/feature/auth/ui/welcome_screen.dart';

import '../../home/ui/home_screen.dart';
import '../../home/widget/bar.dart';
import 'get_data.dart';


class FirebaseStream extends StatelessWidget {
  const FirebaseStream ({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        return user != null ? BottonBar() : WelcomeScreen();
        }
    );
  }
}
