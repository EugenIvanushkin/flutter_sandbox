import 'package:flutter/material.dart';
import 'package:flutter_sample/style/colours.dart';
import 'package:flutter_sample/style/fonts.dart';

class AppTextStyleNormal extends TextStyle {
  AppTextStyleNormal({
    Color color = Colours.BLACK,
    double fontSize = Fonts.SIZE_NORMAL,
    double height = Fonts.HEIGHT_TEXT_NORMAL,
    FontWeight fontWeight = FontWeight.normal,
    double letterSpacing,
    TextDecoration decoration,
  }) : super(
    color: color,
    fontSize: fontSize,
    height: height,
    fontWeight: fontWeight,
    fontFamily: 'Roboto',
    letterSpacing: letterSpacing,
    decoration: decoration,
  );
}