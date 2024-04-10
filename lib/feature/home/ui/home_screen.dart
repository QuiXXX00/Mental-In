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
  String img = '';
  bool isDailySelected = false; // Флаг для отслеживания выбора "Дэйли"
  bool isTasksSelected = false; // Флаг для отслеживания выбора "Задания"

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
      appBar: CustomAppBarAvatar(text: ' ',),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('userProfile').snapshots(),
        builder: (context, snapshot) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
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
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Center(
                    child: Text(
                      'Статистика вашего персонажа',
                      style: AppTypography.f20w400,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                sliver: SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Image.network(
                          img,
                          width: 140,
                          height: 270,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        UserProfileWidget(username: username),
                      ],
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
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
                                          ? Color(0xFF8E97FD)
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
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: isDailySelected
                      ? Column(
                          children: [
                            CustomContainerWidget(
                              text: 'Медитация 5 минут',
                              exp: 3,
                              asset1: 'Assets/icons/yoga.svg',
                            ),

                          ],
                        )
                      : isTasksSelected
                          ? Column(
                              children: [
                                CustomContainerWidget(
                                  text: 'Дрочить 5 минут',
                                  exp: 3,
                                  asset1: 'Assets/icons/yoga.svg',
                                ),
                              ],
                            )
                          : SizedBox(),
                ),
              ),

            ],
          );
        }
      ),
    );
  }
}
