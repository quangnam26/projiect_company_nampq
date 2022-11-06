import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/view/screen/accounts/personalinformation/inputpersonalinformation/input_personal_information_controller.dart';
import '../../../../../base_widget/background/backround_appbar.dart';
import '../../../../../base_widget/izi_app_bar.dart';
import '../../../../../base_widget/izi_drop_down_button.dart';
import '../../../../../base_widget/izi_image.dart';
import '../../../../../base_widget/izi_input.dart';
import '../../../../../base_widget/izi_text.dart';
import '../../../../../helper/izi_date.dart';
import '../../../../../helper/izi_other.dart';
import '../../../../../utils/app_constants.dart';
import '../../../../../utils/color_resources.dart';

class InputPersonalInformationPage
    extends GetView<InputPersonalInformationController> {
  @override
  Widget build(BuildContext context) {
    print(" ${controller.sexController}");
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Thông tin cá nhân',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          init: InputPersonalInformationController(),
          builder: (InputPersonalInformationController controller) {
            return Container(
              color: ColorResources.NEUTRALS_6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.pickImage();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_4X,
                          bottom: IZIDimensions.SPACE_SIZE_3X),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: ColorResources.RED,
                                  shape: BoxShape.circle,
                                ),
                                width: IZIDimensions.iziSize.width * .3,
                                height: IZIDimensions.iziSize.width * .3,
                                child: CircleAvatar(
                                  radius: 35,
                                  child: ClipOval(
                                    child: controller.files.isEmpty
                                        ? IZIImage(
                                            controller.fileAvatar.toString())
                                        : Container(
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            child: Image.file(
                                              controller.files.first,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            bottom: 6,
                            left: IZIDimensions.iziSize.width * .51,
                            child: Container(
                              decoration: const BoxDecoration(
                                color: ColorResources.GREY,
                                shape: BoxShape.circle,
                              ),
                              width: IZIDimensions.ONE_UNIT_SIZE * 40,
                              height: IZIDimensions.ONE_UNIT_SIZE * 40,
                              child: Center(
                                child: Icon(
                                  Icons.add_a_photo_rounded,
                                  size: IZIDimensions.ONE_UNIT_SIZE * 30,
                                  color: ColorResources.WHITE,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: IZIDimensions.SPACE_SIZE_4X,
                        right: IZIDimensions.SPACE_SIZE_4X,
                        bottom: IZIDimensions.SPACE_SIZE_3X),
                    //nhập tên
                    child: IZIInput(
                      label: 'Họ và tên',
                      labelStyle: TextStyle(
                          color: ColorResources.PRIMARY_9,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6),
                      // borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                      placeHolder: "Nhập họ và tên",
                      borderSide: BorderSide.none,
                      type: IZIInputType.TEXT,
                      isBorder: true,
                      fillColor: ColorResources.WHITE,
                      initValue: controller.fullNameController,
                      onChanged: (val) {
                        controller.onChangedValueName(val);
                        print("abc $val");
                      },

                      errorText: controller.errorTextName,
                      validate: (val) {
                        controller.onValidateName(val);
                        print("sss $val");
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                      bottom: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: DropDownButton<String>(
                      borderRadius: 0,
                      data: gender,
                      isRequired: false,
                      value: controller.sexController,
                      label: "Giới tính",
                      hint: "Chọn giới tính",
                      onChanged: (val) {
                        print("aaa $val");
                        controller.onChangedGender(val!);
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                      bottom: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    //ngày sinh
                    child: IZIInput(
                      labelStyle: TextStyle(
                          color: ColorResources.PRIMARY_9,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6),
                      minimumDate: DateTime(1960),
                      label: 'Ngày sinh',
                      borderRadius: 0,
                      placeHolder: 'vui long nhập ngày',
                      // IZIDate.formatDate(DateTime.now()),
                      type: IZIInputType.TEXT,
                      fillColor: ColorResources.WHITE,
                      disbleError: true,
                      // maximumDate: DateTime.now(),
                      initDate: DateTime.now(),
                      isDatePicker: true,
                      iziPickerDate: IZIPickerDate.CUPERTINO,
                      initValue: controller.bornController,
                      //  IZIDate.formatDate(
                      //   DateTime.fromMicrosecondsSinceEpoch(
                      //       int.parse(controller.bornController.toString())),
                      // ),
                      onChanged: (val) {
                        controller.onChangedBorn(val);
                        print('ngay sinh $val');
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                      bottom: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: IZIInput(
                      label: 'Email',
                      labelStyle: TextStyle(
                          color: ColorResources.PRIMARY_9,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6),
                      placeHolder: "Nhập Email",
                      borderSide: BorderSide.none,
                      type: IZIInputType.TEXT,
                      isBorder: true,
                      // disbleError: true,
                      fillColor: ColorResources.WHITE,
                      initValue: controller.emailController,
                      onChanged: (val) {
                        controller.onChangedEmail(val);
                      },
                      errorText: controller.errorEmail,
                      validate: (val) {
                        controller.onVailiDateEmail(val);
                        print('email $val');
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                      bottom: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: IZIInput(
                      labelStyle: TextStyle(
                          color: ColorResources.PRIMARY_9,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H6),
                      type: IZIInputType.PHONE,
                      placeHolder: "Nhập số điện thoại",
                      label: "Số điện thoại",
                      borderSide: BorderSide.none,
                      errorText: controller.errorNumber,
                      fillColor: ColorResources.WHITE,
                      initValue: IZIOther().formatPhoneNumber(
                          controller.phoneNumberController.toString()),
                      onChanged: (val) {
                        controller.onChangedNumber(val);
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_5X * 2,
                  ),
                  IZIButton(
                    margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X),
                    colorBG: ColorResources.ORANGE,
                    onTap: () {
                      controller.getGoToBack();
                    },
                    label: 'Hoàn thành',
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget appBar(
  BuildContext context,
) {
  return Row(
    children: [
      IZIText(
        text: 'Tài khoản ',
        style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

///
/// Fumction Box IZI Input
///
Container iziInputWidget(
    String? label, String placeHolder, Function(String) onChanged,
    {required bool? isDatePicker}) {
  return Container(
    margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X),
    child: IZIInput(
      fillColor: ColorResources.WHITE,
      // cursorColor: Colors.red,
      onChanged: onChanged,
      isDatePicker: isDatePicker,

      labelStyle: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w400,
          color: ColorResources.BLACK),
      borderRadius: IZIDimensions.BORDER_RADIUS_7X,
      disbleError: true,
      label: label,
      type: IZIInputType.TEXT,
      placeHolder: placeHolder,
    ),
  );
}

///
/// Fumction Box IZI Input
///
Container iziInputWidgetNumber(
    String? label, String placeHolder, Function(String) onChanged,
    {bool isDatePicker = false}) {
  return Container(
    margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X),
    child: IZIInput(
      fillColor: ColorResources.WHITE,
      onChanged: onChanged,
      isDatePicker: isDatePicker,
      // isBorder: true,
      // colorBorder: const Color.fromRGBO(196, 196, 196, 0.8),
      borderRadius: IZIDimensions.BORDER_RADIUS_6X,
      disbleError: true,
      label: label,
      type: IZIInputType.NUMBER,
      placeHolder: placeHolder,
    ),
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
      style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w600,
          color: ColorResources.RED),
    ),
  );
}

///
/// Fumction DropDownWidget
///
Container dropDownWidget(String? label, List<String> data, String? value,
    String? hint, Function(String?) onChanged) {
  return Container(
    // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
    width: IZISize.size.width,
    margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X),
    child: DropDownButton<String>(
      isSort: false,
      label: label,
      data: data,
      value: value,
      hint: hint,
      isRequired: false,
      onChanged: onChanged,
    ),
  );
}
