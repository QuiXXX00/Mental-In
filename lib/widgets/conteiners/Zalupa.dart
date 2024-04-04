import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/colors2.dart';
import '../../utils/fonts.dart';

class ContainerPurchaseCondition extends StatelessWidget {
  ContainerPurchaseCondition(
      {super.key,
      required this.value,
      required this.coinImage,
      required this.enough});

  final String value;
  final bool enough;
  final String coinImage;
  final coloRed = Color(0xFFEDCECE);
  final colorWhite = AppColors.textContrast;
  final String svgGreen = 'assets/icons/Frame.svg';
  final String svgRed = 'assets/icons/Framered.svg';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 99,
      height: 87,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
      decoration: ShapeDecoration(
        color: enough ? colorWhite : coloRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(enough ? svgGreen : svgRed),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(coinImage),
              const SizedBox(width: 3),
              Text(
                value,
                style:
                    AppFonts.font16w700.copyWith(color: AppColors.textPrimary),
              )
            ],
          )
        ],
      ),
    );
  }
}
