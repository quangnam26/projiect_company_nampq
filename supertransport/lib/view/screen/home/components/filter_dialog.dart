// ignore_for_file: invalid_use_of_protected_member


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/home/home_controller.dart';

import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_drop_down_button.dart';
import '../../../../base_widget/izi_input.dart';
import '../../../../helper/izi_dimensions.dart';

class FilterDialog extends StatelessWidget {
  final Function()? onTapConfirm;
  final Function()? onTapRefresh;
  final Function(String val)? onSetNgayDi;
  final Function(String val)? onChangedLoaiHinh;
  final Function(ProvinceResponse val)? onChangedNoiDi;
  final Function(ProvinceResponse val)? onChangedNoiDen;
  
  const FilterDialog({
    this.onTapConfirm,
    this.onTapRefresh,
    this.onSetNgayDi,
    this.onChangedLoaiHinh,
    this.onChangedNoiDi,
    this.onChangedNoiDen,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          IZIDimensions.BORDER_RADIUS_4X,
        ),
      ),
      backgroundColor: ColorResources.WHITE,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
          vertical: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Bộ lọc tìm kiếm",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: IZIDimensions.FONT_SIZE_H5,
              ),
            ),
            SizedBox(
              height: IZIDimensions.ONE_UNIT_SIZE * 40,
            ),
            GetX(
              builder: (HomeController controller) {
                return DropDownButton<String>(
                  data: controller.transportsType.value.keys.toList(),
                  onChanged: (val) {
                    if (!IZIValidate.nullOrEmpty(onChangedLoaiHinh)) {
                      onChangedLoaiHinh!(val!);
                    }
                  },
                  isRequired: false,
                  borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
                  value: IZIValidate.nullOrEmpty(controller.transportType) ? null : controller.transportType!.value,
                  hint: "Chọn loại hình",
                  label: "Chọn loại hình",
                  width: IZIDimensions.iziSize.width,
                );
              },
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_4X,
            ),
            GetX(
              builder: (HomeController controller) {
                return DropDownButton<ProvinceResponse>(
                  data: controller.provinces.value,
                  onChanged: (val) {
                    if (!IZIValidate.nullOrEmpty(onChangedNoiDi)) {
                      onChangedNoiDi!(val!);
                    }
                  },
                  isRequired: false,
                  borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
                  value: IZIValidate.nullOrEmpty(controller.provinceFrom) ? null : controller.provinceFrom!.value,
                  hint: "Chọn nơi đi",
                  label: "Chọn nơi đi",
                  width: IZIDimensions.iziSize.width,
                );
              },
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_4X,
            ),
            GetX(
              init: HomeController(),
              builder: (HomeController controller) {
                return DropDownButton<ProvinceResponse>(
                  data: controller.provinces.value,
                  onChanged: (val) {
                    if (!IZIValidate.nullOrEmpty(onChangedNoiDen)) {
                      onChangedNoiDen!(val!);
                    }
                  },
                  isRequired: false,
                  borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
                  value: IZIValidate.nullOrEmpty(controller.provinceTo) ? null : controller.provinceTo!.value,
                  hint: "Chọn nơi đến",
                  label: "Chọn nơi đến",
                  width: IZIDimensions.iziSize.width,
                );
              },
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_4X,
            ),
            IZIInput(
              type: IZIInputType.TEXT,
              isDatePicker: true,
              label: 'Chọn ngày đi',
              placeHolder: "12-12-2022",
              isNotShadown: false,
              minimumDate: DateTime(2021),
              initDate: DateTime.now(),
              borderRadius: IZIDimensions.ONE_UNIT_SIZE * 100,
              onChanged: (val) {
                if (!IZIValidate.nullOrEmpty(onSetNgayDi)) {
                  onSetNgayDi!(val);
                }
              },
            ),
            Row(
              children: [
                Expanded(
                  child: refreshButton(),
                ),
                SizedBox(
                  width: IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
                Expanded(
                  child: button(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Button
  ///
  Widget button() {
    return IZIButton(
      onTap: () {
        if (!IZIValidate.nullOrEmpty(onTapConfirm)) {
          onTapConfirm!();
        } else {
          Get.back();
        }
      },
      label: 'Xác nhận',
      width: IZIDimensions.ONE_UNIT_SIZE * 200,
      fontSizedLabel: IZIDimensions.ONE_UNIT_SIZE * 25,
      padding: EdgeInsets.all(
        IZIDimensions.ONE_UNIT_SIZE * 10,
      ),
      borderRadius: 7,
    );
  }

  ///
  /// Button
  ///
  Widget refreshButton() {
    return IZIButton(
      onTap: () {
        if (!IZIValidate.nullOrEmpty(onTapRefresh)) {
          onTapRefresh!();
        } else {
          Get.back();
        }
      },
      label: 'Làm mới',
      width: IZIDimensions.ONE_UNIT_SIZE * 200,
      fontSizedLabel: IZIDimensions.ONE_UNIT_SIZE * 25,
      padding: EdgeInsets.all(
        IZIDimensions.ONE_UNIT_SIZE * 10,
      ),
      borderRadius: 7,
      colorBG: ColorResources.NEUTRALS_4,
    );
  }
}
