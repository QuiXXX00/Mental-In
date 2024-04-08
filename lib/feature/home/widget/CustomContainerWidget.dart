import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({super.key, required this.text, required this.exp, required this.asset1, });

  final String text;
  final int exp;
  final String asset1;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      height: 80,
      decoration: ShapeDecoration(
        color: Color(0xFF8E97FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              asset1,
              height: 58,
              width: 58,
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
              Text(
                '$exp exp',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w300,
                  height: 0,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'Assets/icons/add_file.svg',
              height: 58,
              width: 58,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
