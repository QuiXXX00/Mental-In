import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/feature/auth/firebase/save_data.dart';
import 'package:smart/widgets/buttons/custom_text_batton.dart';
import 'package:smart/widgets/customTextFild/custom_text_fild_Password.dart';

import '../../../widgets/BottomSheet/snackbar.dart';
import '../../../widgets/buttons/text_button_gradient.dart';
import '../../../widgets/customTextFild/custom_text_fild.dart';
import '../firebase/get_data.dart';

class RegestrationScreen extends StatefulWidget {
  RegestrationScreen({super.key});

  @override
  State<RegestrationScreen> createState() => _RegestrationScreenState();
}

class _RegestrationScreenState extends State<RegestrationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  List<String> listOfTasks=[];
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    emailController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    GetData().getinfo().then((List<String> value) => setState(() {
      listOfTasks = value;
    }));
    setState(() {

      StoreData().dataupload(listOfTasks);
    });
  }

  Future<void> reg() async {
    final navigator = Navigator.of(context);
    final isValid = formKey.currentState!.validate();

    if (!isValid) return;

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      StoreData().postDetailsToFirestore(nameController.text.trim());
      StoreData().dataupload(listOfTasks);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
            context, 'Пользователь с таким email уже зарегистрирован.', true);
        return;
      } else {
        SnackBarService.showSnackBar(
            context, 'Неизвестная ошибка! Попробуйте еше раз.', true);
        return;
      }
    }
    navigator.pushNamedAndRemoveUntil('/Reg2', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Поднимает содержимое при открытии клавиатуры

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
                        'Создайте новый аккаунт',
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
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/Well', (Route<dynamic> route) => false);
                          },
                          child: Container(
                            width: 55,
                            height: 55,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFEBEAEC)),
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
                    width: 260,
                    height: 14,
                    child: Text(
                      'РЕГИСТРАЦИЯ С ПОМОШЬЮ EMAIL',
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
                const SizedBox(height: 20),
                CustomTextField(
                  countCifra: 5,
                  text: 'Имя пользователя',
                  controller: nameController,
                  validator: (value) => value != null && value.length < 0
                      ? 'Имя не может быть пустым'
                      : null,

                  // Устанавливает фокус на это поле при открытии экрана
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  countCifra: 5,
                  text: 'Email',
                  controller: emailController,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Введите правильный email'
                          : null,
                ),
                SizedBox(height: 10),
                PasswordTextField(
                  text: 'Пароль',
                  text1: 'Пароль',
                  controller: passwordController,
                  validator: (value) => value != null && value.length < 6
                      ? 'Минимум 6 символов'
                      : null,
                ),
                SizedBox(height: 10),
                CustomTextButton(
                    isActive: true,
                    text: 'Зарегистрироваться',
                    callback: reg,
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
