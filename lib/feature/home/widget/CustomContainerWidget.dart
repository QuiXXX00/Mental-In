import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainerWidget extends StatefulWidget {
  const CustomContainerWidget({
    Key? key,
    required this.text,
    required this.exp,
    required this.asset1,
  }) : super(key: key);

  final String text;
  final int exp;
  final String asset1;

  @override
  _CustomContainerWidgetState createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {
  bool isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      height: 80,
      decoration: ShapeDecoration(
        color: isButtonPressed ? Colors.white : Color(0xFF8E97FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                widget.asset1,
                height: 58,
                width: 58,
                color: isButtonPressed ? Colors.black : Colors.white,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: isButtonPressed ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  '${widget.exp} exp',
                  style: TextStyle(
                    color: isButtonPressed ? Colors.black : Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isButtonPressed = !isButtonPressed;
                });
              },
              icon: SvgPicture.asset(
                isButtonPressed ? 'Assets/icons/check.svg' : 'Assets/icons/add_file.svg',
                height: 24,
                width: 24,
                color:  isButtonPressed ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
