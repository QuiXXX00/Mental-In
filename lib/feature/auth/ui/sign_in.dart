import 'package:flutter/material.dart';
import 'package:smart/widgets/buttons/custom_text_batton.dart';
import 'package:smart/widgets/customTextFild/custom_text_fild_Password.dart';

import '../../../widgets/buttons/text_button_gradient.dart';
import '../../../widgets/customTextFild/custom_text_fild.dart';

class SeginInScreen extends StatefulWidget {
  SeginInScreen({super.key});

  @override
  State<SeginInScreen> createState() => _SeginInScreenState();
}

class _SeginInScreenState extends State<SeginInScreen> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // Поднимает содержимое при открытии клавиатуры
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 474.14,
                  height: 334.71,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('Assets/Group 481739.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 188.54,
                  height: 14,
                  child: Text(
                    'OR LOG IN WITH EMAIL',
                    style: TextStyle(
                      color: Color(0xFFA1A4B2),
                      fontSize: 14,
                      fontFamily: 'HelveticaNeue',
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
                text: 'Email address',
                controller: mailController,
              ),
              SizedBox(height: 10),
              PasswordTextField(
                text: 'Password',
                text1: 'Password',
                controller: passwordController,
              ),
              SizedBox(height: 10),
              CustomTextButton(
                  isActive: true,
                  text: 'LOG IN',
                  callback: () {},
                  height: 63,
                  width: 374,
                  border: 38)
            ],
          ),
        ),
      ),
    );
  }
}
