import 'package:flutter/material.dart';
import 'package:spotify/core/theme/app_pallete.dart';

class AppTheme{
  static final darkThemeMode=ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPallete.backgroundColor
  );
}