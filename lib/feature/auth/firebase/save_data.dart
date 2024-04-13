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

  dataupdate(List listOfTasks,) {
    User? user = FirebaseAuth.instance.currentUser;
    var snap = FirebaseFirestore.instance
        .collection('Tasks')
        .get()
        .then((querysnapshot) {
      for (var docSnapshot in querysnapshot.docs) {
        FirebaseFirestore.instance
            .collection('userProfile/${user?.uid}/isComplitTasks')
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
}

