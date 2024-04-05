import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return  Scaffold(
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Основновной экран'),
          TextButton(onPressed: (){FirebaseAuth.instance.signOut(); Navigator.pushNamed(context, '/');}, child: Text("Выйти с аккаунта"))
        ],
      ),),
    );
  }
}
