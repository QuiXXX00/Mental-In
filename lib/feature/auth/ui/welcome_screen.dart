import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../utils/AppTypography.dart';
import '../../../widgets/buttons/custom_text_batton.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height - 105,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('Assets/Vector_Main_Screen.png'),
                    fit: BoxFit.cover)),
            child: const Padding(
              padding: EdgeInsets.only(top: 115),
              child: Text(
                'Mental In',
                textAlign: TextAlign.center,
                style: AppTypography.font14white,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 105,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButton(
                    isActive: true,
                    height: 52,
                    width: 167,
                    text: 'Войти',
                    callback: () {
                      Navigator.pushNamed(context, '/Auth');
                    }, border: 21,),
                const SizedBox(
                  width: 13,
                ),
                CustomTextButton(
                    isActive: false,
                    height: 52,
                    width: 167,
                    text: 'Регистрация',
                    callback: () {
                      Navigator.pushNamed(context, '/Reg');
                    }, border: 21,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
