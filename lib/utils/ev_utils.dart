import'package:firebase_helpers/firebase_helpers.dart';
import 'package:flutter/material.dart';

import '../feature/Calendar/widget/Event.dart';


Map<String,dynamic> encodeMap(Map<DateTime,dynamic> map){
  Map<String,dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[key.toString()] = map[key];
  });
  return newMap;
}

Map<DateTime,dynamic> decodeMap(Map<String,dynamic> map){
  Map<DateTime,dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[DateTime.parse(key)] = map[key];
  });
  return newMap;
}

List<String> colorTexts = [
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

final List<Color> colorOptions = [
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

