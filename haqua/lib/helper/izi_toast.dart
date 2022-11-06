import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class IZIToast {
  final showToast = FToast();

  IZIToast() {
    init();
  }

  ///
  ///init
  ///
  void init() {
    showToast.init(Get.context!);
  }

  ///
  ///successfully
  ///
  void successfully({
    required String message,
    Color? colorBG,
    Color? colorMessage,
    ToastGravity? toastGravityPosition,
    Duration? toastDuration,
    double? sizeWidthToast,
  }) {
    showToast.showToast(
      child: customToast(message: message, colorBG: colorBG, colorMessage: colorMessage, sizeWidthToast: sizeWidthToast),
      gravity: toastGravityPosition ?? ToastGravity.BOTTOM,
      toastDuration: toastDuration ?? const Duration(seconds: 2),
    );
  }

  ///
  ///error
  ///
  void error({
    required String message,
    Color? colorBG = ColorResources.RED,
    Color? colorMessage,
    ToastGravity? toastGravityPosition,
    Duration? toastDuration,
    double? sizeWidthToast,
  }) {
    showToast.showToast(
      child: customToast(message: message, colorBG: colorBG, colorMessage: colorMessage, sizeWidthToast: sizeWidthToast),
      gravity: toastGravityPosition ?? ToastGravity.BOTTOM,
      toastDuration: toastDuration ?? const Duration(seconds: 2),
    );
  }

  ///
  /// customToastSuccessful
  ///
  Widget customToast({
    required String message,
    Color? colorBG,
    Color? colorMessage,
    double? sizeWidthToast,
  }) {
    return Container(
      width: sizeWidthToast ?? IZIDimensions.iziSize.width * .6,
      decoration: BoxDecoration(
        color: colorBG ?? ColorResources.PRIMARY_APP,
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 50,
        ),
      ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Center(
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_1X,
                left: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_1X,
                ),
                child: IZIImage(
                  ImagesPath.splash_haqua,
                  width: IZIDimensions.ONE_UNIT_SIZE * 35,
                  height: IZIDimensions.ONE_UNIT_SIZE * 35,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(
                    right: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      color: colorMessage ?? ColorResources.WHITE,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
