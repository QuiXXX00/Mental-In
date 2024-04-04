import 'package:flutter/material.dart';


 class CustomTextFild extends StatelessWidget {
   const CustomTextFild({super.key, required this.isActive, required this.text, required this.text1, this.controller});


   final Color1 = Colors.white;
   final Color2 = Colors.black;
   final String text;
   final String text1;
   final bool isActive;
   final TextEditingController? controller;


   @override
   Widget build(BuildContext context) {
     return TextField(
       style: const TextStyle(color: Colors.white),
       decoration: InputDecoration(
         filled: true,
         fillColor: const Color(0xFF48494A),
         focusedBorder: const OutlineInputBorder(
           borderSide: BorderSide(width: 1, color: Color(0xFFACACAC)),
         ),
         disabledBorder: const OutlineInputBorder(
           borderSide: BorderSide(width: 1, color: Colors.white),
         ),
         enabledBorder: OutlineInputBorder(
             borderSide: BorderSide(width: 1, color: isActive? Color1 : Color2),
             borderRadius: BorderRadius.circular(15)
         ),
         hintText: text1,
         hintStyle: TextStyle(
           color: Colors.white
         ),
       ),
       controller: controller,
     );
   }
 }
