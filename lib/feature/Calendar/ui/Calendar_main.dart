import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart/feature/Calendar/widget/Event.dart';
import 'package:table_calendar/table_calendar.dart';

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

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay))
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _selectedEvents.value = _getEventsForDay(selectedDay);
      });
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomAppBarAvatar(text: 'Дневник'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  scrollable: true,
                  title: Text('add'),
                  content: Padding(
                    padding: EdgeInsets.all(8),
                    child: TextField(
                      controller: _eventController,
                    ),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // Добавление события в Map events
                          events.update(
                            _selectedDay!,
                            (value) => [...value, Event(_eventController.text)],
                            ifAbsent: () => [Event(_eventController.text)],
                          );
                          // Обновление списка событий для выбранной даты
                          _selectedEvents.value =
                              _getEventsForDay(_selectedDay!);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('add'),
                    ),
                  ],
                );
              },
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF8E97FD),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 51,
              ),
              Container(
                width: 374,
                height: 340,
                padding: const EdgeInsets.all(24),
                clipBehavior: Clip.antiAlias,
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
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2020, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  onDaySelected: _onDaySelected,
                  eventLoader: _getEventsForDay,
                ),
              ),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    if (value.isEmpty) {
                      return Center(
                        child: Text('Нет событий для выбранной даты'),
                      );
                    }
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        final event = value[index];
                        return Dismissible(
                          key: Key(event.hashCode.toString()),
                          // Уникальный ключ на основе hashCode
                          onDismissed: (direction) {
                            setState(() {
                              events[_selectedDay!]!.remove(event);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Событие "${event.title}" удалено'),
                              ),
                            );
                          },
                          confirmDismiss: (direction) async {
                            return await showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text('Удалить событие?'),
                                content: Text(
                                    'Вы уверены, что хотите удалить событие "${event.title}"?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: Text('Отмена'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: Text('Удалить'),
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
                            onTap: () => print(""),
                            title: Text('${event.title}'),
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
