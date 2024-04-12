import 'package:flutter/material.dart';
import 'package:smart/utils/AppTypography.dart';
import '../../../widgets/bar/AppBarAvatar.dart';
import '../../../widgets/buttons/custom_text_batton.dart';
import '../questions.dart'; // Импортируйте список вопросов

class EysenckTestScreen extends StatefulWidget {
  @override
  _EysenckTestScreenState createState() => _EysenckTestScreenState();
}

class _EysenckTestScreenState extends State<EysenckTestScreen> {
  // Хранилище ответов
  Map<int, bool> answers = {};

  void onAnswerSelected(int index, bool answer) {
    setState(() {
      answers[index] = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    int answeredQuestionsCount = answers.length;
    int totalQuestionsCount = questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Personality Test ($answeredQuestionsCount/$totalQuestionsCount)',
          style: AppTypography.AppBarText,
        ),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return QuestionTile(
            question: questions[index],
            isAnswered: answers.containsKey(index),
            onAnswerSelected: (answer) => onAnswerSelected(index, answer),
            answer: answers[index],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (answeredQuestionsCount == totalQuestionsCount) {
            // Показываем результаты
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(answers: answers),
              ),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class QuestionTile extends StatelessWidget {
  final String question;
  final bool isAnswered;
  final Function(bool) onAnswerSelected;
  final bool? answer;

  QuestionTile({
    required this.question,
    required this.isAnswered,
    required this.onAnswerSelected,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF8E97FD),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          question,
          style: AppTypography.f14w400,
        ),
        trailing: isAnswered
            ? answer != null
            ? answer!
            ? Icon(
          Icons.check_circle,
          color: Color(0xFF2FEA9B),
          size: 30,
        ) // Ответ "Да"
            : Icon(
          Icons.cancel,
          color: Colors.red,
          size: 30,
        ) // Ответ "Нет"
            : null
            : null,
        onTap: () {
          if (!isAnswered) {
            // Показываем диалог выбора ответа
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text(question),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onAnswerSelected(true);
                        },
                        child: Text('Да'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          onAnswerSelected(false);
                        },
                        child: Text('Нет'),
                      ),
                    ],
                  ),
            );
          }
        },
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final Map<int, bool> answers;

  ResultScreen({required this.answers});

  @override
  Widget build(BuildContext context) {
    // Логика для подсчета результатов и определения темперамента пользователя
    int extraversionScore = 0;
    int neuroticismScore = 0;

    // Считаем очки
    answers.forEach((index, answer) {
      if (index == 0 ||
          index == 2 ||
          index == 7 ||
          index == 9 ||
          index == 12 ||
          index == 16 ||
          index == 21 ||
          index == 24 ||
          index == 26 ||
          index == 38 ||
          index == 43 ||
          index == 45 ||
          index == 48 ||
          index == 52 ||
          index == 56) {
        if (answer) {
          extraversionScore++;
        }
      } else if (index == 1 ||
          index == 3 ||
          index == 6 ||
          index == 8 ||
          index == 10 ||
          index == 13 ||
          index == 15 ||
          index == 18 ||
          index == 20 ||
          index == 23 ||
          index == 25 ||
          index == 27 ||
          index == 30 ||
          index == 32 ||
          index == 36 ||
          index == 40 ||
          index == 42 ||
          index == 47 ||
          index == 49 ||
          index == 51 ||
          index == 55) {
        if (answer) {
          neuroticismScore++;
        }
      }
    });

    // Определяем темперамент пользователя
    String extraversionResult = '';
    String neuroticismResult = '';

    if (extraversionScore > 19) {
      extraversionResult = 'Яркий экстраверт';
    } else if (extraversionScore > 15) {
      extraversionResult = 'Экстраверт';
    } else if (extraversionScore > 12) {
      extraversionResult = 'Склонность к экстраверсии';
    } else if (extraversionScore < 12 && extraversionScore > 9) {
      extraversionResult = 'Среднее значение';
    } else if (extraversionScore < 9 && extraversionScore > 5) {
      extraversionResult = 'Склонность к интроверсии';
    } else if (extraversionScore < 5) {
      extraversionResult = 'Глубокий интроверт';
    }

    if (neuroticismScore > 19) {
      neuroticismResult = 'Очень высокий уровень нейротизма';
    } else if (neuroticismScore > 13) {
      neuroticismResult = 'Высокий уровень нейротизма';
    } else if (neuroticismScore > 9) {
      neuroticismResult = 'Среднее значение';
    } else if (neuroticismScore < 9) {
      neuroticismResult = 'Низкий уровень нейротизма';
    }

    return Scaffold(
      appBar: CustomAppBarAvatar(text: 'Результат',),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [


              Container(
                decoration: ShapeDecoration(
                  color: Color(0xFF8E97FD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 97,
                        height: 90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('Assets/amico.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text(
                          'Тест Айзенка был разработан автором в 1963 году и приобрел популярность, как опросник «EPI». Он способен определить нейропсихическую лабильность, экстраверсию – интроверсию. В 1968г. к нему была добавлена шкала психотизма. С тех пор адаптированный тест Айзенка известен миру, как опросник «EPQ»(его иногда называют «PEN»).'),
                      SizedBox(
                        height: 20,
                      ),

                      RichText(
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                              text: 'Темперамент по шкале экстраверсии: ',
                              style:
                              AppTypography.f14w400.copyWith(color: Colors
                                  .black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '$extraversionResult',
                                    style: AppTypography.f14w400.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                              ])),

                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                              text: 'Темперамент по шкале нейротизма: ',
                              style:
                              AppTypography.f14w400.copyWith(color: Colors
                                  .black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '$neuroticismResult',
                                    style: AppTypography.f14w400.copyWith(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                              ])),


                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: CustomTextButton(
                  isActive: true,
                  text: 'Понял',
                  callback: () {
                    Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil('/bp', (route) => false);
                  },
                  height: 42,
                  width: 288.14,
                  border: 10,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
