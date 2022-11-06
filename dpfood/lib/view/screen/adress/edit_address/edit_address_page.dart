import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_input.dart';
import 'edit_address_controller.dart';

class EditAddressPage extends GetView<EditAddressController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      safeAreaBottom: false,
      appBar: IZIAppBar(
        title: controller.title,
        colorBG: ColorResources.PRIMARY_1,
        colorTitle: ColorResources.WHITE,
      ),
      body: Container(
        color: ColorResources.NEUTRALS_7,
        child: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_4X,
                ),
                Obx(() {
                  return IZIInput(
                    type: IZIInputType.TEXT,
                    placeHolder: controller.type == 0
                        ? 'Home'
                        : controller.type == 1
                            ? 'Công ty'
                            : 'Tiều đề',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    allowEdit: controller.type == 2,
                    onChanged: (val) {
                      controller.addressRequest.title = val.toString();
                      controller.isShowError.value = false;
                    },
                    validate: (val) {
                      if (IZIValidate.nullOrEmpty(val)) {
                        return 'Tiêu đề không được để trống';
                      }
                      return null;
                    },
                    isValidate: (val) {
                      controller.validates[1] = val;
                    },
                    errorText: controller.isShowError.isTrue && controller.validates[1] == false ? "Tiêu đề không được để trống" : '',
                    fillColor: ColorResources.WHITE,
                  );
                }),
                Obx(() {
                  return controller.isShowError.isTrue && controller.validates[1] == false
                      ? SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        )
                      : const SizedBox();
                }),
                Container(
                  height: 0.2,
                  color: ColorResources.PRIMARY_1,
                ),
                Obx(() {
                  return IZIInput(
                    type: IZIInputType.TEXT,
                    placeHolder: 'Nhập địa chỉ của bạn',
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    initValue: IZIValidate.nullOrEmpty(controller.address) ? '' : controller.address!.name ?? '',
                    onChanged: (val) {
                      controller.addressRequest.name = val.toString();
                      controller.isShowError.value = false;
                    },
                    validate: (val) {
                      if (IZIValidate.nullOrEmpty(val)) {
                        return 'Địa chỉ không được để trống';
                      }
                      return null;
                    },
                    isValidate: (val) {
                      controller.validates[0] = val;
                    },
                    errorText: controller.isShowError.isTrue && controller.validates[0] == false ? "Địa chỉ không được để trống" : '',
                  );
                }),
                Obx(() {
                  return controller.isShowError.isTrue && controller.validates[0] == false
                      ? SizedBox(
                          height: IZIDimensions.SPACE_SIZE_2X,
                        )
                      : const SizedBox();
                }),
                Container(
                  height: 0.2,
                  color: ColorResources.PRIMARY_1,
                ),
                IZIInput(
                  type: IZIInputType.TEXT,
                  placeHolder: 'Ghi chú cho tài xế',
                  hintStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  initValue: IZIValidate.nullOrEmpty(controller.address) ? '' : controller.address!.note ?? '',
                  onChanged: (val) {
                    controller.addressRequest.note = val.toString();
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.bottom + IZIDimensions.ONE_UNIT_SIZE * 200,
                ),
              ],
            ),
          ),
        ),
      ),
      widgetBottomSheet: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: IZIButton(
          onTap: () {
            if (controller.isUpdate == true) {
              controller.onUpdateAddress();
            } else {
              controller.addAddress();
            }
          },
          label: 'Cập nhật',
        ),
      ),
    );
  }

  ///
  /// Address
  ///
  Widget address({required IconData icon, required String title}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: ColorResources.PRIMARY_5,
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStyleH6.copyWith(
                      color: ColorResources.NEUTRALS_2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Lưu địa chỉ",
                        style: textStyleSpan.copyWith(
                          color: ColorResources.PRIMARY_1,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: ColorResources.NEUTRALS_4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          color: ColorResources.PRIMARY_1,
        ),
      ],
    );
  }
}
