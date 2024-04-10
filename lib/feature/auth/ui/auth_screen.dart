import 'dart:developer';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/widgets/BottomSheet/snackbar.dart';
import 'package:smart/widgets/buttons/custom_text_batton.dart';
import 'package:smart/widgets/customTextFild/custom_text_fild_Password.dart';

import '../../../widgets/buttons/text_button_gradient.dart';
import '../../../widgets/customTextFild/custom_text_fild.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController mailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    passwordController.dispose();
    mailController.dispose();

    super.dispose();
  }
  Future<void> auth() async{
    final navigator = Navigator.of(context);
    final isValid = formKey.currentState!.validate();

    if(!isValid) return;

    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mailController.text.trim(),
        password: passwordController.text.trim(),);
    }on FirebaseAuthException catch(e){

      if (e.code == 'invalid-credential'){
        SnackBarService.showSnackBar(context, 'Неправильный email или пароль.', true);
        return;
      }else {
        SnackBarService.showSnackBar(context, 'Неизвестная ошибка! Попробуйте еше раз.', true);
      return;}

    }
    navigator.pushNamedAndRemoveUntil('/bp', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Image.asset(
                      'Assets/Group 481740.png',
                      width: 606.63,
                      height: 428.24,
                      fit: BoxFit.cover,
                    ),
                    const Positioned(
                      top: 160,

                      child: Text(
                        'С возвращением',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF3F414E),
                          fontSize: 28,
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
                            Navigator.of(context).pushNamedAndRemoveUntil('/Well', (Route<dynamic> route) => false);
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

                  ],
                ),
                const SizedBox(height: 20),
                const Center(
                  child: SizedBox(
                    width: 205,
                    height: 14,
                    child: Text(
                      'ВОЙТИ С ПОМОЩЬЮ EMAIL',
                      style: TextStyle(
                        color: Color(0xFFA1A4B2),
                        fontSize: 14,
                        fontFamily: 'Helvetica',
                        fontWeight: FontWeight.w700,
                        height: 0.08,
                        letterSpacing: 0.70,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  countCifra: 5,
                  text: 'Email',
                  controller: mailController,
                  validator: (email)=> email != null && !EmailValidator.validate(email)
                  ? 'Введите правильный email': null,
                ),
                SizedBox(height: 10),
                PasswordTextField(
                  text: 'Пароль',
                  text1: 'Пароль',
                  controller: passwordController,
                  validator: (value) => value != null && value.length  <6
                  ? 'Минимум 6 символов' : null,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                    isActive: true,
                    text: 'Войти',
                    callback: auth,
                    height: 63,
                    width: 374,
                    border: 38)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
