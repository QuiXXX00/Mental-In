import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../auth/firebase/get_data.dart';

class AddEvent extends StatefulWidget {
  final DateTime? selectedDate;
  final String? title;
  final int? color;
  const AddEvent(
      {Key? key,
        this.selectedDate, this.title, this.color})
      : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  void addEvent() async {
    final title = widget.title;
    final color = widget.color;

    await FirebaseFirestore.instance.collection('userProfile/${user?.uid}/Events').add({
      "title": title,
      "color": color,
      "date": Timestamp.fromDate(_selectedDate),
    });
    if (mounted) {
      Navigator.pop<bool>(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    addEvent();
    return Container();
  }
}