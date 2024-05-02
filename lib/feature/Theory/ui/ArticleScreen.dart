import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'package:smart/feature/auth/firebase/get_data.dart';


import '../../../utils/AppTypography.dart';

class ArticleScreen extends StatefulWidget {
  final String txt;
  final String description;

  const ArticleScreen({
    Key? key,
    required this.txt,
    required this.description,
  }) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  String articleText = ' ';
  late ScrollController _scrollController;
  double _scrollPosition = 0;
   int? texts;
  _scrollListener() {
    setState(() {
      _scrollPosition = _scrollController.position.pixels;
      if(_scrollPosition == _scrollController.position.maxScrollExtent && texts! < 3){
        var user = FirebaseAuth.instance.currentUser;
        CollectionReference ref =
        FirebaseFirestore.instance.collection('userProfile');
        ref.doc(user!.uid).set({'CountTexts': texts!+1 },SetOptions(merge: true));
      }
    });

  }

  @override
  void initState() {
    super.initState();
    _loadArticleText();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    GetData().getuser().then((v){texts = v;});
  }

  Future<void> _loadArticleText() async {
    String text = await rootBundle.loadString('Assets/text/${widget.txt}');
    setState(() {
      articleText = text;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  Navigator.pop(context);
                },
                child: Ink(
                  width: 30,
                  height: 30,
                  child: Icon(
                    Icons.arrow_back,
                    size: 20,
                  ),
                  decoration: ShapeDecoration(
                    color: Color(0xFF8E97FD),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              ),
              Text('${widget.description}', style: AppTypography.AppBarText),
              SizedBox(
                width: 30,
                height: 30,
              )
            ],
          ),
        ),
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            controller: _scrollController,
            padding: EdgeInsets.all(16.0),
            child: Text(
              textAlign: TextAlign.justify, // Выравнивание текста
              articleText.isNotEmpty ? articleText : 'Загрузка...',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          );
        }
      ),
    );
  }
}
