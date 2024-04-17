import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';

class CustomContainerWidget extends StatefulWidget {
 CustomContainerWidget({
    Key? key,
    required this.text,
    required this.exp,
    required this.img,
    required this.isButtonPressed,
    required this.index,
    required this.doc,


  }) : super(key: key);

  final String text;
  final int exp;
  final String img;
  bool isButtonPressed;
  String index;
  var doc;




  @override
  _CustomContainerWidgetState createState() => _CustomContainerWidgetState();
}

class _CustomContainerWidgetState extends State<CustomContainerWidget> {


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 374,
      height: 80,
      decoration: ShapeDecoration(
        color: widget.isButtonPressed ? Colors.white : Color(0xFF8E97FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SvgPicture.network(
              widget.img,
              height: 58,
              width: 58,
              color: widget.isButtonPressed ? Colors.black :Colors.white,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(
                    color: widget.isButtonPressed ? Colors.black : Colors.white,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    height: 0,
                  ),
                ),
                Text(
                  '${widget.exp} exp',
                  style: TextStyle(
                    color: widget.isButtonPressed ? Colors.black : Colors.white,
                    fontSize: 12,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w300,
                    height: 0,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  User? user = FirebaseAuth.instance.currentUser;

                      var snap = FirebaseFirestore.instance
                          .collection('userProfile/${user?.uid}/isUncomplitTasks')
                          .get()
                          .then((docSnapshot) {

                        FirebaseFirestore.instance
                            .collection('userProfile/${user?.uid}/isComplitTasks')
                            .doc(widget.index)
                            .set({
                          'isComplit': false,
                          'exp': docSnapshot.docs[widget.doc]
                              .get('exp'),
                          'imgurl': docSnapshot.docs[widget.doc]
                              .get('imgurl'),
                          'name': docSnapshot.docs[widget.doc]
                              .get('name'),
                        }, SetOptions(merge: true));
                        //widget.Totalexp += int.parse(docSnapshot.docs[widget.doc]
                        //    .get('exp'));
                        //widget.callback(int.parse(docSnapshot.docs[widget.doc]
                       //     .get('exp')));
                      });
                    CollectionReference ref = FirebaseFirestore.instance
                        .collection('userProfile/${user?.uid}/isUncomplitTasks');
                    ref.doc(widget.index).delete();
                });
              },
              icon: SvgPicture.asset(
                widget.isButtonPressed ? 'Assets/icons/unCheck.svg' : 'Assets/icons/check.svg',
                height: 24,
                width: 24,
                color:  widget.isButtonPressed ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
