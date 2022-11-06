import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';

import '../utils/images_path.dart';

class IZIDialog {
  static Future<void> showDialog({
    required String lable,
    String? confirmLabel,
    String? cancelLabel,
    String? description,
    Function? onConfirm,
    Function? onCancel,
    Widget? content,
  }) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      barrierDismissible: false,
      title: '',
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_3X,
                  ),
                  child: IZIImage(
                    ImagesPath.splash_haqua,
                    width: IZIDimensions.ONE_UNIT_SIZE * 120,
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IZIText(
                  textAlign: TextAlign.center,
                  text: lable,
                  maxLine: 2,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
          content ??
              Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_5X,
                ),
                child: IZIText(
                  textAlign: TextAlign.center,
                  text: description ?? '',
                  maxLine: 7,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  ),
                ),
              ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              if (!IZIValidate.nullOrEmpty(onCancel))
                IZIButton(
                  margin: const EdgeInsets.all(0),
                  type: IZIButtonType.OUTLINE,
                  label: cancelLabel ?? "Không",
                  width: IZIDimensions.iziSize.width * 0.33,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                    vertical: IZIDimensions.ONE_UNIT_SIZE * 15,
                  ),
                  onTap: () {
                    onCancel!();
                  },
                ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
              if (!IZIValidate.nullOrEmpty(onConfirm))
                IZIButton(
                  margin: const EdgeInsets.all(0),
                  width: IZIDimensions.iziSize.width * 0.33,
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                    vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                  ),
                  label: confirmLabel ?? "Đồng ý",
                  onTap: () {
                    onConfirm!();
                  },
                ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
