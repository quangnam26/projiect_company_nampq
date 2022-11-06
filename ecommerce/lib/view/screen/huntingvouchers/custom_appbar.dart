import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.title,
    this.subTitle,
    this.iconBack,
    this.actions = const [],
    this.callbackSearch,
    this.colorTitle,
    this.colorBG,
    this.widthIconBack,
    this.widthActions,
  }) : super(key: key);
  final String title;
  final String? subTitle;
  final Color? colorTitle;
  final Color? colorBG;
  final Widget? iconBack;
  final List<Widget>? actions;
  final Function(String)? callbackSearch;
  final double? widthIconBack, widthActions;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBG ?? Colors.transparent,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: kToolbarHeight,
                padding: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_3X,
                ),
                alignment: Alignment.centerLeft,
                width: widthIconBack ?? IZIDimensions.iziSize.width * 0.125,
                child: iconBack ??
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: colorTitle ?? ColorResources.NEUTRALS_3,
                      ),
                    ),
              ),
              Container(
                height: kToolbarHeight,
                padding: EdgeInsets.only(
                  right: IZIDimensions.SPACE_SIZE_3X,
                ),
                alignment: Alignment.centerRight,
                width: widthActions ??
                    (IZIDimensions.iziSize.width * 0.125) * actions!.length,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              )
            ],
          ),
          Container(
            height: kToolbarHeight,
            alignment: Alignment.topLeft,
            width: IZIDimensions.iziSize.width,
            child: !IZIValidate.nullOrEmpty(callbackSearch)
                ? search(context)
                : Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: colorTitle ?? ColorResources.NEUTRALS_1,
                        ),
                      ),
                      if (!IZIValidate.nullOrEmpty(subTitle))
                        Text(
                          subTitle!,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            color: colorTitle ?? ColorResources.BLACK,
                          ),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget search(BuildContext context) {
    return IZIInput(
      width: IZIDimensions.iziSize.width -
          ((IZIDimensions.iziSize.width * 0.125 -
                  IZIDimensions.ONE_UNIT_SIZE * 30) *
              (actions!.length + 1) *
              2),
      type: IZIInputType.TEXT,
      disbleError: true,
      miniSize: true,
      prefixIcon: (val) {
        return const Icon(Icons.search);
      },
      placeHolder: "Tìm kiếm",
      onChanged: callbackSearch,
    );
  }
}
