import 'package:flutter/material.dart';

class ImageSwitcher extends StatefulWidget {
  @override
  _ImageSwitcherState createState() => _ImageSwitcherState();
}

class _ImageSwitcherState extends State<ImageSwitcher> {
  int selectedIndex = 0;
  final List<String> imagePaths = [
    'Assets/CHIBI1.png',
    'Assets/CHIBI2.png',
    'Assets/CHIBI3.png',
    'Assets/CHIBI4.png'
  ];

  void switchImage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 352,
      height: 394,
      decoration: ShapeDecoration(
        color: Color(0xFF8E97FD),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
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
      child: Stack(
        children: [
          Positioned(
            top: (394 - 287) / 2,
            left: (352 - 156) / 2,
            child: Image.asset(
              imagePaths[selectedIndex],
              width: 156,
              height: 287,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                switchImage((selectedIndex - 1) % imagePaths.length);
              },
              child: Transform.rotate(
                angle: -3.14,
                child: Container(
                  width: 41,
                  height: 41,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFEBEAEC)),
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ),
                  child: const Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
          Positioned(
            right: 10,
            bottom: 10,
            child: GestureDetector(
              onTap: () {
                switchImage((selectedIndex + 1) % imagePaths.length);
              },
              child: Transform.rotate(
                angle: -3.14,
                child: Container(
                  width: 41,
                  height: 41,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: Color(0xFFEBEAEC)),
                      borderRadius: BorderRadius.circular(38),
                    ),
                  ),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
            ),
          ),
          Positioned(
            left: 160,
            bottom: 30,
            child: Container(
              width: 26,
              height: 5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  imagePaths.length,
                      (index) => Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedIndex == index ? Color(0xFF3F414E) : Color(0x993F414E),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: ImageSwitcher(),
    ),
  ));
}
