import 'package:all_events/app/data/themes/color_code.dart';
import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: ColorCode.primaryColor, primary: ColorCode.primaryColor),
  useMaterial3: true,
);
