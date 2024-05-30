import 'dart:async';
import 'package:flutter/material.dart';
import 'package:smart/utils/AppTypography.dart';
import 'package:smart/utils/colors2.dart';

class BreathingExerciseScreen extends StatefulWidget {
  @override
  _BreathingExerciseScreenState createState() =>
      _BreathingExerciseScreenState();
}

class _BreathingExerciseScreenState extends State<BreathingExerciseScreen> {
  int _secondsRemaining = 60; // Общее время упражнения в секундах
  int _currentCircle = 0; // Текущий заполняемый круг

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          if (_secondsRemaining % 4 == 0) {
            _currentCircle = (_currentCircle + 1) %
                4; // Переход к следующему кругу каждые 4 секунды
          }
        } else {
          timer.cancel();
          // После завершения таймера переход на экран "Молодец"
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WellDoneScreen()),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Дыхательное упражнение'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: AppColors.violet,
                  width: 3,
                ),
              ),
              child: Center(
                child: Text(
                  _getTextForIndex(_currentCircle),
                  style: TextStyle(fontSize: 24, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < 4; i++) _buildCircle(i),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 50,
                  Icons.timer,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$_secondsRemaining',
                    style: TextStyle(fontSize: 50, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircle(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
        _currentCircle == index ? AppColors.violet : Colors.white,
        border: Border.all(
          color: _currentCircle == index ? Colors.black : Colors.black,
          width: 1,
        ),
      ),
    );
  }

  String _getTextForIndex(int index) {
    switch (index) {
      case 0:
        return 'Вдох';
      case 1:
        return 'Задержка';
      case 2:
        return 'Выдох ';
      case 3:
        return 'Пауза';
      default:
        return '';
    }
  }
}

class WellDoneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Молодец!'),
      ),
      body: Center(
        child: Text(
          'Поздравляю! Вы завершили дыхательное упражнение.',
          style: AppTypography.AppBarText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
