import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_validate.dart';

import '../helper/izi_dimensions.dart';
import '../utils/color_resources.dart';

class MyDialogAlertDone extends StatelessWidget {
  final double rotateAngle;
  final IconData icon;
  final String title;
  final String imagesIcon;
  final String description;
  final Color? color;
  final Function()? onTapConfirm ;
  final Function()? onTapCancle;
  final Axis? direction;
  final TextAlign? textAlignDescription;
  const MyDialogAlertDone({
    this.rotateAngle = 0,
    required this.icon,
    required this.title,
    required this.description,
    required this.imagesIcon,
    this.color,
    this.onTapConfirm,
    this.onTapCancle,
    this.textAlignDescription,
    this.direction = Axis.horizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_5X,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_3X,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
          vertical: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(direction == Axis.horizontal)
            Row(
              children: [
                Align(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.NEUTRALS_2,
                    ),
                  ),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_2X,
                ),
                IZIImage(
                  imagesIcon,
                  width: IZIDimensions.ONE_UNIT_SIZE * 40,
                  height: IZIDimensions.ONE_UNIT_SIZE * 40,
                ),
              ],
            ),
            if(direction == Axis.vertical)
            Column(
              children: [
                Align(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.bold,
                      color: ColorResources.NEUTRALS_2,
                    ),
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                IZIImage(
                  imagesIcon,
                  width: IZIDimensions.ONE_UNIT_SIZE * 40,
                  height: IZIDimensions.ONE_UNIT_SIZE * 40,
                ),
              ],
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_2X,
            ),
            Padding(
              padding: EdgeInsets.only(
                right: IZIDimensions.SPACE_SIZE_3X,
              ),
              child: Text(
                description,
                textAlign: textAlignDescription ?? TextAlign.start,
                style: TextStyle(
                  color: ColorResources.NEUTRALS_4,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: IZIDimensions.iziSize.height * 0.02,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if(!IZIValidate.nullOrEmpty(onTapConfirm))
                  GestureDetector(
                    onTap:(){
                      onTapConfirm!();
                    },
                    child: Text(
                      "ĐỒNG Ý",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.PRIMARY_1,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  if(!IZIValidate.nullOrEmpty(onTapCancle))
                  GestureDetector(
                    onTap: (){
                      onTapCancle!();
                    },
                    child: Text(
                      "THOÁT",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.PRIMARY_1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
