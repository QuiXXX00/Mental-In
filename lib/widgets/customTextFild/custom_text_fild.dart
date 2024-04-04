import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,

    required this.text,
    required this.controller, required this.countCifra,
  }) : super(key: key);


  final String text;
  final TextEditingController controller;
  final int countCifra;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool showCheckIcon = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(textChanged);
    textChanged(); // Вызываем здесь, чтобы установить начальное значение для showCheckIcon
  }

  @override
  void dispose() {
    widget.controller.removeListener(textChanged);
    super.dispose();
  }

  void textChanged() {
    setState(() {
      showCheckIcon = widget.controller.text.length > widget.countCifra;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 63,
      child: TextField(
        style: TextStyle(color: const Color(0xFF3F414E)),
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFF2F3F7),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Color(0xFFACACAC)),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.white),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 1, color: Color(0xFFF2F3F7)),
            borderRadius: BorderRadius.circular(15),
          ),
          hintText: widget.text,
          hintStyle: const TextStyle(color: Color(0xFF3F414E)),
          prefixIcon: showCheckIcon ? const Icon(Icons.check, color: Colors.green) : null,
        ),
        controller: widget.controller,
      ),
    );
  }
}
