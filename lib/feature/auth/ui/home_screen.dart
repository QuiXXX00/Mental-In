import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/feature/auth/firebase/get_data.dart';

class HomeScreen extends StatefulWidget  {
   HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';

  @override
  void initState() {
    super.initState();
    GetData().getuser().then((v){setState(() {
      username = v;
    })
    ;});
  }
  @override
  Widget build(BuildContext context) {

  return  Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('userProfile').snapshots(),
        builder: (context, snapshot) {
          //if(!snapshot.hasData) return Center(child: Text('Данные загружаются'));
          return Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Приветствую $username'),
              TextButton(onPressed: (){FirebaseAuth.instance.signOut(); Navigator.pushNamed(context, '/');}, child: Text("Выйти с аккаунта"))
            ],
          ),);
        }
      ),
    );
  }
}
