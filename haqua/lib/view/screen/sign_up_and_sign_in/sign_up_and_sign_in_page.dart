import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/sign_up_and_sign_in/sign_up_and_sign_in_controller.dart';

class SignUpAndSignInPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
          init: SignUpAndSignInController(),
          builder: (SignUpAndSignInController controller) {
            if (controller.isLoading) {
              return Center(
                child: IZILoading().isLoadingKit,
              );
            }
            return Scaffold(
              backgroundColor: ColorResources.BACKGROUND,
              body: Container(
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorResources.WHITE,
                      Color.fromARGB(255, 111, 163, 226),
                      Color.fromARGB(255, 37, 121, 230),
                      ColorResources.PRIMARY_APP,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IZIImage(
                                ImagesPath.sign_up_or_sign_in,
                                width: IZIDimensions.iziSize.width * .9,
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: IZIDimensions.ONE_UNIT_SIZE * 80,
                              left: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              right: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Obx(
                                  () => DropDownButton<String>(
                                    width: IZIDimensions.iziSize.width * .35,
                                    isSort: false,
                                    data: controller.localeList.map((e) => e['name'].toString()).toList(),
                                    onChanged: (val) {
                                      controller.onChangedLanguage(val!);
                                    },
                                    isRequired: null,
                                    value: controller.locale.value,
                                    hint: "Ngôn ngữ",
                                    colorBorder: ColorResources.WHITE,
                                    backgroundColor: Colors.transparent,
                                    borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                                    textStyleHintText: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                      color: ColorResources.WHITE,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: Text(
                              "Welcome_to_Haqua".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: ColorResources.WHITE,
                                fontSize: IZIDimensions.FONT_SIZE_H5,
                              ),
                            ),
                          ),
                          Text(
                            "HAQUA",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.mali(
                              fontWeight: FontWeight.w600,
                              color: ColorResources.WHITE,
                              fontSize: IZIDimensions.FONT_SIZE_H1 * 1.2,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.ONE_UNIT_SIZE * 50,
                              IZIDimensions.SPACE_SIZE_3X,
                              IZIDimensions.ONE_UNIT_SIZE * 50,
                              0,
                            ),
                            child: Text(
                              "content_sign_up_or_sign_in".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorResources.WHITE,
                                fontSize: IZIDimensions.FONT_SIZE_H6,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        ),
                        child: _button(controller),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  ///
  /// Button Continue Introduction page.
  ///
  Widget _button(SignUpAndSignInController controller) {
    return IZIButton(
      onTap: () {
        controller.continueIntro();
      },
      label: 'continue'.tr,
      colorBG: ColorResources.WHITE,
      colorText: ColorResources.PRIMARY_APP,
    );
  }
}
