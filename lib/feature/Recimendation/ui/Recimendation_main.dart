import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart/feature/Recimendation/widget/MedWid.dart';
import 'package:smart/feature/Recimendation/widget/PlayWid.dart';
import 'package:smart/utils/AppTypography.dart';

import '../../../widgets/bar/AppBarAvatar.dart';
import '../../../widgets/bar/SliverCustomAppBar.dart';
import '../widget/MedWidBool.dart';
import '../widget/MedWidHorizontal.dart';
import '../widget/daily_reminder.dart';

class Rec extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBarAvatar(text: 'Уделите время себе',),
          body: CustomScrollView(slivers: <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: MedWid()),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: DailyReminder(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MedWidBool(isOriginal: true, text: 'Отдохните',),

                    MedWidBool(isOriginal: false, text: 'Подрочите',)
                  ],
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20, top: 27),
                child: Text('Рекомендации для тебя',style: AppTypography.f24w400,),
              ),
            ),
            SliverToBoxAdapter(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const  EdgeInsets.only(left: 20, right: 20, top: 27),
                  child: Row(
                    children: <Widget>[
                      MedWidHorizontal(isOriginal: true, text: 'Счастье',),
                      SizedBox(width: 12,),
                      MedWidHorizontal(isOriginal: false, text: 'Фокус',),
                      SizedBox(width: 12,),
                      MedWidHorizontal(isOriginal: false, text: 'Покус',)
                    ],
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(height: 50,),
            )
          ])),
    );
  }
}
