import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/ready_screen/ready_screen_controller.dart';

class ReadyScreenPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorResources.BACKGROUND,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: ColorResources.BACKGROUND,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.BLACK,
            ),
          ),
          title: Text(
            "ready".tr,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H5,
              color: ColorResources.BLACK.withOpacity(.75),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
          ),
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_4X,
                  bottom: IZIDimensions.SPACE_SIZE_3X,
                ),
                child: Text(
                  "ready_page_text_1".tr.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.BLACK.withOpacity(.75),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.SPACE_SIZE_3X,
                ),
                child: Text(
                  "ready_page_text_2".tr,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    color: ColorResources.BLACK.withOpacity(.75),
                  ),
                ),
              ),
              Text(
                "ready_page_text_3".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  color: ColorResources.BLACK,
                ),
              ),
            ],
          ),
        ),
        bottomSheet: GetBuilder(
          init: ReadyScreenController(),
          builder: (ReadyScreenController controller) {
            return IZIButton(
              margin: EdgeInsets.fromLTRB(
                IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                0,
                IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                IZIDimensions.SPACE_SIZE_2X,
              ),
              onTap: () {
                controller.goToDashboard();
              },
              label: "ready".tr,
            );
          },
        ),
      ),
    );
  }
}
