import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/images_path.dart';
import '../../../../base_widget/background/background_premium.dart';
import '../../../../base_widget/izi_loading.dart';
import '../../../../base_widget/izi_screen.dart';
import '../../../../utils/color_resources.dart';
import 'change_language_controller.dart';

class ChangeLanguagePage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(title: 'change_language'.tr),
      body: GetBuilder(
        init: ChangeLanguageController(),
        builder: (ChangeLanguageController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_2X,
                    0,
                  ),
                  width: IZIDimensions.iziSize.width,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_2X,
                    ),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      ImagesPath.vietnam_flag,
                    ),
                    title: Text(
                      'vietnamese'.tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Radio<int>(
                      activeColor: ColorResources.PRIMARY_APP,
                      value: controller.vietNamLanguageValue,
                      groupValue: controller.groupValueLanguage,
                      onChanged: (val) {
                        controller.onChangeRadioButton(val: val!);
                      },
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  width: IZIDimensions.iziSize.width,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_2X,
                    ),
                  ),
                  child: ListTile(
                    leading: SvgPicture.asset(
                      ImagesPath.english_flag,
                    ),
                    title: Text(
                      'english'.tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: Radio<int>(
                      activeColor: ColorResources.PRIMARY_APP,
                      value: controller.englishLanguageValue,
                      groupValue: controller.groupValueLanguage,
                      onChanged: (val) {
                        controller.onChangeRadioButton(val: val!);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
