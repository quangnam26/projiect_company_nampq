import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:template/utils/color_resources.dart';

mixin IZIAlert {
  static void error({required String message, Color? backgroundColor}) {
    showToast(
      message.toString(),
      context: Get.context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      backgroundColor: backgroundColor ?? ColorResources.RED,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static void success({required String message, Color? backgroundColor}) {
    showToast(
      message.toString(),
      context: Get.context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
      backgroundColor: backgroundColor ?? ColorResources.GREEN,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }

  static void info({required String message, Color? backgroundColor}) {
    showToast(
      message.toString(),
      context: Get.context,
      animation: StyledToastAnimation.scale,
      reverseAnimation: StyledToastAnimation.fade,
      position: StyledToastPosition.top,
      textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      backgroundColor: ColorResources.PRIMARY_3,
      animDuration: const Duration(seconds: 1),
      duration: const Duration(seconds: 4),
      curve: Curves.elasticOut,
      reverseCurve: Curves.linear,
    );
  }
}
