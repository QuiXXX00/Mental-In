import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBarAvatar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: (){ Navigator.pushReplacementNamed(context, '/profile');},
              child: CircleAvatar(
                backgroundImage: AssetImage('Assets/Profile.png'),
                radius: 18,
                backgroundColor: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

