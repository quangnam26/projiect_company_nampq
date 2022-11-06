import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';

// ignore: avoid_classes_with_only_static_members
class IZIDialog {
  static Future<void> showDialog({required String lable, String? confirmLabel, String? cancelLabel, String? description, Function? onConfirm, Function? onCancel}) {
    return Get.defaultDialog(
      titlePadding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
      ),
      barrierDismissible: false,
      title: lable,
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: IZIText(
              textAlign: TextAlign.center,
              text: description ?? '',
              maxLine: 7,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
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
                  borderRadius: IZIDimensions.BLUR_RADIUS_2X,
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
                  borderRadius: IZIDimensions.BLUR_RADIUS_2X,
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
