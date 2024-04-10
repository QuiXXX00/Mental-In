import 'package:flutter/material.dart';

import '../../auth/firebase/get_data.dart';



class Theory extends StatefulWidget {
  @override
  State<Theory> createState() => _TheoryState();
}

class _TheoryState extends State<Theory> {
  String username = '';
  @override
  void initState() {
    super.initState();
    GetData().getuser().then((v) {
      setState(() {
        username = v;
      });
    });}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theory Text'),
        ),
        body: Center(
          child: Text(
            'Theory $username',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
