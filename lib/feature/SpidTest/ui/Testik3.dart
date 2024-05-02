import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart/utils/AppTypography.dart';
import '../../../widgets/bar/AppBarAvatar.dart';
import '../../../widgets/buttons/custom_text_batton.dart';
import '../../auth/firebase/get_data.dart';

class AnxietyTestScreen extends StatefulWidget {
  @override
  _AnxietyTestScreenState createState() => _AnxietyTestScreenState();
}

class _AnxietyTestScreenState extends State<AnxietyTestScreen> {
  int totalQuestionsCount = situationalAnxietyQuestions.length + personalityAnxietyQuestions.length;
  Map<int, int> situationalAnswers = {};
  Map<int, int> personalityAnswers = {};

  void onAnswerSelected(int index, int answer, bool isSituational) {
    setState(() {
      if (isSituational) {
        situationalAnswers[index] = answer;
      } else {
        personalityAnswers[index] = answer;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int situationalAnsweredQuestionsCount = situationalAnswers.length;
    int personalityAnsweredQuestionsCount = personalityAnswers.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Тест на тревожность ($situationalAnsweredQuestionsCount + $personalityAnsweredQuestionsCount/$totalQuestionsCount)',
          style: AppTypography.AppBarText,
        ),
      ),
      body: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(child: Text('КАК ВЫ СЕБЯ ЧУВСТВУЕТЕ В ДАННЫЙ МОМЕНТ',style: AppTypography.AppBarText,)),
          ),
          _buildQuestionList(
            questions: situationalAnxietyQuestions,
            answers: situationalAnswers,
            isSituational: true,
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(child: Text('КАК ВЫ СЕБЯ ЧУВСТВУЕТЕ ОБЫЧНО',style: AppTypography.AppBarText,)),
          ),

          _buildQuestionList(
            questions: personalityAnxietyQuestions,
            answers: personalityAnswers,
            isSituational: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (situationalAnsweredQuestionsCount + personalityAnsweredQuestionsCount == totalQuestionsCount) {
            // Показываем результаты
            int situationalScore = calculateScore(situationalAnswers);
            int personalityScore = calculateScore(personalityAnswers);
            String situationalInterpretation = interpretScore(situationalScore);
            String personalityInterpretation = interpretScore(personalityScore);

            String result = 'Ситуативная тревожность: $situationalInterpretation\nЛичностная тревожность: $personalityInterpretation';

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

  Widget _buildQuestionList({
    required List<Map<String, dynamic>> questions,
    required Map<int, int> answers,
    required bool isSituational,
  }) {
    return Column(
      children: questions.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> questionData = entry.value;
        return _buildQuestionTile(
          question: questionData['question'],
          options: questionData['options'],
          index: index,
          answer: answers[index],
          onAnswerSelected: (answer) => onAnswerSelected(index, answer, isSituational),
        );
      }).toList(),
    );
  }

  Widget _buildQuestionTile({
    required String question,
    required List<String> options,
    required int index,
    required int? answer,
    required Function(int) onAnswerSelected,
  }) {
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
              int optionIndex = options.indexOf(option) + 1;
              return RadioListTile<int>(
                activeColor: Colors.white,
                title: Text(option, style: AppTypography.f14w400,),
                value: optionIndex,
                groupValue: answer,
                onChanged: (int? value) {
                  onAnswerSelected(value!);
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  int calculateScore(Map<int, int> answers) {
    return answers.values.reduce((value, element) => value + element);
  }

  String interpretScore(int score) {
    if (score <= 30) {
      return 'Низкий: Личность испытывает минимальный уровень тревоги. Они спокойны, расслаблены и чувствуют себя комфортно в различных ситуациях, не подвержены чрезмерным беспокойствам или напряжению.';
    } else if (score <= 45) {
      return 'Умеренный: Уровень тревоги находится в среднем диапазоне. Личность может периодически испытывать некоторое беспокойство или напряжение, особенно в стрессовых ситуациях, но это не препятствует их обычным повседневным функциям.';
    } else {
      return 'Высокий: Личность испытывает высокий уровень тревоги. Они могут чувствовать сильное беспокойство, напряжение и беспокойство даже в незначительных ситуациях, что может мешать их способности функционировать и принимать решения.';
    }
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

    GetData().getuser1().then((v){tests = v;});
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
                          'Используя шкалу тревоги Спилбергера, тест позволяет классифицировать уровень тревожности испытуемого как низкий, умеренный или высокий. Эти результаты затем могут быть анализированы в контексте его или её поведения, привычек и реакций на различные стрессовые ситуации.',
                          style: AppTypography.f14w400
                              .copyWith(color: Colors.black,fontWeight: FontWeight.w600)),

                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                          textDirection: TextDirection.ltr,
                          text: TextSpan(
                              text: 'Результаты теста на тревожность\n',
                              style: AppTypography.f14w400
                                  .copyWith(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: '${widget.result}',
                                    style: AppTypography.f14w400.copyWith(
                                        color: Colors.black))
                              ])),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: CustomTextButton(
                  isActive: true,
                  text: 'Понял',
                  callback: () {
                    var user = FirebaseAuth.instance.currentUser;
                    CollectionReference ref =
                    FirebaseFirestore.instance.collection('userProfile');
                    ref.doc(user!.uid).set({'Tests': tests!+1 },SetOptions(merge: true));
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

// Вопросы для ситуативной тревожности
List<Map<String, dynamic>> situationalAnxietyQuestions = [
  {'question': 'Я спокоен', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Мне ничто не угрожает', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я нахожусь в напряжении', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я испытываю сожаление', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я чувствую себя свободно', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я расстроен', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Меня волнуют возможные неудачи', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я чувствую себя отдохнувшим', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я встревожен', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я испытываю чувство внутреннего удовлетворения', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я уверен в себе', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я нервничаю', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я не нахожу себе места', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я взвинчен', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я не чувствую скованности', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я доволен', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я озабочен', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Я слишком возбужден и мне не по себе', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Мне радостно', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
  {'question': 'Мне приятно', 'options': ['Почти никогда', 'Иногда', 'Часто', 'Почти всегда']},
];

// Вопросы для личностной тревожности
List<Map<String, dynamic>> personalityAnxietyQuestions = [
  {'question': 'Я испытываю удовольствие', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я обычно быстро устаю', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я легко могу заплакать', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я хотел бы быть таким же счастливым, как и другие', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Нередко я проигрываю из-за того, что недостаточно быстро принимаю решения', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Обычно я чувствую себя бодрым', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я спокоен, хладнокровен и собран', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Ожидаемые трудности обычно очень тревожат меня', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я слишком переживаю из-за пустяков', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я вполне счастлив', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я принимаю все слишком близко к сердцу', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Мне не хватает уверенности в себе', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Обычно я чувствую себя в безопасности', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я стараюсь избегать критических ситуаций и трудностей', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'У меня бывает хандра', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я доволен', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Всякие пустяки отвлекают и волнуют меня', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я так сильно переживаю свои разочарования, что потом долго не могу о них забыть', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Я уравновешенный человек', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
  {'question': 'Меня охватывает беспокойство, когда я думаю о своих делах и заботах', 'options': ['Нет, это не так', 'Пожалуй, так', 'Верно', 'Совершенно верно']},
];

