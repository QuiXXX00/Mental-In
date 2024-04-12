import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/AppTypography.dart';

class MedWidHorizontal extends StatelessWidget {
  final bool isOriginal;
  final String text;

  MedWidHorizontal({required this.isOriginal, required this.text});

  @override
  Widget build(BuildContext context) {
    Color containerColor = isOriginal ? Color(0xFFFEE3B4) : Color(0xFFAFDBC5);
    String imagePath = isOriginal ?  'Assets/icons/Pizdez.svg'  : 'Assets/icons/PizdezBaba.svg';


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: (){},
          child: Ink(
            decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10)),color: containerColor  ),
            width: 162,
            height: 111.23,
            child:  SvgPicture.asset(imagePath),
              ),
            ),
        SizedBox(height: 10),
        Text(
          text,
          style: AppTypography.f18w400.copyWith(color: Color(0xFF3F414E)),
        ),
        SizedBox(height: 15),
        Text(
          'MEDITATION 3-10 MIN',
            style: AppTypography.f10w600.copyWith(color: Color(0xFFA1A4B2))
        ),
      ],
    );
  }
}
