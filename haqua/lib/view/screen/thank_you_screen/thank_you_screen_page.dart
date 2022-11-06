import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/thank_you_screen/thank_you_screen_controller.dart';

class ThankYouPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorResources.BACKGROUND,
        body: GetBuilder(
          init: ThankYouController(),
          builder: (ThankYouController controller) {
            return Container(
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImagesPath.thank_you_page,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: IZIDimensions.ONE_UNIT_SIZE * 50,
                            horizontal: IZIDimensions.ONE_UNIT_SIZE * 20,
                          ),
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "thank_you_text_up_1".tr.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H2,
                                      color: ColorResources.WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  WidgetSpan(
                                    child: Container(
                                      child: Text(
                                        "thank_you_text_up_2".tr,
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          color: ColorResources.WHITE,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_3X,
                            vertical: IZIDimensions.ONE_UNIT_SIZE * 50,
                          ),
                          width: IZIDimensions.iziSize.width,
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_4X,
                            vertical: IZIDimensions.ONE_UNIT_SIZE * 80,
                          ),
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BORDER_RADIUS_4X,
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                "thank_you_text_up_3".tr,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IZIButton(
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        0,
                        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        IZIDimensions.SPACE_SIZE_2X,
                      ),
                      onTap: () {
                        controller.goToReadyPage();
                      },
                      label: "continue".tr,
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
