import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomWidget extends StatelessWidget {
  final String iconPath;
  final String countText;
  final String descriptionText;

  CustomWidget({
    required this.iconPath,
    required this.countText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 22,
          width: 22,
          child: SvgPicture.asset(
            'Assets/icons/$iconPath',

          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 126,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                countText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 21,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                descriptionText,
                style: TextStyle(
                  color: Color(0xFF9098A3),
                  fontSize: 11,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
