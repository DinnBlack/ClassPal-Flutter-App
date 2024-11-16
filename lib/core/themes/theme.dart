import 'package:flutter/material.dart';

import '../constants/constant.dart';

// ThemeData cho chế độ sáng
final ThemeData lightTheme = ThemeData(
  fontFamily: 'NotoSans',
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    background: kBackgroundColor,
  ),
  scaffoldBackgroundColor: kBackgroundColor, // Nền của Scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: kWhiteColor,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: kBlackColor),
    bodyMedium: TextStyle(color: kGreyColor),
  ),
);

// ThemeData cho chế độ tối
final ThemeData darkTheme = ThemeData(
  fontFamily: 'NotoSans',
  colorScheme: const ColorScheme.dark().copyWith(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
    background: kBlackColor, // Màu nền tổng thể
  ),
  scaffoldBackgroundColor: kBlackColor, // Nền của Scaffold
  appBarTheme: const AppBarTheme(
    backgroundColor: kPrimaryColor,
    foregroundColor: kWhiteColor,
  ),
  textTheme: TextTheme(
    bodyLarge: const TextStyle(color: kWhiteColor),
    bodyMedium: TextStyle(color: kLightGreyColor),
  ),
);
