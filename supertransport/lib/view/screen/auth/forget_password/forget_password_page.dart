import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_controller.dart';
import '../../../../base_widget/background/background_auth.dart';
import '../../../../base_widget/izi_button.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        builder: (ForgetPasswordController controller) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: IZIDimensions.ONE_UNIT_SIZE * 40,
            ),
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        "Quên mật khẩu",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: ColorResources.WHITE,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.onBack();
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorResources.WHITE,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                  ),
                  Column(
                    children: [
                      Text(
                        "Nhập vào số điện thoại",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: ColorResources.PRIMARY_2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Nhập vào số điện thoại để nhập\nvào mật khẩu mới",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                          color: ColorResources.NEUTRALS_3,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  // Form
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                  ),
                  // Phone
                  phoneInput(),
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  ),
                  Expanded(
                    child: Center(
                      child: nextButton(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget phoneInput() {
    return IZIInput(
      type: IZIInputType.PHONE,
      label: 'Số điện thoại',
      placeHolder: '0352972441',
      prefixIcon: const Icon(
        Icons.phone,
      ),
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      borderRadius: 5,
      disbleError: true,
      onChanged: (val){
        controller.phone = val;
      },
    );
  }

 

  Widget nextButton() {
    return IZIButton(
      onTap: () {
        controller.updatePassword();
      },
      label: "Tiếp tục",
      borderRadius: 10,
    );
  }
}
