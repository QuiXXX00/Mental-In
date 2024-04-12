import 'package:flutter/material.dart';

// Модель для вопроса
class Question {
  final String text;
  final List<String> options;

  Question({required this.text, required this.options});
}

// Модель для ответа
class Answer {
  final String question;
  final String answer;

  Answer({required this.question, required this.answer});
}

class EysenckTestScreen extends StatefulWidget {
  @override
  _EysenckTestScreenState createState() => _EysenckTestScreenState();
}

class _EysenckTestScreenState extends State<EysenckTestScreen> {
  // Список вопросов
  List<Question> questions = [
    Question(
      text: 'Question 1: Yes/No',
      options: ['Yes', 'No'],
    ),
    Question(
      text: 'Question 2: Agree/Disagree',
      options: ['Agree', 'Disagree'],
    ),
  ];

  // Список ответов пользователя
  List<Answer> userAnswers = [];

  // Параметры результатов
  int param1 = 0;
  int param2 = 0;

  // Метод для сохранения ответа пользователя
  void saveAnswer(String question, String answer) {
    setState(() {
      userAnswers.add(Answer(question: question, answer: answer));
    });
  }

  // Метод для отображения результата теста
  void showResult() {
    // Вычисляем результат на основе ответов пользователя
    userAnswers.forEach((answer) {
      switch (answer.question) {
        case 'Question 1: Yes/No':
          if (answer.answer == 'Yes') {
            param1 += 1;
          }
          break;
        case 'Question 2: Agree/Disagree':
          if (answer.answer == 'Agree') {
            param2 += 1;
          }
          break;
      // Добавьте дополнительные случаи для других вопросов здесь
      }
    });

    // Отобразите результат на экране
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Test Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Parameter 1: $param1'),
              Text('Parameter 2: $param2'),
              // Добавьте дополнительные параметры и результаты здесь
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Eysenck Test'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          Question question = questions[index];
          return QuestionWidget(
            question: question,
            onSave: (answer) => saveAnswer(question.text, answer),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showResult,
        child: Icon(Icons.check),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final Question question;
  final Function(String) onSave;

  const QuestionWidget({Key? key, required this.question, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question.text),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: question.options.map((option) {
              return ElevatedButton(
                onPressed: () => onSave(option),
                child: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EysenckTestScreen(),
  ));
}
