import 'package:flutter/material.dart';
import 'package:template/utils/color_resources.dart';

import '../helper/izi_dimensions.dart';

class IZIAppBarP24 extends StatelessWidget {
  const IZIAppBarP24(
      {Key? key,
      this.title,
      this.iconsRight,
      this.isSelect,
      this.iconBack,
      this.actions = const [],
      this.colorTitle,
      this.colorBG,
      this.onTap,
      this.onTapIconLeft,
      this.widthIconBack,
      this.widthActions,
      this.iconsLeft})
      : super(key: key);
  final String? title;

  final Color? colorTitle;
  final Widget? iconsRight;
  final Widget? iconsLeft;
  final Color? colorBG;
  final bool? isSelect;
  final Widget? iconBack;
  final List<Widget>? actions;
  final Function? onTap;
  final Function? onTapIconLeft;
  final double? widthIconBack, widthActions;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      height: kToolbarHeight,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              height: kToolbarHeight,
              padding: EdgeInsets.only(
                left: IZIDimensions.SPACE_SIZE_3X,
              ),
              alignment: Alignment.centerLeft,
              width: IZIDimensions.ONE_UNIT_SIZE * 230,
              child: iconBack
              //  ??
              //     GestureDetector(
              //       onTap: () {
              //         Get.back();
              //       },
              //       child: const Icon(
              //         Icons.arrow_back_ios,
              //         color: ColorResources.NEUTRALS_3,
              //       ),
              //     ),
              ),
          Center(
            child: Text(
              title!,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_H5,
                color: colorTitle ?? ColorResources.NEUTRALS_1,
              ),
            ),
          ),
        ],
      ),
      // elevation: 0,
      // centerTitle: true,
      // backgroundColor: colorBG ?? ColorResources.WHITE,
      // title: Center(
      //   child: Text(
      //     title!,
      //     maxLines: 1,
      //     style: TextStyle(
      //       fontWeight: FontWeight.w600,
      //       fontSize: IZIDimensions.FONT_SIZE_H5,
      //       color: colorTitle ?? ColorResources.NEUTRALS_1,
      //     ),
      //   ),
      // ),
      // actions: <Widget>[
      //   if (isSelect == true)
      //     IconButton(
      //       icon: iconsRight!,
      //       onPressed: () {
      //         onTap!();
      //       },
      //     )
      //   else
      //     const SizedBox(),
      // ],
      // leading: GestureDetector(
      //     onTap: () {
      //       onTapIconLeft!();
      //       // Get.back();
      //     },
      //     child: iconsLeft
      //     //  const Icon(
      //     //   Icons.arrow_back_ios,
      //     //   color: ColorResources.NEUTRALS_3,
      //     // ),
      //     ),
    );
  }
}
