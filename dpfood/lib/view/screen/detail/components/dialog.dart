// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../helper/izi_dimensions.dart';

class DialogWidget extends StatelessWidget {
  final Function()? onTapConfirm;
  final Function()? onTapCancel;
  final String title;
  final String description;

  const DialogWidget({
    Key? key,
    this.onTapConfirm,
    this.onTapCancel,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
      ),
      backgroundColor: ColorResources.WHITE,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
          vertical: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: IZIDimensions.FONT_SIZE_H5,
              ),
            ),
            SizedBox(
              height: IZIDimensions.ONE_UNIT_SIZE * 20,
            ),
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.NEUTRALS_4,
              ),
            ),
            SizedBox(
              height: IZIDimensions.ONE_UNIT_SIZE * 20,
            ),
            Row(
              children: [
                Expanded(
                  child: cancleButton(),
                ),
                SizedBox(
                  width: IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
                Expanded(
                  child: button(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Button
  ///
  Widget button() {
    return IZIButton(
      onTap: () {
        if (!IZIValidate.nullOrEmpty(onTapConfirm)) {
          onTapConfirm!();
        } else {
          Get.back();
        }
      },
      label: 'Xác nhận',
      width: IZIDimensions.ONE_UNIT_SIZE * 200,
      fontSizedLabel: IZIDimensions.ONE_UNIT_SIZE * 25,
      padding: EdgeInsets.all(
        IZIDimensions.ONE_UNIT_SIZE * 10,
      ),
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
    );
  }

  ///
  /// Button
  ///
  Widget cancleButton() {
    return IZIButton(
      onTap: () {
        if (!IZIValidate.nullOrEmpty(onTapCancel)) {
          onTapCancel!();
        } else {
          Get.back();
        }
      },
      type: IZIButtonType.OUTLINE,
      label: 'Từ chối',
      width: IZIDimensions.ONE_UNIT_SIZE * 200,
      fontSizedLabel: IZIDimensions.ONE_UNIT_SIZE * 25,
      padding: EdgeInsets.all(
        IZIDimensions.ONE_UNIT_SIZE * 10,
      ),
      borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
      withBorder: 1,
    );
  }
}
