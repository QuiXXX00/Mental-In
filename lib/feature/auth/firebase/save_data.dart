import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:smart/widgets/conteiners/ImageSwitcher.dart';

import 'get_data.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName);
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  postDetailsToFirestore(String name) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
    FirebaseFirestore.instance.collection('userProfile');
    ref.doc(user!.uid).set({'name': name});
  }
  postProfileToFirestore(String img) async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
    FirebaseFirestore.instance.collection('userProfile');
    ref.doc(user!.uid).set({'Profileimg': img},SetOptions(merge: true));
  }
  dataupload(List listOfTasks,) {
    User? user = FirebaseAuth.instance.currentUser;
    var snap = FirebaseFirestore.instance
        .collection('Tasks')
        .get()
        .then((querysnapshot) {
      for (var docSnapshot in querysnapshot.docs) {
        FirebaseFirestore.instance
            .collection('userProfile/${user?.uid}/isUncomplitTasks')
            .doc(docSnapshot.id)
            .set({
          'isComplit': true,
          'exp': docSnapshot.get('exp'),
          'imgurl': docSnapshot.get('imgurl'),
          'name': docSnapshot.get('name'),
        }, SetOptions(merge: true));
      }
    });
  }
  changeLvls(int exp,){
    switch (exp){
      case <10:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 1},SetOptions(merge: true));
        break;
      case >=10 && <20 :
        FirebaseFirestore.instance.collection('userProfile')
        .doc(user!.uid).set({'healthlvl': 2,'studylvl': 2},SetOptions(merge: true));
        break;
      case >=20 && <30:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 3,'psihlvl': 2},SetOptions(merge: true));
        break;
      case >=30 && <40:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 4,'studylvl': 3},SetOptions(merge: true));
        break;
      case >=40 && <50:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 5},SetOptions(merge: true));
        break;
      case >=50 && <60:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 6,'psihlvl': 3,'studylvl': 4},SetOptions(merge: true));
        break;
      case >=60 && <70:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 7},SetOptions(merge: true));
        break;
      case >=70 && <80:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 8,'studylvl': 5},SetOptions(merge: true));
        break;
      case >=80 && <90:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 9,'psihlvl': 4},SetOptions(merge: true));
        break;
      case >=90 && <100:
        FirebaseFirestore.instance.collection('userProfile')
            .doc(user!.uid).set({'healthlvl': 10,'psihlvl': 5,'studylvl': 6},SetOptions(merge: true));
        break;

    }
  }
}

