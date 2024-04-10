import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart/feature/auth/firebase/get_data.dart';
import 'package:smart/utils/AppTypography.dart';

import '../../../widgets/bar/AppBarAvatar.dart';
import '../widget/CustomContainerWidget.dart';
import '../widget/user_profile_widget.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  String img = 'https://gas-kvas.com/grafic/uploads/posts/2024-01/gas-kvas-com-p-logotip-zagruzki-na-prozrachnom-fone-2.png';
  bool isDailySelected = false; // Флаг для отслеживания выбора "Дэйли"
  bool isTasksSelected = true;// Флаг для отслеживания выбора "Задания"


  @override
  void initState() {
    super.initState();
    GetData().getuser().then((v) {
      setState(() {
        username = v;
      });
    });
    GetData().getimg().then((v) {
      setState(() {
        img = v;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBarAvatar(text: '',),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('userProfile').snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Доброе утро, $username',
                        style: AppTypography.f28w400,
                      ),
                    ],
                  ),
                ),
              ),
               Padding(
                 padding: EdgeInsets.symmetric(vertical: 8),
                 child: Center(
                   child: Text(
                     'Статистика вашего персонажа',
                     style: AppTypography.f20w400,
                   ),
                 ),
               ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                          Image.network(img,
                        width: 140,
                        height: 270,),
                        SizedBox(
                          width: 15,
                        ),
                        UserProfileWidget(username: username),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 38),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isDailySelected = true;
                          isTasksSelected = false;
                        });
                      },
                      child: Container(
                        width: 131,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Дэйли',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: isDailySelected
                                    ? FontWeight.w900
                                    : FontWeight.w500,
                                letterSpacing: -0.16,
                              ),
                            ),
                            Container(
                              width: 114,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  side: BorderSide(
                                    width: 3,
                                    color: isDailySelected
                                        ? const Color(0xFF8E97FD)
                                        : Colors.transparent,

                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isDailySelected = false;
                          isTasksSelected = true;
                        });
                      },
                      child: Container(
                        width: 131,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Задания',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: isTasksSelected
                                    ? FontWeight.w900
                                    : FontWeight.w500,
                                letterSpacing: -0.16,
                              ),
                            ),
                            Container(
                              width: 114,
                              decoration: ShapeDecoration(

                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2),
                                  side: BorderSide(

                                    width: 3,
                                    color: isDailySelected
                                        ? Colors.transparent
                                        : Color(0xFF8E97FD),


                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('Tasks').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) return Text('нет записей');
                    var ref = snapshot.data?.docs;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child:
                      isDailySelected ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {

                            return Column(
                                children: [CustomContainerWidget(text: snapshot.data!.docs[index].get('name'),
                                    exp: int.parse(snapshot.data!.docs[index].get('exp')) ,
                                    img:snapshot.data!.docs[index].get('imgurl'),
                                    isButtonPressed: true,
                                    index: snapshot.data!.docs[index],
                                     )]
                            );})
                          : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                                children: [CustomContainerWidget(text: snapshot.data!.docs[index].get('name'),
                                    exp: int.parse(snapshot.data!.docs[index].get('exp')) ,
                                    img:snapshot.data!.docs[index].get('imgurl'),
                                    isButtonPressed: snapshot.data!.docs[index].get('complite'),
                                    index: snapshot.data!.docs[index].id,
                                )]

                            );})


//


                    );
                  }
              ),

            ],
          );
        }
      ),
    );
  }
}
