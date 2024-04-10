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
    String imagePath = isOriginal ? 'Assets/GroupPizdecBaba.png' : 'Assets/GroupPizdec.png';


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){},
          child: Container(
            width: 162,
            height: 111.23,
            decoration: BoxDecoration(
              color: containerColor,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: AppTypography.f18w400.copyWith(color: Color(0xFF3F414E)),
        ),
        SizedBox(height: 7),
        Text(
          'MEDITATION 3-10 MIN',
            style: AppTypography.f10w600.copyWith(color: Color(0xFFA1A4B2))
        ),
      ],
    );
  }
}
