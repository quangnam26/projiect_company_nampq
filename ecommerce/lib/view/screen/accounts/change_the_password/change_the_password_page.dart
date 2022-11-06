import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/accounts/change_the_password/change_the_password_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../base_widget/izi_input.dart';
import '../../../../helper/izi_size.dart';
import '../../../../utils/color_resources.dart';

class ChangeThePassWordPage extends GetView<ChangeThePassWordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: !IZIValidate.nullOrEmpty(Get.arguments)
            ? 'Nhập mật khẩu mới'
            : 'Thay đổi mật khẩu',
        iconBack: GestureDetector(
          onTap: () {
            // if (!IZIValidate.nullOrEmpty(Get.arguments)) {
            //   Get.offAllNamed(SplashRoutes.LOGIN);
            // } else {
              Get.back();
            // }
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_3,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          init: ChangeThePassWordController(),
          builder: (ChangeThePassWordController controller) {
            return Container(
              height: IZISize.size.height,
              color: ColorResources.NEUTRALS_14,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X * 2,
                        ),
                        if (!IZIValidate.nullOrEmpty(Get.arguments))
                          const SizedBox()
                        else
                          Padding(
                            padding: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_4X,
                              right: IZIDimensions.SPACE_SIZE_4X,
                              bottom: IZIDimensions.SPACE_SIZE_4X,
                            ),
                            child: IZIInput(
                              label: 'Mật khẩu cũ',
                              // borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                              placeHolder: "Nhập mật khẩu cũ ",
                              borderSide: BorderSide.none,
                              type: IZIInputType.PASSWORD,
                              isBorder: true,
                              // disbleError: true,
                              fillColor: ColorResources.WHITE,
                              initValue: controller.oldPassword,
                              onChanged: (val) {
                                controller.inputOldPassWord(val);
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
                            label: 'Mật khẩu mới',
                            // borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                            placeHolder: "Nhập mật khẩu mới ",
                            borderSide: BorderSide.none,
                            type: IZIInputType.PASSWORD,
                            isBorder: true,
                            // disbleError: true,
                            fillColor: ColorResources.WHITE,
                            initValue: controller.newPassWord,
                            onChanged: (val) {
                              controller.inputNewPassWord(val);
                              print("mật khẩu mới $val");
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
                            label: 'Xác nhận mật khẩu',
                            // borderRadius: IZIDimensions.ONE_UNIT_SIZE * 50,
                            placeHolder: "Xác nhận lại mật khẩu mới ",
                            borderSide: BorderSide.none,
                            type: IZIInputType.PASSWORD,
                            isBorder: true,
                            // disbleError: true,
                            fillColor: ColorResources.WHITE,
                            initValue: controller.confirmPassWord,
                            onChanged: (val) {
                              controller.inputConfirmPassWord(val);
                              print('xác nhận mk cũ $val');
                            },
                          ),
                        ),
                      ],
                    ),
                  )),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: IZIButton(
                      margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                          vertical: IZIDimensions.SPACE_SIZE_4X * 2),
                      colorBG: Colors.orange,
                      onTap: () {
                        controller.updateData();
                      },
                      label: 'Hoàn thành',
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),

      // widgetBottomSheet: Container(
      //   child: IZIButton(
      //     margin: EdgeInsets.symmetric(
      //         horizontal: IZIDimensions.SPACE_SIZE_4X,
      //         vertical: IZIDimensions.SPACE_SIZE_4X * 2),
      //     colorBG: Colors.orange,
      //     onTap: () {
      //       controller.updateData();
      //     },
      //     label: 'Hoàn thành',
      //   ),
      // ),
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
    {bool isDatePicker = false}) {
  return Container(
    margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_4X * 1.2,
        left: IZIDimensions.SPACE_SIZE_3X,
        right: IZIDimensions.SPACE_SIZE_3X),
    child: IZIInput(
      onChanged: onChanged,
      isDatePicker: isDatePicker,
      fillColor: ColorResources.WHITE,
      // isBorder: true,
      // colorBorder: const Color.fromRGBO(196, 196, 196, 0.8),
      borderRadius: IZIDimensions.BORDER_RADIUS_6X,
      // disbleError: true,
      label: label,
      type: IZIInputType.PASSWORD,
      placeHolder: placeHolder,
      // suffixIcon: suffixIcon,
      // onTap:ontap ,
    ),
  );
}
