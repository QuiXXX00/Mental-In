import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  CustomTextButton(
      {super.key,
        required this.isActive,
        required this.text,
        required this.callback,
        required this.height,
        required this.width, required this.border});

  final bool isActive;

  final String text;
  final _activeColor = const Color(0xFF8E97FD);
  final _notActiveColor = const Color(0xAF8E97FD);
  final VoidCallback callback;
  final double height;
  final double width;
  final double border;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
          onPressed: callback,
          style: ElevatedButton.styleFrom(
            backgroundColor: isActive ? _activeColor : _notActiveColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(border),
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0.08,
              letterSpacing: 0.70,
            ),
          )),
    );
  }
}