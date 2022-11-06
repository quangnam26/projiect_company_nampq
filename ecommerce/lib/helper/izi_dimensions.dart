// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:template/helper/izi_size.dart';

mixin IZIDimensions {
  // Max size safe area default without top and bottom
  static Size iziSize = IZISize.size;

  // Divide screen to 1000 unit, get one unit to make base
  static double ONE_UNIT_SIZE = IZISize.getFontSize();
  

  // Font size text and icon
  static double FONT_SIZE_SPAN_SMALL_EXTRA = 10.0 * ONE_UNIT_SIZE * ONE_UNIT_SIZE;
  static double FONT_SIZE_SPAN_SMALL = 12.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_SPAN = 20.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H6 = 25.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H5 = 30.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H4 = 35.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H3 = 40.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H2 = 45.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H1 = 50.0 * ONE_UNIT_SIZE;

  // Padding , Margin
  static double SPACE_SIZE_1X = 10.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_2X = 15.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_3X = 20.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_4X = 25.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_5X = 30.0 * ONE_UNIT_SIZE;

  // BORDER RADIUS
  static double BORDER_RADIUS_1X = 5.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_2X = 7.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_3X = 10.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_4X = 15.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_5X = 25.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_6X = 30.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_7X = 50.0 * ONE_UNIT_SIZE;

  //BLUR RADIUS
  static double BLUR_RADIUS_1X = 5 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_2X = 10 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_3X = 15 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_4X = 20 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_5X = 25 * ONE_UNIT_SIZE; //spread Radius
  static double SPREAD_RADIUS_1X = 0.05 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_2X = 0.1 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_3X = 0.2 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_4X = 0.4 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_5X = 0.6 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_6X = 1 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_7X = 2 * ONE_UNIT_SIZE;
}
