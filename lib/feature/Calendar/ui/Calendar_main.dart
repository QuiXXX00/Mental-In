import 'dart:collection';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart/feature/Calendar/widget/Event.dart';
import 'package:smart/utils/AppTypography.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../utils/colors2.dart';
import '../../../utils/ev_utils.dart';
import '../../../widgets/bar/AppBarAvatar.dart';
import '../widget/add_event.dart';

class Calendar1 extends StatefulWidget {
  @override
  State<Calendar1> createState() => _Calendar1State();
}

class _Calendar1State extends State<Calendar1> {
  User? user = FirebaseAuth.instance.currentUser;
  Map<DateTime, List<Event>> events = {};



  DateTime _focusedDay = DateTime.now();
  late String formattedDate;
  late String time;

  final TextEditingController _eventController = TextEditingController();

  DateTime? _selectedDay;

 late final ValueNotifier<List<Event>> _selectedEvents;

  late Color _selectedColor;

  CalendarFormat _calendarFormat = CalendarFormat.month;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  @override
  void initState() {
    super.initState();
    events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );
    formattedDate= _focusedDay.toString().split(' ')[0];
    DateTime ff = DateTime.parse(formattedDate);
    time = ff.toString()+'Z';
    _focusedDay = DateTime.parse(time);
    _selectedDay = _focusedDay;
    _selectedColor = colorOptions.first;
    _loadFirestoreEvents();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));



  }

  _loadFirestoreEvents() async {
    final firstDay = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDay = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    events = {};

    final snap = await FirebaseFirestore.instance
        .collection('userProfile/${user?.uid}/Events')
        .where('date', isGreaterThanOrEqualTo: firstDay)
        .where('date', isLessThanOrEqualTo: lastDay)
        .withConverter(
            fromFirestore: Event.fromFirestore,
            toFirestore: (event, options) => event.toFirestore())
        .get();
    for (var doc in snap.docs) {
      final event = doc.data();
      final day =
          DateTime.utc(event.date.year, event.date.month, event.date.day);
      if (events[day] == null) {
        events[day] = [];
      }
      events[day]!.add(event);
    }
    setState(() {});
  }

  void _setColor(Color color) async {
    setState(() {
      _selectedColor = color;
    });
    await FirebaseFirestore.instance
        .collection('userProfile/${user?.uid}/Events')
        .add({
      "title": _eventController.text,
      "color": _selectedColor.value,
      "date": Timestamp.fromDate(_selectedDay!),
    });
    _loadFirestoreEvents();
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
    Navigator.of(context).pop();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
 void _onDaySelected (selectedDay, focusedDay) {
  setState(() {
    _selectedDay = selectedDay;
    _focusedDay = focusedDay;
  });
}
  @override
  Widget build(BuildContext context) {
    _selectedEvents.value = _getEventsForDay(_selectedDay!);
    return Scaffold(
      appBar: CustomAppBarAvatar(text: 'Дневник'),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
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
                        const SizedBox(height: 20),
                        Center(
                          child: Container(
                            width: 96.46,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 3, color: Color(0xFF8E97FD)),
                                  borderRadius: BorderRadius.circular(99)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Center(
                          child: Text('Что произошло?',
                              style: AppTypography.f20w400
                                  .copyWith(color: Color(0xFF3F414E))),
                        ),
                        const SizedBox(height: 20),
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
                                  borderSide: const BorderSide(
                                      color: Color(0xFF8E97FD), width: 3)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Color(0xFF8E97FD), width: 3),
                                borderRadius: BorderRadius.circular(9),
                              )),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: Text('Выберите эмоцию',
                              style: AppTypography.f20w400
                                  .copyWith(color: Color(0xFF3F414E))),
                        ),
                        const SizedBox(height: 25),
                        Center(
                          child: Wrap(
                            spacing: 10.0,
                            runSpacing: 10.0,
                            children:
                                List.generate(colorOptions.length, (index) {
                              final color = colorOptions[index];
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
                                            width: 3, color: Colors.transparent)
                                        : null,
                                  ),
                                  child: Center(
                                    child: Text(
                                      colorTexts[index],
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
          backgroundColor: Color(0xFF8E97FD),
          child: const Icon(Icons.add),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
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
                      shadows: const [
                        BoxShadow(
                          color: Color(0x16000000),
                          blurRadius: 19,
                          offset: Offset(2, 16),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        TableCalendar<Event>(
                          locale: "en_US",
                          rowHeight: 42,
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                          calendarFormat: _calendarFormat,
                          availableGestures: AvailableGestures.all,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          focusedDay: _focusedDay,
                          firstDay: DateTime.utc(2020, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          onDaySelected: _onDaySelected,
                          eventLoader: _getEventsForDay,
                        ),
                      ],
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
                    return const Center(
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
                            FirebaseFirestore.instance
                                .collection('userProfile/${user?.uid}/Events')
                                .doc(event.id)
                                .delete();
                            _loadFirestoreEvents();
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Color(event.color),
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
                              backgroundColor: Color(event.color),
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
                              color: Color(event.color),
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
    );
  }
}
