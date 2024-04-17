import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomWidgetPlay extends StatelessWidget {
  final String time;

  const CustomWidgetPlay({
    Key? key, required this.time,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      width: 121,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 24,
            height: 24,
            clipBehavior: Clip.antiAlias,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(99),
            ),
            child: Center(child: SvgPicture.asset('Assets/icons/Vector.svg')),
          ),
          Text(
            'Начать',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
          Container(
            width: 44,
            height: 16,
            padding: const EdgeInsets.only(left: 5, right: 6, bottom: 1),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: Color(0xFFFAFDFF),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0x190E1117),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$time min',
                  style: TextStyle(
                    color: Color(0xFF0E1117),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ],
            ),
          )
        ],

      ),
    );
  }
}
