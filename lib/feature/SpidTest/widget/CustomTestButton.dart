import 'package:flutter/material.dart';

import '../../../utils/colors2.dart';

class TestContainerWidget extends StatelessWidget {
  final String title;
  final String description;
  final Function() onTap;
  final String time;

  const TestContainerWidget({
    Key? key,
    required this.title,
    required this.time,
    required this.onTap,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: AppColors.pageBackground,
      onTap: onTap,
      child: Ink(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFF8E97FD),
          borderRadius: BorderRadius.circular(10),
          image: const DecorationImage(
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
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
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
                        borderRadius: BorderRadius.circular(99)),
                    child: Center(
                      child: Text(
                        '$time',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 8,
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
                  description,
                  style: const TextStyle(
                    color: Color(0xFF161616),
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
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
