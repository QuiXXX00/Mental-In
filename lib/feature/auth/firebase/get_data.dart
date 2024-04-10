import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class GetData{
  final user = FirebaseAuth.instance.currentUser;

  Future<String> getuser() async {
    if (user != null) {
      var snap = await FirebaseFirestore.instance.collection(
          'userProfile').doc(user!.uid).get();
      Map<String, dynamic>? data = snap.data();
      return await data?['name'];
    }else return  "Пользователь не найден";
  }

  Future<String> getimg() async {
    if (user != null) {
      var snap = await FirebaseFirestore.instance.collection(
          'userProfile').doc(user!.uid).get();
      Map<String, dynamic>? data = snap.data();
      return await data?['imgURL'];
    }else return  "Изображение не найдено";
  }


  Future<String> getinfo(String tag) async {
    if (user != null) {
      var snap = await FirebaseFirestore.instance.collection(
          'Tasks').doc('n3gAvZYcqbh7izv41Kvk').get();
      Map<String, dynamic>? data = snap.data();
      return await data?['$tag'];
    }else return  "Информация не найдена";
  }
}
