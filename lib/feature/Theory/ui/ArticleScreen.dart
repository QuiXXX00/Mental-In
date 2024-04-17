import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class ArticleScreen extends StatefulWidget {
  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String articleText = ' ';

  @override
  void initState() {
    super.initState();
    _loadArticleText();
  }

  Future<void> _loadArticleText() async {
    String text = await rootBundle.loadString('Assets/text/ssss.txt');
    setState(() {
      articleText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Статья “Как побороть стресс”',style: TextStyle(
          color: Colors.black,
          fontSize: 16,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w400,
        ),),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          articleText.isNotEmpty ? articleText : 'Загрузка...',
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

