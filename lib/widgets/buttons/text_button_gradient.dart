
import 'package:flutter/material.dart';

import '../../utils/fonts.dart';

class GradientButton extends StatelessWidget {
  const GradientButton ({super.key, required this.text, required this.callback});

  final String text;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: ShapeDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-1.00, -0.02),
              end: Alignment(1, 0.02),
              colors: [Color(0xFFFF00D6), Color(0xFFFF4D00)],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            )
        ),
        child: TextButton(
          onPressed: callback,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                textAlign: TextAlign.center,
                style: AppFonts.font12w400
              )
            ],
          ),
        ),
      ),
    );
  }
}
