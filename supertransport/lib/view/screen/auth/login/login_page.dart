import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/background/background_auth.dart';
import '../../../../base_widget/izi_button.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          builder: (LoginController controller) {
            return SingleChildScrollView(
              child: Container(
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
                        "Đăng nhập",
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
                            "Chào mừng bạn",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H5,
                              color: ColorResources.PRIMARY_2,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "Đăng nhập để tiếp tục",
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
                      passwordInput(),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 10,
                      ),
                      // Forget Password
                      forgetPassword(),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 50,
                      ),
                      //Button login
                      loginButton(),
                      Expanded(
                        child: registerAccount(),
                      ),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 50,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom * 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
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

  Widget passwordInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      label: 'Mật khẩu',
      placeHolder: '*********',
      disbleError: true,
      prefixIcon: const Icon(
        Icons.lock,
      ),
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      borderRadius: 5,
      onChanged: (val){
        controller.password = val;
      },
    );
  }

  Widget forgetPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Checkbox(
              value: controller.isRememberPassword,
              activeColor: ColorResources.PRIMARY_2,
              onChanged: (val) {
                controller.onChangedSavePassword();
              },
            ),
            Text(
              "Lưu mật khẩu",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.NEUTRALS_4,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            controller.onForgetPassword();
          },
          child: Text(
            "Quên mật khẩu",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.PRIMARY_2,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget registerAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Bạn chưa có tài khoản? ",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6,
            color: ColorResources.WHITE,
            fontWeight: FontWeight.w300,
          ),
        ),
        GestureDetector(
          onTap: (){
            controller.onRegister();
          },
          child: Text(
            "Đăng ký",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.WHITE,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  Widget loginButton() {
    return IZIButton(
      onTap: () {
        controller.onLogin();
      },
      label: "Đăng nhập",
      borderRadius: 10,
    );
  }
}
