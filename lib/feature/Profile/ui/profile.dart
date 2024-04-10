import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () {  FirebaseAuth.instance.signOut(); Navigator.pushNamed(context, '/'); },
            child: Text(
              'Выйти',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
