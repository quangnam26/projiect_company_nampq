// ignore_for_file: cast_nullable_to_non_nullable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:izi_izi_checkbox_grouped/checkbox_grouped.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/areas_of_expertise/areas_of_expertise_controller.dart';

import '../../../helper/izi_validate.dart';

class AreasOfExpertisePage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: AreasOfExpertiseController(),
      builder: (AreasOfExpertiseController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return WillPopScope(
          onWillPop: () async {
            if (controller.typeRegister == '1') {
              Get.back();
              return true;
            } else {
              return false;
            }
          },
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: ColorResources.BACKGROUND,
              appBar: AppBar(
                leading: controller.typeRegister == '1'
                    ? GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: ColorResources.BLACK,
                          size: IZIDimensions.ONE_UNIT_SIZE * 45,
                        ),
                      )
                    : const SizedBox(),
                title: Text(
                  "areas_of_expertise".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    color: ColorResources.BLACK,
                  ),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: ColorResources.BACKGROUND,
              ),
              body: Container(
                width: IZIDimensions.iziSize.width,
                color: ColorResources.BACKGROUND,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_5X,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_3X,
                        ),
                        child: Text(
                          "5_expertise".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            color: ColorResources.BLACK.withOpacity(.75),
                          ),
                        ),
                      ),

                      /// Multi check box areas of expertise.
                      _multiCheckBoxAreasOfExpertise(controller),

                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        width: IZIDimensions.iziSize.width,
                        color: ColorResources.WHITE,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_1X,
                                right: IZIDimensions.SPACE_SIZE_3X,
                              ),
                              child: Obx(() => Checkbox(
                                    activeColor: ColorResources.PRIMARY_APP,
                                    value: controller.isCheckedOther.value,
                                    onChanged: (val) {
                                      controller.onChangedChecked(val!);
                                    },
                                  )),
                            ),
                            Expanded(
                              child: Text(
                                "another_purpose".tr,
                                style: TextStyle(
                                  color: ColorResources.PRIMARY_APP,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Obx(() {
                        if (controller.isCheckedOther.value) {
                          return Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.SPACE_SIZE_3X,
                            ),
                            child: Column(
                              children: [
                                /// Help you import.
                                Container(
                                  margin: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_2X,
                                  ),
                                  child: _helpYouImport(controller),
                                ),

                                /// Import another purpose.
                                _anotherPurposeImport(controller),
                              ],
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                      SizedBox(
                        height: SPACE_BOTTOM_SHEET,
                      ),
                    ],
                  ),
                ),
              ),
              bottomSheet: GetBuilder(
                init: AreasOfExpertiseController(),
                builder: (AreasOfExpertiseController controller) {
                  /// Button Register or Continue
                  return _buttonRegisterOrContinue(controller);
                },
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// Multi check box areas of expertise.
  ///
  Widget _multiCheckBoxAreasOfExpertise(AreasOfExpertiseController controller) {
    return Obx(
      () => ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.specializeAndSubSpecializeResponseList.length,
        itemBuilder: (context, index) {
          return SimpleGroupedCheckbox<String>(
            isLeading: true,
            controller: controller.multipleCheckControllerList![index],
            itemsTitle: List.generate(controller.specializeAndSubSpecializeResponseList[index].subSpecializes!.length, (i) => controller.specializeAndSubSpecializeResponseList[index].subSpecializes![i].name.toString()),
            values: List.generate(controller.specializeAndSubSpecializeResponseList[index].subSpecializes!.length, (i) => controller.specializeAndSubSpecializeResponseList[index].subSpecializes![i].id.toString()),
            groupStyle: GroupStyle(
              activeColor: ColorResources.PRIMARY_APP,
              groupTitleStyle: TextStyle(
                color: ColorResources.PRIMARY_APP,
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                fontWeight: FontWeight.w600,
              ),
              itemTitleStyle: TextStyle(
                color: ColorResources.BLACK,
                fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
              ),
            ),
            groupTitle: controller.specializeAndSubSpecializeResponseList[index].name.toString().toUpperCase(),
            onItemSelected: (data) {
              print(data);
              final Function onTap = controller.onChangedSimpleGroupedCheckbox[index] as Function;
              onTap(data);
            },
            isExpandableTitle: !IZIValidate.nullOrEmpty(controller.specializeAndSubSpecializeResponseList[index].subSpecializes),
          );
        },
      ),
    );
  }

  ///
  /// Help you import.
  ///
  Widget _helpYouImport(AreasOfExpertiseController controller) {
    return Obx(
      () => IZIInput(
        type: IZIInputType.MULTILINE,
        textInputAction: TextInputAction.newline,
        maxLine: 5,
        isBorder: true,
        label: "input_another_purpose_1".tr,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        placeHolder: 'input_another_purpose_1'.tr,
        errorText: "",
        onChanged: (val) {
          controller.onChangedHelpYou(val);
        },
        initValue: controller.initHelpYou.value,
      ),
    );
  }

  ///
  /// Import another purpose.
  ///
  Widget _anotherPurposeImport(AreasOfExpertiseController controller) {
    return Obx(
      () => IZIInput(
        type: IZIInputType.MULTILINE,
        textInputAction: TextInputAction.newline,
        maxLine: 5,
        isBorder: true,
        label: "input_another_purpose_2".tr,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        placeHolder: "hint_text_another_purpose_2".tr,
        errorText: "",
        onChanged: (val) {
          controller.onChangedSuggestedTopic(val);
        },
        initValue: controller.initSuggestedTopic.value,
      ),
    );
  }

  ///
  /// Button Register or Continue
  ///
  Widget _buttonRegisterOrContinue(AreasOfExpertiseController controller) {
    return IZIButton(
      isEnabled: controller.genEnableButton(),
      margin: EdgeInsets.fromLTRB(
        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
        0,
        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
        IZIDimensions.SPACE_SIZE_2X,
      ),
      onTap: () {
        controller.goToThankYouPage();
      },
      label: controller.typeRegister == '1' ? "update".tr : "continue".tr,
    );
  }
}
