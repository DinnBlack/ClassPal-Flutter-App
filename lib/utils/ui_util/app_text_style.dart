import 'package:flutter/material.dart';
import 'package:flutter_class_pal/utils/constants/constant.dart';

class AppTextStyle {
  static TextStyle light(double size, [Color color = kBlackColor]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w100,
    );
  }

  static TextStyle regular(double size, [Color color = kBlackColor]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w300,
    );
  }

  static TextStyle medium(double size, [Color color = kBlackColor]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle semibold(double size, [Color color = kBlackColor]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle bold(double size, [Color color = kBlackColor]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w900,
    );
  }
}
