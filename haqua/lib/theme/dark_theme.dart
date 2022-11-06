import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: '.SF Pro Display',
  primaryColor: const Color(0xFF0DAC43),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFc7c7c7),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
    TargetPlatform.fuchsia: FadeUpwardsPageTransitionsBuilder(),
  }),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFF252525),
  ),
);
