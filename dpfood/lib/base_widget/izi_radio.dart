import 'package:flutter/material.dart';
import 'package:template/base_widget/izi_image.dart';

import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

enum IZIRadioType {
  SIMPLE,
  IMAGE,
}

class IZIRadio<T> extends StatelessWidget {
  const IZIRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.row1Left,
    required this.onChanged,
    this.row2Left,
    this.type = IZIRadioType.SIMPLE,
    this.urlImage,
    this.icon,
    this.widthBorder,
    this.backgroundColor,
    this.backgroundIcon,
    this.iconColor,
    this.textColor,
  }) : super(key: key);
  final T value;
  final T groupValue;
  final String row1Left;
  final String? row2Left;
  final Function(T value) onChanged;
  final IZIRadioType? type;
  final String? urlImage;
  final IconData? icon;
  final double? widthBorder;
  final Color? backgroundColor;
  final Color? backgroundIcon;
  final Color? iconColor;
  final Color? textColor;

  Widget getCard(IZIRadioType type) {
    if (type == IZIRadioType.SIMPLE) {
      return radioDefaul();
    }
    return radioImage();
  }

  @override
  Widget build(BuildContext context) {
    return getCard(type!);
  }

  Widget radioDefaul() {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_2X,
          right: IZIDimensions.SPACE_SIZE_2X,
          top: IZIDimensions.SPACE_SIZE_1X,
          bottom: IZIDimensions.SPACE_SIZE_1X,
        ),
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_4X,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: widthBorder == 0
              ? null
              : Border.all(
                  color: groupValue == value ? ColorResources.PRIMARY_1 : ColorResources.NEUTRALS_7,
                  width: 2,
                ),
          borderRadius: BorderRadius.circular(
            IZIDimensions.BORDER_RADIUS_4X,
          ),
        ),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  width: IZIDimensions.ONE_UNIT_SIZE * 30,
                  decoration: BoxDecoration(
                    color: groupValue == value ? backgroundIcon ?? ColorResources.PRIMARY_2 : ColorResources.WHITE,
                    shape: BoxShape.circle,
                    border: groupValue == value
                        ? null
                        : Border.all(
                            color: ColorResources.NEUTRALS_7,
                            width: 2,
                          ),
                  ),
                ),
                if (groupValue == value || icon != null)
                  Icon(
                    icon ?? Icons.check,
                    color: iconColor ?? ColorResources.WHITE,
                    size: IZIDimensions.ONE_UNIT_SIZE * 25,
                  ),
              ],
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Flexible(
              child: IZIText(
                text: row1Left,
                maxLine: 10,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: IZIDimensions.FONT_SIZE_H6,
                  color: textColor ?? ColorResources.NEUTRALS_1,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget radioImage() {
    return GestureDetector(
      onTap: () {
        onChanged(value);
      },
      child: Container(
        margin: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_2X,
          right: IZIDimensions.SPACE_SIZE_2X,
          top: IZIDimensions.SPACE_SIZE_2X,
          bottom: IZIDimensions.SPACE_SIZE_1X,
        ),
        padding: EdgeInsets.all(
          IZIDimensions.SPACE_SIZE_4X,
        ),
        decoration: BoxDecoration(
          color: ColorResources.WHITE,
          border: Border.all(
            color: groupValue == value ? ColorResources.PRIMARY_1 : ColorResources.NEUTRALS_7,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            IZIDimensions.BORDER_RADIUS_4X,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (!IZIValidate.nullOrEmpty(urlImage))
              SizedBox(
                height: IZIDimensions.ONE_UNIT_SIZE * 120,
                width: IZIDimensions.ONE_UNIT_SIZE * 120,
                child: IZIImage(
                  urlImage!,
                ),
              ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IZIText(
                    text: row1Left,
                    maxLine: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * 1.1,
                      color: ColorResources.NEUTRALS_1,
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 5,
                  ),
                  if (!IZIValidate.nullOrEmpty(row2Left))
                    IZIText(
                      text: row2Left!,
                      maxLine: 3,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.95,
                        color: ColorResources.NEUTRALS_4,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  width: IZIDimensions.ONE_UNIT_SIZE * 30,
                  decoration: BoxDecoration(
                    color: groupValue == value ? ColorResources.PRIMARY_2 : ColorResources.WHITE,
                    shape: BoxShape.circle,
                    border: groupValue == value
                        ? null
                        : Border.all(
                            color: ColorResources.NEUTRALS_7,
                            width: 2,
                          ),
                  ),
                ),
                if (groupValue == value)
                  Icon(
                    Icons.check,
                    color: ColorResources.WHITE,
                    size: IZIDimensions.ONE_UNIT_SIZE * 25,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
