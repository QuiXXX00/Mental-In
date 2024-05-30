import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MedWidBool extends StatelessWidget {
  final bool isOriginal;
  final String text;


  MedWidBool({required this.isOriginal, required this.text});

  @override
  Widget build(BuildContext context) {
    Color containerColor = isOriginal ? Color(0xFFFFC97E) : Color(0xFF8E97FD);
    Color textColor = isOriginal ? Color(0xFF3F414E) : Color(0xFFFFECCC);
    String imagePath = isOriginal
        ? 'Assets/icons/GroupMedBaba.svg'
        : 'Assets/icons/GroupMedEbaniLuk.svg';


    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Ink(
        width: 168,
        height: 200,
        decoration: ShapeDecoration(
          color: containerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 3.5,
              right: 2,
              child: SvgPicture.asset(
                imagePath,
              ),
            ),
            Positioned(
              top: 100,
              left: 15,
              child: Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 12,
              top: 160,
              child: SizedBox(
                width: 147,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '1 MIN',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                      width: 70,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Color(0xFF3F414E),
                        borderRadius: BorderRadius.circular(29),
                      ),
                      child: Center(
                        child: Text(
                          'Старт',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
