import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/AppTypography.dart';
import '../../../utils/colors2.dart';
import 'PlayWid.dart';

class MedWid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {},
      child: Ink(
          width: double.infinity,
          height: 176,
          decoration: ShapeDecoration(
            color: Color(0xFF73BA9B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                left: 133,
                top: 103,
                child: SvgPicture.asset(
                    'Assets/icons/Plant 2.svg'),),
              Positioned(
                left: 178,
                top: 120,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('Assets/Rectangle.png'),
                          fit: BoxFit.cover)),
                ),),
              Positioned(
                left: 175,
                top: 20,
                child: SvgPicture.asset(
                    'Assets/icons/Girl Meditating 1.svg'),),

              Positioned(
                left: 20,
                top: 16,
                child: Text(
                  'Что такое медитация',
                  style: AppTypography.f20w600,
                ),
              ),
              Positioned(
                left: 20,
                top: 43,
                child: Text(
                  'От конфликта к гармонии',
                  style: TextStyle(
                    color: Color(0xFFFAFDFF),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
              Positioned(
                  left: 20, top: 112, child: CustomWidgetPlay()),
              Positioned(
                  left: 20,
                  top: 147,
                  child: SizedBox(
                    width: 59,
                    height: 16,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        SvgPicture.asset(
                            'Assets/icons/headphones.svg'),
                        Text('4 трека',
                            style: AppTypography.f10w600
                                .copyWith(color: Color(0xFFFAFDFF)))
                      ],
                    ),
                  )),
              Positioned(
                left: 89,
                top: 147,
                child: SizedBox(
                  width: 100,
                  height: 16,
                  child: Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(
                          'Assets/icons/bookmark2.svg'),
                      Text('1 минута чтения',
                          style: AppTypography.f10w600
                              .copyWith(color: Color(0xFFFAFDFF)))
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 287,
                top: -4,
                child: SvgPicture.asset(
                    'Assets/icons/Plant 3.svg'),),

            ],
          )),
    );
  }
}
