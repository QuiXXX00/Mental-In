import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/buttons/custom_text_batton.dart';
import '../../../widgets/conteiners/ImageSwitcher.dart';

class LoginScreenAvatar extends StatefulWidget {
  LoginScreenAvatar({super.key});

  @override
  State<LoginScreenAvatar> createState() => _LoginScreenAvatarState();
}

class _LoginScreenAvatarState extends State<LoginScreenAvatar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topStart,
              children: [
                SizedBox(
                  height: 700,
                  width: 352,
                ),
                Image.asset(
                  'Assets/Group 481740.png',
                  width: 606.63,
                  height: 428.24,
                  fit: BoxFit.cover,
                ),
                const Positioned(
                  top: 160,
                  left: 10,
                  child: Text(
                    'Выбертие аватар персонажа',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3F414E),
                      fontSize: 26,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.05,
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  left: 5,
                  child: Transform.rotate(
                    angle: -3.14,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil('/Reg', (Route<dynamic> route) => false);
                      },
                      child: Container(
                        width: 55,
                        height: 55,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFEBEAEC)),
                            borderRadius: BorderRadius.circular(38),
                          ),
                        ),
                        child: Icon(Icons.arrow_forward),
                      ),
                    ),
                  ),
                ),
                Positioned(top: 230, left: 15, child: ImageSwitcher())
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomTextButton(
                      isActive: true,
                      text: 'НАЧАТЬ',
                      callback: () {Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);},
                      height: 46.37,
                      width: 162,
                      border: 18),
                  CustomTextButton(
                      isActive: false,
                      text: 'Тестирование',
                      callback: () {},
                      height: 46.37,
                      width: 162,
                      border: 18)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
