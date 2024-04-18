import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/utils/colors2.dart';

import '../../../utils/AppTypography.dart';
import '../../../widgets/bar/AppBarBack.dart';
import '../widget/FractionallyCont.dart';
import '../widget/StatConteiner.dart';

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: CustomAppBar(
            text: '',
          ),
          body: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.violet, width: 3),
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('Assets/Profile.png'),
                      radius: 50,
                      backgroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text('Adolf', style: AppTypography.f24w400),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 25),
                child: Row(
                  children: [
                    Text(
                      'Статистика',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                        letterSpacing: 0.02,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidget(
                      iconPath: 'Prof2.svg',
                      countText: '55',
                      descriptionText: 'Тестов пройдено',
                    ),
                    CustomWidget(
                      iconPath: 'Prof4.svg',
                      countText: '18',
                      descriptionText: 'Уровень персонажа',
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomWidget(
                      iconPath: 'Prof3.svg',
                      countText: '35',
                      descriptionText: 'Заданий выполнено',
                    ),
                    CustomWidget(
                      iconPath: 'Prof1.svg',
                      countText: '99%',
                      descriptionText: 'Информации изучено',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Text(
                      'Достижения',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: MeditationWidget(
                    currentCount: 9,
                    count: 20,
                    description: 'Осталось помедитировать',
                    text: 'Медитатор',
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: MeditationWidget(
                    currentCount: 16,
                    count: 20,
                    description: 'Осталось помедитировать',
                    text: 'Медитатор',
                  )),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 5),
                  child: MeditationWidget(
                    currentCount: 20,
                    count: 20,
                    description: 'Осталось помедитировать',
                    text: 'Медитатор',
                  ))
            ],
          )),
    );
  }
}
