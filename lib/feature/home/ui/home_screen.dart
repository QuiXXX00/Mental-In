import 'dart:developer';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAvatar(),
      body: CustomScrollView(
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
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
                    Image.asset(
                      'Assets/CHIBI1.png',
                      width: 144,
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
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                          color: isDailySelected
                              ? Color(0xFF8E97FD)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xFF8E97FD), width: 3))),
                      child: Text(
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
                        color: isTasksSelected
                            ? Color(0xFF8E97FD)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border(
                            bottom:
                                BorderSide(color: Color(0xFF8E97FD), width: 3)),
                      ),
                      child: Text(
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
                        CustomContainerWidget(text: 'Медитация 5 минут', exp: 3, asset1: 'Assets/icons/yoga.svg',),
                      ],
                    )
                  : isTasksSelected
                      ? Column(
                          children: [
                            CustomContainerWidget(text: 'Дрочить 5 минут', exp: 3, asset1: 'Assets/icons/yoga.svg',),
                          ],
                        )
                      : SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}
