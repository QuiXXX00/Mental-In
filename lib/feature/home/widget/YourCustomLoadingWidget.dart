import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart/utils/colors2.dart';

class YourCustomLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.violet,
      ), // или любой другой виджет загрузки
    );
  }
}