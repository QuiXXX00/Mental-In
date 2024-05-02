import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final user = FirebaseAuth.instance.currentUser;

class GetData{


  Future<int> getuser() async {
    if (user != null) {
      var snap = await FirebaseFirestore.instance.collection(
          'userProfile').doc(user!.uid).get();
      Map<String, dynamic>? data = snap.data();
      return await data?['CountTexts'];
    }else return  0;
  }
  Future<int> getuser1() async {
    if (user != null) {
      var snap = await FirebaseFirestore.instance.collection(
          'userProfile').doc(user!.uid).get();
      Map<String, dynamic>? data = snap.data();
      return await data?['Tests'];
    }else return  0;
  }

  Future<String> getimg() async {
    if (user != null) {
      var snap = await FirebaseFirestore.instance.collection(
          'userProfile').doc(user!.uid).get();
      Map<String, dynamic>? data = snap.data();
      return await data?['imgURL'];
    }else return  "Изображение не найдено";
  }
  Future<List<String>> getusers()  async {
    List<String> users = [];
    await FirebaseFirestore.instance.collection('userProfile').get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            users.add(docSnapshot.id);
          }
        }
    );
    return users;
  }
  Future<List<String>> getevents()  async {
    List<String> events = [];
    await FirebaseFirestore.instance.collection('userProfile/${user?.uid}/event').get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            events.add(docSnapshot.id);
          }
        }
    );
    return events;
  }

  Future<List<String>> getinfo()  async{
    List<String> Tasks = [];
      await FirebaseFirestore.instance.collection('Tasks').get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            Tasks.add(docSnapshot.id);

          }
        }
      );
      return Tasks ;
  }

  Future<Map<String, dynamic>?> getlvls()  async{

    var lvls = await FirebaseFirestore.instance.collection('userProfile').doc(user?.uid).get();

    return lvls.data() ;
  }

  Future<int> getexp()  async{
    int Totalexp=0;
    await  FirebaseFirestore.instance.collection('userProfile/${user?.uid}/isComplitTasks').get().then(
           (querySnapshot) {
         for (var docSnapshot in querySnapshot.docs) {
           Totalexp += int.parse(docSnapshot.get('exp'));

         }
       }
   );
    return Totalexp ;
  }
  Future<List<String>> gettasks()  async {
    List<String> users = [];
    await FirebaseFirestore.instance.collection('userProfile/${user?.uid}/isComplitTasks').get().then(
            (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            users.add(docSnapshot.id);
          }
        }
    );
    return users;
  }
}
