import 'package:flutter/material.dart';
import 'package:shop_app_task/app/theme/color_theme.dart';

class AppTheme {
  static final light = ThemeData(
    platform: TargetPlatform.iOS,
    colorScheme: ColorScheme.light(
      primary:Palette.primary,
      primaryVariant: Palette.primary2,
      onPrimary: Palette.onPrimary,
      secondary: Palette.secondary,
      secondaryVariant:Palette.secondary2,
      onSecondary: Palette.onSecondary,
    ),
    textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
      primary: Palette.onPrimary,
    )),
  );
}
