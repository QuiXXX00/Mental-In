import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart/feature/auth/firebase/get_data.dart';
import 'package:smart/utils/AppTypography.dart';

import '../../../../widgets/bar/AppBarAvatar.dart';

class UserProfileWidget extends StatelessWidget {
  final String username;

  const UserProfileWidget({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 156,
      height: 142,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username,
            style: AppTypography.f32w800Black,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('ЗДОРОВЬЕ', style: AppTypography.f10w600),
              SizedBox(
                width: 45,
                height: 17,
                child: Text('LVL 1', style: AppTypography.f12w800),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Псих. состояние', style: AppTypography.f10w600),
              SizedBox(
                width: 45,
                height: 17,
                child: Text('LVL 1', style: AppTypography.f12w800),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Образованность', style: AppTypography.f10w600),
              SizedBox(
                width: 45,
                height: 17,
                child: Text('LVL 1', style: AppTypography.f12w800),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
