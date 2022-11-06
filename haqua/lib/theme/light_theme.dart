import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

ThemeData lightTheme = ThemeData(
  backgroundColor: ColorResources.BACKGROUND,
  fontFamily: '.SF Pro Display',
  primaryColor: const Color(0xFF0DAC43),
  brightness: Brightness.light,
  // scaffoldBackgroundColor: ColorResources.BACKGROUND,
  hintColor: const Color(0xFF9E9E9E),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
  }),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: Colors.white,
  ),
);
