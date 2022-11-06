import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/village/vilage_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/cart/address_delivery/address_delivery_controller.dart';
import 'package:template/view/screen/cart/address_delivery/editaddress/edit_address_controller.dart';
import '../../../../../base_widget/background/backround_appbar.dart';
import '../../../../../base_widget/izi_app_bar.dart';

class EditAddessPage extends GetView<EditAddressController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      safeAreaBottom: false,
      appBar: IZIAppBar(
          title:
              controller.popupMenuItemAddress == PopupMenuItemAddress.update ? 'Sửa địa chỉ nhận hàng' : 'Thêm địa chỉ',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),
      body: GetBuilder(
        init: EditAddressController(),
        builder: (EditAddressController controller) {
          return GestureDetector(
            onTap: () {
              IZIOther.primaryFocus();
            },
            child: Container(
              color: ColorResources.NEUTRALS_11,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  //  tỉnh/tp
                  ValueListenableBuilder<List<ProvinceResponse>>(
                    valueListenable: controller.provincesList,
                    builder: (_, value, __) {
                      return Obx(() {
                        return dropDownWidget(
                          "Tĩnh/TP",
                          controller.provincesList.value,
                          controller.province.value.id == null ? null : controller.province.value,
                          "Chọn Tỉnh/TP",
                          controller.isShowError.isTrue && controller.province.value.id == null
                              ? "Vui lòng chọn tỉnh thành phố"
                              : null,
                          (dynamic province) {
                            controller.setProvince(province as ProvinceResponse);
                          },
                        );
                      });
                    },
                  ),

                  //  Quận/Huyện
                  ValueListenableBuilder<List<DistrictResponse>>(
                    valueListenable: controller.districtList,
                    builder: (_, value, __) {
                      return Obx(() {
                        return dropDownWidget(
                          "Quận huyện",
                          value,
                          controller.district.value.id == null ? null : controller.district.value,
                          "Quận / huyện",
                          controller.isShowError.isTrue && controller.district.value.id == null
                              ? "Vui lòng chọn quận huyện"
                              : null,
                          (dynamic district) {
                            controller.setDistrict(district as DistrictResponse);
                          },
                        );
                      });
                    },
                  ),

                  //  phường/xã
                  ValueListenableBuilder<List<VillageResponse>>(
                    valueListenable: controller.villageList,
                    builder: (_, value, __) {
                      return Obx(() {
                        return dropDownWidget(
                          "Phường xã",
                          value,
                          controller.village.value.id == null ? null : controller.village.value,
                          "Phường / xã",
                          controller.isShowError.isTrue &&
                                  controller.village.value.id == null &&
                                  controller.checkAddress() == false
                              ? "Vui lòng chọn phường xã"
                              : null,
                          (dynamic village) {
                            controller.setVillage = village as VillageResponse;
                          },
                        );
                      });
                    },
                  ),

                  // địa chỉ
                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isShowErrorNotifi,
                    builder: (_, value, __) {
                      return iziInputWidget(
                        "Địa chỉ cụ thể ",
                        controller.address.value.addressDetail,
                        controller.address.value.addressDetail ?? "Nhập địa chỉ",
                        (String addressDetail) {
                          controller.setAddressDetail = addressDetail;
                          controller.onHide();
                        },
                        errorText: "Địa chủ cụ thể không được để trống",
                        error: value && controller.addressDetail.isEmpty ? "Địa chủ cụ thể không được để trống" : null,
                        isValidate: (bool val) {
                          controller.isValidate[3] = val;
                        },
                      );
                    },
                  ),

                  ValueListenableBuilder<bool>(
                    valueListenable: controller.isShowErrorNotifi,
                    builder: (_, value, __) {
                      return iziInputWidget(
                        "Họ và tên người nhận",
                        controller.address.value.fullName,
                        "Nhập vào tên người nhận",
                        (String name) {
                          controller.setName = name;
                          controller.onHide();
                        },
                        errorText: "Họ và tên không được để trống",
                        error: value && controller.addressDetail.isEmpty ? "Họ và tên không được để trống" : null,
                        isValidate: (bool val) {
                          controller.isValidate[4] = val;
                        },
                      );
                    },
                  ),

                  iziInputWidgetNumber(
                    "Số điện thoại",
                    controller.address.value.phone,
                    "Nhập số điện thoại",
                    (String phone) {
                      controller.setPhone = phone;
                      controller.onHide();
                    },
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Đặt làm địa chỉ mặc định",
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        ValueListenableBuilder(
                          valueListenable: controller.isDefaultAddress,
                          builder: (_, value, __) {
                            return Switch(
                              activeColor: ColorResources.ORANGE,
                              value: controller.isDefaultAddress.value,
                              onChanged: (bool value) {
                                controller.onChangedSwitch();
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),

                  IZIButton(
                    margin: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_4X * 2,
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                      bottom: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    colorBG: ColorResources.ORANGE,
                    onTap: () {
                      controller.handleCompleteAddress();
                    },
                    label: 'Hoàn thành',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// Fumction Box IZI Input
  ///
  Container iziInputWidget(
    String? label,
    String? initValue,
    String placeHolder,
    Function(String) onChanged, {
    bool isDatePicker = false,
    required String? error,
    required String errorText,
    required Function(bool val) isValidate,
  }) {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: IZIInput(
        onChanged: onChanged,
        isDatePicker: isDatePicker,
        fillColor: ColorResources.WHITE,
        borderRadius: IZIDimensions.BORDER_RADIUS_6X,
        label: label,
        labelStyle: TextStyle(
            color: ColorResources.PRIMARY_9,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w600,
            fontSize: IZIDimensions.FONT_SIZE_H6),
        initValue: initValue,
        type: IZIInputType.TEXT,
        validate: (String val) {
          if (val.isEmpty) {
            return errorText;
          }
          return null;
        },
        errorText: error,
        isValidate: (bool val) {
          isValidate(val);
        },
        isRequired: true,
        placeHolder: placeHolder,
      ),
    );
  }

  ///
  /// Fumction Box IZI Input
  ///
  Container iziInputWidgetNumber(String? label, String? initValue, String placeHolder, Function(String) onChanged,
      {bool isDatePicker = false}) {
    return Container(
      margin: EdgeInsets.only(
          bottom: IZIDimensions.SPACE_SIZE_3X, left: IZIDimensions.SPACE_SIZE_3X, right: IZIDimensions.SPACE_SIZE_3X),
      child: ValueListenableBuilder<bool>(
        valueListenable: controller.isShowErrorNotifi,
        builder: (_, value, __) {
          return IZIInput(
            onChanged: onChanged,
            isDatePicker: isDatePicker,
            fillColor: ColorResources.WHITE,
            borderRadius: IZIDimensions.BORDER_RADIUS_6X,
            label: label,
            isRequired: true,
            initValue: initValue,
            labelStyle: TextStyle(
                color: ColorResources.PRIMARY_9,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_H6),
            type: IZIInputType.PHONE,
            placeHolder: placeHolder,
            isValidate: (bool val) {
              controller.isValidate[5] = val;
            },
            errorText: controller.phone.isEmpty && value ? 'Số điện thoại không được để trống' : null,
          );
        },
      ),
    );
  }
}

Widget appBar(
  BuildContext context,
) {
  return Row(
    children: [
      Text(
        'Tài khoản ',
        style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

///
/// Fumction Box Lĩnh vực
///
Container boxField(String title) {
  return Container(
    width: IZISize.size.width,
    margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_3X),
    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_5X),
    decoration: BoxDecoration(
      color: ColorResources.WHITE,
      borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
    ),
    child: Text(
      title,
      style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w600, color: ColorResources.RED),
    ),
  );
}

///
/// Fumction DropDownWidget
///
Container dropDownWidget(
  String? label,
  List<dynamic> data,
  dynamic value,
  String? hint,
  String? error,
  Function(dynamic) onChanged,
) {
  return Container(
    width: IZISize.size.width,
    margin: EdgeInsets.only(
      bottom: IZIDimensions.SPACE_SIZE_3X,
      left: IZIDimensions.SPACE_SIZE_3X,
      right: IZIDimensions.SPACE_SIZE_3X,
    ),
    child: DropDownButton<dynamic>(
      isSort: false,
      label: label,
      data: data,
      value: value,
      hint: hint,
      isRequired: true,
      errorMessage: error,
      onChanged: onChanged,
    ),
  );
}
