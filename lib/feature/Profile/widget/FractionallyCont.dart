import 'package:flutter/material.dart';

class MeditationWidget extends StatelessWidget {
  const MeditationWidget({
    Key? key,
    required this.text,
    required this.description,
    required this.count,
    required this.currentCount,
  }) : super(key: key);

  final String text;
  final String description;
  final int count;
  final int currentCount;

  @override
  Widget build(BuildContext context) {
    // Рассчитываем процент выполнения задачи
    final double progressPercentage = currentCount / count;
    // Определяем, достигнут ли максимальный прогресс
    final bool isMaxProgress = currentCount >= count;

    return Container(
      width: double.infinity,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Container(
              width: 46,
              height: 46,
              decoration: ShapeDecoration(
                color: isMaxProgress ? Colors.green : Color(0xFF8E97FD),
                shape: isMaxProgress ? CircleBorder() : OvalBorder(),
              ),
              child: Center(
                child: isMaxProgress
                    ? Icon(Icons.check, color: Colors.white, size: 30)
                    : Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w900,
                    height: 0,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: isMaxProgress ? Colors.green : Color(0xFF8E97FD),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Text(
                  '$description ${isMaxProgress ? count : currentCount} раз',
                  style: TextStyle(
                    color: isMaxProgress ? Colors.green : Color(0xFF8E97FD),
                    fontSize: 11,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 220,
                      height: 12.98,
                      decoration: ShapeDecoration(
                        color: isMaxProgress ? Colors.green : Color(0xFF8E97FD),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor:
                        isMaxProgress ? 1.0 : progressPercentage,
                        child: Container(
                          decoration: ShapeDecoration(
                            color: isMaxProgress ? Colors.green : Color(0xFF6C78FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Добавляем горизонтальный отступ между прогресс-баром и текстом
                  ],
                ),
                Text(
                  '${isMaxProgress ? count : currentCount}/$count',
                  style: TextStyle(
                    color: isMaxProgress ? Colors.green : Colors.black,
                    fontSize: 10,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
