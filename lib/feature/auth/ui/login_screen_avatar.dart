import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/buttons/custom_text_batton.dart';
import '../../../widgets/conteiners/ImageSwitcher.dart';
import '../firebase/get_data.dart';
import '../firebase/save_data.dart';

class LoginScreenAvatar extends StatefulWidget {
  LoginScreenAvatar({super.key});

  @override
  State<LoginScreenAvatar> createState() => _LoginScreenAvatarState();
}

class _LoginScreenAvatarState extends State<LoginScreenAvatar> {
  List<String> listOfTasks = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    GetData().getinfo().then((List<String> value) => setState(() {
          listOfTasks = value;
        }));
    setState(() {
      StoreData().dataupload(listOfTasks);
    });
  }

  callback(newindex) {
    setState(() {
      index = newindex;
    });
  }

  List<String> charactersURL = [
    'https://firebasestorage.googleapis.com/v0/b/mental-in-cf02f.appspot.com/o/characters%2FCHIBI1.png?alt=media&token=624d3d95-6d15-4bb3-ad1f-ac3f3f9e1bb4',
    'https://firebasestorage.googleapis.com/v0/b/mental-in-cf02f.appspot.com/o/characters%2FCHIBI2.png?alt=media&token=caf6b1f6-2418-4dbf-9cd1-3ea2b29eb8a8',
    'https://firebasestorage.googleapis.com/v0/b/mental-in-cf02f.appspot.com/o/characters%2FCHIBI3.png?alt=media&token=59feef49-cfa1-457a-bbed-3cfe0609eb0a',
    'https://firebasestorage.googleapis.com/v0/b/mental-in-cf02f.appspot.com/o/characters%2FCHIBI4.png?alt=media&token=35351312-b69c-47b1-92c0-a1bd61f7589c',
  ];

  Future<void> uploadimg() async {
    var user = FirebaseAuth.instance.currentUser;
    CollectionReference ref =
        FirebaseFirestore.instance.collection('userProfile');
    ref.doc(user!.uid).set({
      'imgURL': charactersURL[index],
      'healthlvl': 1,
      'psihlvl': 1,
      'studylvl': 1,
      'CountTexts': 0,
      'Tests': 0,
      'Profileimg':
          'https://www.dentalxp.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fuser-placeholder.9fc8def1.png&w=1920&q=75'
    }, SetOptions(merge: true));

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                const SizedBox(
                  height: 700,
                  width: double.infinity,
                ),
                Image.asset(
                  'Assets/Group 481740.png',
                  width: double.infinity,
                  height: 428.24,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  top: 160,
                  left: 15,
                  child: Text(
                    'Выберите аватар персонажа',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3F414E),
                      fontSize: 24,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.05,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 5,
                  child: Transform.rotate(
                    angle: -3.14,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/Reg', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFEBEAEC)),
                            borderRadius: BorderRadius.circular(38),
                          ),
                        ),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 230, left: 10, child: ImageSwitcher(index, callback))
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton(
                      isActive: true,
                      text: 'НАЧАТЬ',
                      callback: uploadimg,
                      height: 46.37,
                      width: 162,
                      border: 18),
                  CustomTextButton(
                      isActive: false,
                      text: 'Тестирование',
                      callback: () {},
                      height: 46.37,
                      width: 162,
                      border: 18)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
