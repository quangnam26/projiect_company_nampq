import 'package:flutter/material.dart';
import 'package:template/helper/izi_validate.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_text_style.dart';
import '../../../utils/color_resources.dart';

class CouponsWidget extends StatelessWidget {
  const CouponsWidget({
    Key? key,
    required this.code,
    required this.description,
    required this.expiration,
    this.width,
    this.margin,
    this.bg,
    this.enable = true,
    this.onTap,
  }) : super(key: key);
  final String code;
  final String description;
  final String expiration;
  final double? width;
  final EdgeInsets? margin;
  final Color? bg;
  final bool? enable;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: margin ??
          EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_4X,
          ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_4X,
      ),
      width: width ?? IZIDimensions.iziSize.width * 0.9,
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  code,
                  style: textStyleSpanCustom.copyWith(
                    color: ColorResources.NEUTRALS_4,
                  ),
                ),
                Flexible(
                  child: Text(
                    description,
                    textAlign: TextAlign.start,
                    style: textStyleH6.copyWith(
                      color: ColorResources.NEUTRALS_2,
                    ),
                  ),
                ),
                Text(
                  "HSD: $expiration",
                  style: textStyleSpan.copyWith(
                    color: ColorResources.NEUTRALS_4,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              if (enable!) {
                if (!IZIValidate.nullOrEmpty(onTap)) {
                  onTap!();
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bg ?? ColorResources.PRIMARY_1,
              ),
              alignment: Alignment.center,
              height: IZIDimensions.ONE_UNIT_SIZE * 90,
              padding: EdgeInsets.all(
                IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Text(
                "Chọn",
                style: textStyleSpan.copyWith(
                  color: ColorResources.WHITE,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
