import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart/feature/Calendar/widget/Event.dart';
import 'package:smart/utils/AppTypography.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/colors2.dart';
import '../../../widgets/bar/AppBarAvatar.dart';

class Calendar extends StatefulWidget {
  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  Map<DateTime, List<Event>> events = {};
  DateTime _focusedDay = DateTime.now();
  TextEditingController _eventController = TextEditingController();
  DateTime? _selectedDay;
  late final ValueNotifier<List<Event>> _selectedEvents;
  late Color _selectedColor;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  List<String> _colorTexts = [
    'Гнев',
    'Вина',
    'Стыд',
    'Печаль',
    'Презрение',
    'Страх',
    'Интерес',
    'Радость',
    'Удивление',
    'Обида',
    'Отвращение',
    'Ревность',
  ];

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    _selectedColor =
        _colorOptions.first; // Установка начального выбранного цвета
  }

  final List<Color> _colorOptions = [
    Color(0xFFEE917F),
    Color(0xFFA0E3D4),
    Color(0xFFE8C295),
    Color(0xFF7FD7C3),
    Color(0xFFAB9FCB),
    Color(0xFFC1B8DA),
    Color(0xFFE3B37A),
    Color(0xFFE8D890),
    Color(0xFFE9D472),
    Color(0xFF9889C2),
    Color(0xFF61D2B9),
    Color(0xFFF4BCB1),
  ];

  void _setColor(Color color) {
    setState(() {
      _selectedColor = color;
      _addEvent(); // Добавление события при выборе цвета
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  void _addEvent() {
    if (_eventController.text.isNotEmpty) {
      setState(() {
        // Добавление события в Map events
        events.update(
          _selectedDay!,
          (value) => [
            ...value,
            Event(
              _eventController.text,
              color: _selectedColor,
            ),
          ],
          ifAbsent: () => [
            Event(
              _eventController.text,
              color: _selectedColor,
            ),
          ],
        );
        // Обновление списка событий для выбранной даты
        _selectedEvents.value = _getEventsForDay(_selectedDay!);
        // Очистка текстового поля
        _eventController.clear();
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBarAvatar(text: 'Дневник'),
        resizeToAvoidBottomInset: false,
        floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: FloatingActionButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height - 120,
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom > 0
                            ? 16.0
                            : 0,
                        left: 24,
                        right: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 20),
                          Center(
                            child: Container(
                              width: 96.46,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 3, color: Color(0xFF8E97FD)),
                                    borderRadius: BorderRadius.circular(99)),
                              ),
                            ),
                          ),
                          SizedBox(height: 14),
                          Center(
                            child: Text('Что произошло?',
                                style: AppTypography.f20w400
                                    .copyWith(color: Color(0xFF3F414E))),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: _eventController,
                            decoration: InputDecoration(
                                hintStyle: const TextStyle(
                                  color: Color(0xFF959595),
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                                hintText: 'Введите название события',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                        color: Color(0xFF8E97FD), width: 3)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF8E97FD), width: 3),
                                  borderRadius: BorderRadius.circular(9),
                                )),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                          SizedBox(height: 25),
                          Center(
                            child: Text('Выберите эмоцию',
                                style: AppTypography.f20w400
                                    .copyWith(color: Color(0xFF3F414E))),
                          ),
                          SizedBox(height: 25),
                          Center(
                            child: Wrap(
                              spacing: 10.0,
                              runSpacing: 10.0,
                              children:
                                  List.generate(_colorOptions.length, (index) {
                                final color = _colorOptions[index];
                                return GestureDetector(
                                  onTap: () => _setColor(color),
                                  child: Container(
                                    width: 90,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: color,
                                      shape: BoxShape.circle,
                                      border: _selectedColor == color
                                          ? Border.all(
                                              width: 3,
                                              color: Colors.transparent)
                                          : null,
                                    ),
                                    child: Center(
                                      child: Text(
                                        _colorTexts[index],
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 13,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w500,
                                          height: 0.08,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Color(0xFF8E97FD),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              InkWell(
                splashColor: AppColors.lightViolet,
                borderRadius: BorderRadius.circular(24),
                onTap: () {
                  setState(() {
                    _calendarFormat = _calendarFormat == CalendarFormat.month
                        ? CalendarFormat.week
                        : CalendarFormat.month;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Ink(
                      width: 374,
                      padding: const EdgeInsets.all(24),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadows: [
                          BoxShadow(
                            color: Color(0x16000000),
                            blurRadius: 19,
                            offset: Offset(2, 16),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TableCalendar(
                        locale: "en_US",
                        rowHeight: 42,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        calendarFormat: _calendarFormat,
                        availableGestures: AvailableGestures.all,
                        selectedDayPredicate: (day) =>
                            isSameDay(day, _focusedDay),
                        focusedDay: _focusedDay,
                        firstDay: DateTime.utc(2020, 10, 16),
                        lastDay: DateTime.utc(2030, 3, 14),
                        onDaySelected: _onDaySelected,
                        eventLoader: _getEventsForDay,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (value.isEmpty) {
                      return Center(
                        child: Text(
                          'Что вы чувствуете сегодня?',
                          style: TextStyle(
                            color: Color(0xFF3F414E),
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final event = value[index];
                        return Dismissible(
                          key: Key(event.hashCode.toString()),
                          onDismissed: (direction) {
                            setState(() {
                              events[_selectedDay!]!.remove(event);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: event.color,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                content: Column(
                                  children: [
                                    Text(
                                      'Событие "${event.title}" удалено',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: event.color,
                                title: Text('Удалить событие?',
                                    style: AppTypography.alert),
                                content: Text(
                                    'Вы уверены, что хотите удалить событие "${event.title}"?',
                                    style: AppTypography.alert
                                        .copyWith(fontSize: 14)),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text('Отмена',
                                        style: AppTypography.alert
                                            .copyWith(fontSize: 14)),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text(
                                      'Удалить',
                                      style: AppTypography.alert
                                          .copyWith(fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete, color: Colors.white),
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 20),
                          ),
                          child: ListTile(
                            onTap: () => print(event.title),
                            title: Container(
                              decoration: BoxDecoration(
                                color: event.color,
                                borderRadius: BorderRadius.circular(17),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  '${event.title}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
