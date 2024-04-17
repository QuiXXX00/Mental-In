import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/colors2.dart';
import '../../Recimendation/widget/PlayWid.dart';

class ThepryCont extends StatelessWidget {
  final String time;
  final String chapter;
  final String description;
  final Function() onTap;


  const ThepryCont({
    Key? key, required this.time, required this.chapter, required this.description, required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: AppColors.lightViolet,
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF8E97FD),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Раздел: $chapter',
                    style: TextStyle(
                      color: Color(0xFFFAFDFF),
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: Color(0xFFFAFDFF),
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: CustomWidgetPlay(time: time,),
                  )
                ],
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                    image: AssetImage('Assets/welcome 1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
