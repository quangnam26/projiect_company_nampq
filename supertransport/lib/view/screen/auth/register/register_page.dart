import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/register/register_controller.dart';
import '../../../../base_widget/background/background_auth.dart';
import '../../../../base_widget/izi_button.dart';

class RegisterPage extends GetView<RegisterController> {
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
          builder: (RegisterController controller) {
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
                        "Đăng ký",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: ColorResources.WHITE,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 120,
                      ),
                      Text(
                        "Đăng ký tài khoản mới",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H5,
                          color: ColorResources.PRIMARY_2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // Form
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 60,
                      ),
                      // Name
                      nameInput(),
                      // Phone
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 30,
                      ),
                      phoneInput(),
                      //passwordInput
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 30,
                      ),
                      passwordInput(),
                      //repeatPasswordInput
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 30,
                      ),
                      repeatPasswordInput(),
                  
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 10,
                      ),
                      // Forget Password
                      // forgetPassword(),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 50,
                      ),
                      //Button Register
                      registerButton(),
                      Expanded(
                        child: registerAccount(),
                      ),
                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 20,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).viewPadding.bottom * 2.5,
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
      borderRadius: 5,
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      disbleError: true,
      onChanged: (val){
        controller.phone = val;
      },
    );
  }

  Widget nameInput() {
    return IZIInput(
      type: IZIInputType.TEXT,
      label: 'Họ và tên',
      placeHolder: 'Nguyễn Văn A',
      prefixIcon: const Icon(
        CupertinoIcons.person,
      ),
      borderRadius: 5,
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      disbleError: true,
      onChanged: (val){
        controller.name = val;
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

  Widget repeatPasswordInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      label: 'Xác nhận mật khẩu',
      placeHolder: '*********',
      disbleError: true,
      prefixIcon: const Icon(
        Icons.lock,
      ),
      fillColor: ColorResources.NEUTRALS_4.withOpacity(0.25),
      borderRadius: 5,
      onChanged: (val){
        controller.repeatPassword = val;
      },
    );
  }

  

  Widget registerAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Bạn đã có tài khoản? ",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6,
            color: ColorResources.WHITE,
            fontWeight: FontWeight.w300,
          ),
        ),
        GestureDetector(
          onTap: (){
            controller.onToLogin();
          },
          child: Text(
            "Đăng nhập",
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

  Widget registerButton() {
    return IZIButton(
      onTap: () {
        controller.signUp();
      },
      label: "Đăng ký",
      borderRadius: 10,
    );
  }
}
