import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'Roboto', //'.SF Pro Display',
  primaryColor: const Color(0xFF0DAC43),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFc7c7c7),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFF252525),
  ),
);
