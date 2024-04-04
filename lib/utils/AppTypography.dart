import 'package:flutter/material.dart';
import 'colors2.dart';

class AppTypography {
  const AppTypography._();

  static const _colorBlack = Colors.black;
  static const _lightGray = AppColors.lightGray;
  static const _white = Colors.white;
  static const _red = AppColors.red;
  static const _grey = AppColors.dark;
  static const _font = TextStyle(
    fontFamily: 'Poppins',
  );

  static const font14white = TextStyle(
    color: _colorBlack,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    fontSize: 48,
  );

  static const HelveticaNeue14 = TextStyle(
    color: Color(0xFFA1A4B2),
    fontSize: 14,
    fontFamily: 'HelveticaNeue',
    fontWeight: FontWeight.w700,
    height: 0.08,
    letterSpacing: 0.70,
  );


}
