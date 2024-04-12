import 'package:flutter/material.dart';

class TestContainerWidget extends StatelessWidget {
  final String title;
  final Function() onTap;
  final String time;



  const TestContainerWidget({
    Key? key, required this.title, required this.time, required this.onTap,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(

        width: double.infinity,
        height: 136,
        decoration: BoxDecoration(
          color: Color(0xFF8E97FD),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage('Assets/Group 481742.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(21),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 243,
                    height: 32.93,
                    child: Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF8E97FD),
                        borderRadius: BorderRadius.circular(99)
                    ),
                    child: Center(
                      child: Text(
                        '$timeмин',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 6,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                width: 343,
                child: Text(
                  'хуйня для описания, ты про плюсы большого челена?',
                  style: TextStyle(
                    color: Color(0xFF161616),
                    fontSize: 8,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
