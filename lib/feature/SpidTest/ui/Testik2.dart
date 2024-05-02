import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/utils/AppTypography.dart';
import '../../../widgets/bar/AppBarAvatar.dart';
import '../../../widgets/buttons/custom_text_batton.dart';
import '../../auth/firebase/get_data.dart';

class PsychologicalAgeTestScreen extends StatefulWidget {
  @override
  _PsychologicalAgeTestScreenState createState() =>
      _PsychologicalAgeTestScreenState();
}

class _PsychologicalAgeTestScreenState
    extends State<PsychologicalAgeTestScreen> {
  int totalQuestionsCount = psychologicalAgeQuestions.length;

  // Хранилище ответов
  Map<int, String> answers = {};

  void onAnswerSelected(int index, String answer) {
    setState(() {
      answers[index] = answer;
    });
  }

  @override
  Widget build(BuildContext context) {
    int answeredQuestionsCount = answers.length;
    int totalQuestionsCount = psychologicalAgeQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Тест на возраст ($answeredQuestionsCount/$totalQuestionsCount)',
          style: AppTypography.AppBarText,
        ),
      ),
      body: ListView.builder(
        itemCount: psychologicalAgeQuestions.length,
        itemBuilder: (context, index) {
          return QuestionTile(
            question: psychologicalAgeQuestions[index]['question'],
            options: psychologicalAgeQuestions[index]['options'],
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
            String result = calculatePsychologicalAge(answers);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(result: result),
              ),
            );
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }

  String calculatePsychologicalAge(Map<int, String> answers) {
    int countA = 0;
    int countB = 0;
    int countC = 0;

    answers.values.forEach((answer) {
      if (answer == 'A') {
        countA++;
      } else if (answer == 'B') {
        countB++;
      } else if (answer == 'C') {
        countC++;
      }
    });

    if (countA > countB && countA > countC) {
      return 'Подросток: Юный и стремящийся найти свое место в мире, подросток испытывает смешанные чувства независимости и зависимости. Характеризуется эмоциональной нестабильностью, стремлением к самоутверждению и исследованию собственной личности.';
    } else if (countB > countA && countB > countC) {
      return countB > (totalQuestionsCount * 0.9)
          ? 'Прелестный малыш: Чистое и невинное существо, прелестный малыш олицетворяет радость и чудо в мире. Он или она полны любопытства, энергии и радости, ищут защиты и заботы от окружающих.'
          : 'Ребенок: Полный невинности и удивления, ребенок является символом надежды и возможностей. Он или она зависят от взрослых, чтобы удовлетворить свои потребности и обеспечить безопасность, в то же время находя радость в игре и воображении';
    } else {
      return countC > (totalQuestionsCount * 0.9)
          ? 'Суперстар: Излучая магнетизм и обаяние, суперстар привлекает внимание и восхищение окружающих. Он или она обладают уверенностью и талантом, стремясь к достижению выдающихся результатов в своей области.'
          : 'Взрослый: Ответственный и самостоятельный, взрослый обладает зрелостью и опытом. Он или она принимают решения, основанные на личных и профессиональных ценностях, и стремятся к самореализации и достижению успеха в жизни.';
    }
  }
}

class QuestionTile extends StatelessWidget {
  final String question;
  final List<String> options;
  final bool isAnswered;
  final Function(String) onAnswerSelected;
  final String? answer;

