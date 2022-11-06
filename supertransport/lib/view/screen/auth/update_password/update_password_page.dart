import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/background/background_auth.dart';
import '../../../../base_widget/izi_button.dart';
import 'update_password_controller.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        builder: (UpdatePasswordController controller) {
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
                  Text(
                    "Quên mật khẩu",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H5,
                      color: ColorResources.WHITE,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                  ),
                  Column(
                    children: [
                      Text(
                        "Thay đổi mật khẩu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: ColorResources.PRIMARY_2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "Nhập vào mật khẩu mới",
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

                  passwordNewInput(),

                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  ),
                  // password
                  passwordInput(),

                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 80,
                  ),
                  //Button UpdatePassword
                  updatePasswordButton(),

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

  Widget passwordNewInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      label: 'Mật khẩu mới',
      placeHolder: '*********',
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      prefixIcon: const Icon(
        Icons.lock,
      ),
      borderRadius: 5,
      disbleError: true,
      onChanged: (val){
        controller.newPassword = val;
      }
    );
  }

  Widget passwordInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      label: 'Xác nhận mật khẩu',
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      placeHolder: '*********',
      disbleError: true,
      prefixIcon: const Icon(
        Icons.lock,
      ),
      borderRadius: 5,
      onChanged: (val){
        controller.password = val;
      }
    );
  }

  Widget updatePasswordButton() {
    return IZIButton(
      onTap: () {
        controller.onUpdatePassword();
      },
      label: "Xác nhận",
      borderRadius: 10,
    );
  }
}
