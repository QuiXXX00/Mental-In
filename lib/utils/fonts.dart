import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors2.dart';

class AppFonts {
  static final TextStyle _font = GoogleFonts.inter();
  static const TextStyle mainText = TextStyle(
    color: Colors.white,
    fontSize: 14,

    fontWeight: FontWeight.w400,

  );

  static final font16w700  =_font.copyWith(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.24,
  );

  static final h3  =_font.copyWith(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.21,
  );

  static final h4 = _font.copyWith(
    color: Colors.white,
    fontSize: 14,
    fontWeight: FontWeight.w700,
    height: 1.14,
  );
  static final textBold = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.18,
  );
  static final text = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.18,
  );
  static final textCompact = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static final textTiny = _font.copyWith(
    color: Colors.white,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );
  static final micro = _font.copyWith(
    color: Colors.white,
    fontSize: 8,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.12,
  );
  static final price = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.18,
  );
  static final sale = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.84,
  );
  static final font18w700 = _font.copyWith(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.27,
  );
  static final font8w700 = _font.copyWith(
    color: Colors.white,
    fontSize: 8,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.12,
  );
  static final button = _font.copyWith(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.36,
  );
  static final buttonDefault = _font.copyWith(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.24,
  );
  static final font12w400 = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.18,
  );

  static final buttonSmall = _font.copyWith(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.18,
  );
  static final font16w600 = _font.copyWith(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.24,


  );

  static const _fontBold = TextStyle(fontFamily: 'Poppins');
  static const _fontReg = TextStyle(fontFamily: 'Poppins');
  static const _white = Colors.white;
  static const _red = AppColors.redActive;

  static final font18whiteBold = _fontBold.copyWith(
    fontWeight: FontWeight.w500,
    color: _white,
    fontSize: 18,
  );

  static final font14white = _fontBold.copyWith(
      fontSize: 15,
      color: _white,
      fontWeight: FontWeight.w500
  );

  static final font12whiteReg = _fontReg.copyWith(
    fontWeight: FontWeight.w400,
    color: _white,
    fontSize: 12,
  );

  static final font12whiteBold = _fontBold.copyWith(
    fontWeight: FontWeight.w400,
    color: _white,
    fontSize: 12,
  );

  static final font12redReg = _fontReg.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: _red,
  );

  static final font10white = _fontReg.copyWith(
      fontSize: 12,
      color: Colors.white
  );

  static final font20white = _fontBold.copyWith(
      fontSize: 22, color: Colors.white, fontWeight: FontWeight.w600, decoration: TextDecoration.none);


  static const font = TextStyle(fontFamily: 'SF Pro Display',);
  static final font48black = font.copyWith(
    color: Colors.black,
    fontSize: 48,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,

  );
}