  QuestionTile({
    required this.question,
    required this.options,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: AppTypography.f14w400,
          ),
          SizedBox(height: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: options.map((option) {
              return RadioListTile(
                activeColor: Colors.white,
                title: Text(
                  option,
                  style: AppTypography.f14w400,
                ),
                value: option,
                groupValue: answer,
                onChanged: (String? value) {
                  onAnswerSelected(value!);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class ResultScreen extends StatefulWidget {
  final String result;

  ResultScreen({required this.result});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int? tests;

  @override
  void initState() {
    super.initState();

    GetData().getuser1().then((v) {
      tests = v;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarAvatar(
        text: 'Результат',
      ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          'Тест для определения психологического возраста позволяет оценить самоощущение и психологический тонус кандидата или сотрудника',
                          style: AppTypography.f14w400.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                              text: 'Ваш психологический возраст: ',
                              style: AppTypography.f14w400
                                  .copyWith(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${widget.result}',
                                    style: AppTypography.f14w400
                                        .copyWith(color: Colors.black))
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
                    var user = FirebaseAuth.instance.currentUser;
                    CollectionReference ref =
                        FirebaseFirestore.instance.collection('userProfile');
                    ref.doc(user!.uid).set(
                        {'Tests': tests! + 1}, SetOptions(merge: true));
                    Navigator.of(context, rootNavigator: true)
                        .pushNamedAndRemoveUntil('/bp', (route) => false);
                  },
                  height: 42,
                  width: 288.14,
                  border: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Список вопросов для теста на психологический возраст
List<Map<String, dynamic>> psychologicalAgeQuestions = [
  {
    'question': 'Вам нравится ваше тело?',
    'options': [
      'А. Честно говоря, мне есть по поводу чего комплексовать (у меня достаточно много несовершенств).',
      'Б. Чаще нет.',
      'В. Да, я смирилась со своими недостатками.'
    ]
  },
  {
    'question': 'Вам нравится ваша работа?',
    'options': [
      'А. Мне нравится то, чем я занимаюсь.',
      'Б. Не люблю работать.',
      'В. Не всегда, но бывают моменты, когда очень нравится (такое случается редко).'
    ]
  },
  {
    'question': 'Если у вас что-нибудь получается:',
    'options': [
      'А. У вас повышается самооценка.',
      'Б. Вы испытываете удивление и радость.',
      'В. Для вас это само собой разумеющийся факт.'
    ]
  },
  {
    'question': 'Если вам надо срочно решить серьезный деловой вопрос, вы:',
    'options': [
      'А. Стараетесь решить его самостоятельно в сжатые сроки.',
      'Б. Просите помощи у других или перекладываете ответственность на чужие плечи.',
      'В. Откладываете его решение ненадолго, чтобы прийти к правильным выводам и выработать дальнейшую тактику ведения дела.'
    ]
  },
  {
    'question': 'Вы получаете очень хорошее известие. В первый момент вы:',
    'options': [
      'А. Делаете вид, что для вас это не важно.',
      'Б. Не можете в это поверить.',
      'В. Чувство радости переполняет вас.'
    ]
  },
  {
    'question': 'Часто ли вы вините себя в жизненных провалах?',
    'options': [
      'А. Редко.',
      'Б. Во всех моих бедах виноваты жизненные обстоятельства, иногда окружающие, только не я сам.',
      'В. Бывает иногда.'
    ]
  },
  {
    'question': 'Когда вы получаете зарплату, вы:',
    'options': [
      'А. Идете по магазинам.',
      'Б. Раздаете долги.',
      'В. Откладываете сразу часть денег на счет, который ежемесячно пополняете.'
    ]
  },
  {
    'question': 'Заболев хроническим недугом, вы:',
    'options': [
      'А. Сами стараетесь сделать все для выздоровления.',
      'Б. Вас это мало беспокоит, оставляете все, как есть.',
      'В. Ходите по врачам и аптекам.'
    ]
  },
  {
    'question': 'Какая фраза вам ближе?',
    'options': [
      'А. Все хорошо, что хорошо кончается.',
      'Б. Принять все, как есть.',
      'В. Все, что ни делается, к лучшему.'
    ]
  },
  {
    'question': 'У вас есть мечта?',
    'options': [
      'А. Я предпочитаю строить планы на жизнь, а не витать в облаках.',
      'Б. Да, я люблю мечтать.',
      'В. Нет. Все, о чем мечтал, уже реализовано.'
    ]
  },
];
