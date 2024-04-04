
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors2.dart';
import '../../utils/fonts.dart';

class customConteinerTap extends StatelessWidget {
  customConteinerTap({super.key, required this.text, required this.asset, required this.callback});

  final String text;
  final String asset;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.textSecondary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            SvgPicture.asset(asset,width: 22,),
            SizedBox(
              width: 10,
            ),
            Text(
              text,
              style: AppFonts.mainText,
            )
          ],
        ),
      ),
    );
  }
}

