import 'package:flutter/material.dart';

class CustomSliverAppBarAvatar extends StatelessWidget {
  const CustomSliverAppBarAvatar({Key? key, required this.text})
      : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      expandedHeight: kToolbarHeight,
      flexibleSpace: Container(
        margin: EdgeInsets.only(top: 20),

        child: Center(
          child: Padding(
            padding: const EdgeInsets.only( left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
                  child: CircleAvatar(
                    backgroundImage: AssetImage('Assets/Profile.png'),
                    radius: 18,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: Color(0xFF3F414E),
                    fontSize: 28,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0.04,
                  ),
                ),
                SizedBox(
                  width: 18,
                  height: 18,
                )
              ],
            ),
          ),
        ),
      ),
      // чтобы SliverAppBar оставался видимым при прокрутке
      floating:
          true, // чтобы SliverAppBar появлялся сверху, когда вы прокручиваете вниз
    );
  }
}
