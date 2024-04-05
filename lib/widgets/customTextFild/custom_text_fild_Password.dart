import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField({
    Key? key,
    required this.text,
    required this.text1,
    required this.controller,
    required this.validator
  }) : super(key: key);

  final String text;
  final String text1;
  final TextEditingController controller;
  String? Function(String?) validator;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63,
      child: TextFormField(
        obscureText: !showPassword, // Показывать или скрывать пароль
        style: TextStyle(color: const Color(0xFF3F414E)),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF2F3F7),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFFA1A4B2)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFFF2F3F7)),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: widget.text1,
          hintStyle: const TextStyle(color: Color(0xFF3F414E)),
          suffixIcon: IconButton(
            icon: Icon(showPassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
          ),
        ),
        controller: widget.controller,
        validator: widget.validator,
      ),
    );
  }
}
