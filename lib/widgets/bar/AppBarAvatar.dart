import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomAppBarAvatar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarAvatar({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      title: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            InkWell(
              onTap: (){ Navigator.of(context, rootNavigator: true).pushNamed('/profile');},
              child: CircleAvatar(
                backgroundImage: AssetImage('Assets/Profile.png'),
                radius: 18,
                backgroundColor: Colors.transparent,
              ),
            ),
            Text(text,style: TextStyle(
              color: Color(0xFF3F414E),
              fontSize: 28,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0.04,
            ),),
            SizedBox(width:18 ,height: 18,)
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

