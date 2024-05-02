import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/utils/AppTypography.dart';

import '../../feature/auth/firebase/get_data.dart';

class CustomAppBarAvatar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBarAvatar({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  State<CustomAppBarAvatar> createState() => _CustomAppBarAvatarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarAvatarState extends State<CustomAppBarAvatar> {
  final String background_profile_img =
      'https://www.dentalxp.com/_next/image?url=%2F_next%2Fstatic%2Fmedia%2Fuser-placeholder.9fc8def1.png&w=1920&q=75';
  List<String> users = [];

  @override
  void initState() {
    super.initState();
    GetData().getusers().then((List<String> value) => setState(() {
          users = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context, rootNavigator: true)
                    .pushNamed('/profile');
              },
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('userProfile')
                      .snapshots(),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundImage:  NetworkImage(snapshot
                              .data!.docs[users.indexOf(user!.uid)]
                              .get('Profileimg')),
                      radius: 18,
                      backgroundColor: Colors.white,
                    );
                  }),
            ),
            Text(widget.text, style: AppTypography.AppBarText),
            const SizedBox(
              width: 18,
              height: 18,
            )
          ],
        ),
      ),
    );
  }
}
