import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/update_new_password/update_new_password_controller.dart';
import '../../../../base_widget/background/background_auth.dart';
import '../../../../base_widget/izi_button.dart';

class UpdateNewPasswordPage extends GetView<UpdateNewPasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        builder: (UpdateNewPasswordController controller) {
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
                        "Đổi mật khẩu",
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
                        "Nhập vào số điện thoại để cập\nnhật lại mật khẩu",
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
                  phoneInput(),
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  ),
                  // password
                  passwordInput(),

                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  ),
                  passwordNewInput(),

                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 80,
                  ),
                  //Button UpdateNewPassword
                  updateNewPasswordButton(),

                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 20,
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
    );
  }

  Widget passwordNewInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      label: 'Mật khẩu mới',
      placeHolder: '***********',
      prefixIcon: const Icon(
        Icons.lock,
      ),
      borderRadius: 5,
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      disbleError: true,
    );
  }

  Widget passwordInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      label: 'Mật khẩu cũ',
      placeHolder: '*********',
      disbleError: true,
      prefixIcon: const Icon(
        Icons.lock,
      ),
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      borderRadius: 5,
    );
  }

  Widget updateNewPasswordButton() {
    return IZIButton(
      onTap: () {
        controller.onUpdateNewPassword();
      },
      label: "Hoàn thành",
      borderRadius: 10,
    );
  }
}
