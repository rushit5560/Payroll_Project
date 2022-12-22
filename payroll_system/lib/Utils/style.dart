import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payroll_system/constants/colors.dart';

class TextStyleConfig {
  static TextStyle textStyle({
    Color textColor = AppColors.blackColor,
    FontWeight fontWeight = FontWeight.normal,
    double fontSize = 15.0,
  }) {
    return TextStyle(
      color: textColor,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
