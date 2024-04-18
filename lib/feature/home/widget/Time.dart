import 'dart:async';

String getGreeting() {
  DateTime now = DateTime.now();
  String greeting = 'Доброе утро';
  if (now.hour >= 18) {
    greeting = 'Добрый вечер';
  } else if (now.hour >= 22 || now.hour < 7) {
    greeting = 'Доброй ночи';
  }
  return greeting;
}

// Функция для обновления виджета каждую минуту
void updateWidgetPeriodically(Function setState) {
  Timer.periodic(Duration(minutes: 60), (timer) {
    setState();
  });
}


