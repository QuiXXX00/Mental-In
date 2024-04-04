import 'package:flutter/material.dart';

class CustomTextFild2 extends StatelessWidget {
  const CustomTextFild2({super.key, required this.hinttext, this.controller, this.keyboardType});

  final TextEditingController? controller;
  final String hinttext;
  final TextInputType?  keyboardType;


@override
Widget build(BuildContext context) {
  return Center(
    child: Container(
      width: 266,
      height: 48,
      child: TextField(
        style: TextStyle(color: Color(0xFF747474),fontSize: 16, fontWeight: FontWeight.w400,height: 1.75),
        decoration: InputDecoration(
            filled: true,
            fillColor: const  Color(0xFFF2F2F2),
            contentPadding: EdgeInsets.all(10),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none
            ),
            hintText: hinttext,
            hintStyle: TextStyle(
                color: Color(0xFF747474),
                fontSize: 16,
                fontWeight: FontWeight.w400,
            )
        ),
        keyboardType: keyboardType,
        controller: controller,
      ),
    ),
  );
}}
