import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../di_container.dart';
import '../../../../sharedpref/shared_preference_helper.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      // isSingleChildScrollView: false,
      safeAreaTop: false,
      background: Container(
        height: IZIDimensions.iziSize.height,
        width: IZIDimensions.iziSize.width,
        color: ColorResources.NEUTRALS_6,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          // init: LoginController(),
          builder: (LoginController controller) {
            return SingleChildScrollView(
              child: SizedBox(
                // height: IZIDimensions.iziSize.height,
                // width: IZIDimensions.iziSize.width,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      header(),
                      form(
                        context,
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

  ///
  /// Header
  ///
  Widget header() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.ONE_UNIT_SIZE * 40,
      ),
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X * 2,
          ),
          Center(
            child: SizedBox(
              height: IZIDimensions.ONE_UNIT_SIZE * 100,
              width: IZIDimensions.ONE_UNIT_SIZE * 100,
              child: IZIImage(
                ImagesPath.login,
              ),
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X * 1.5,
          ),
          Text(
            "Chào mừng bạn đến với Izi",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H5 * 0.9,
              color: ColorResources.NEUTRALS_2,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Text(
            "Tiếp tục đăng nhập",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
              color: ColorResources.NEUTRALS_5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  ///Form
  Widget form(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_4X * 4,
        ),

        // Phone
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_4X),
          child: phoneInput(),
        ),

        SizedBox(
          height: IZIDimensions.ONE_UNIT_SIZE * 30,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_4X),
          child: passwordInput(),
        ),

        SizedBox(
          height: IZIDimensions.SPACE_SIZE_4X,
        ),

//button
        loginButton(),

        SizedBox(
          height: IZIDimensions.SPACE_SIZE_4X,
        ),

// hoặc đăng nhập với
        orlogin(),
// button mạng xã hội
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X * 1.5),
          child: socialNetworkButton(),
        ),

        if (Platform.isIOS)
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_4X * 1.5),
            child: IZIButton(
              padding: EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_2X,
                horizontal: IZIDimensions.SPACE_SIZE_2X,
              ),
              type: IZIButtonType.OUTLINE,
              imageUrlIcon: ImagesPath.apple,
              label: "Đăng nhập bằng Apple",
              colorText: ColorResources.BLACK,
              colorBG: ColorResources.WHITE,
              onTap: () {
                print("apple....");
                controller.handleSignInApple();
              },
            ),
          )
        else
          const SizedBox(),

        if (IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getProfile))
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_4X * 1.5),
            child: IZIButton(
              padding: EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_2X,
                horizontal: IZIDimensions.SPACE_SIZE_2X,
              ),
              onTap: () {
                // Get.toNamed(SplashRoutes.HOME);
                controller.gotoHomScreen();
              },
              label: "Màn hình Home",
              borderRadius: 10,
              colorBG: ColorResources.ORANGE,
            ),
          )
        else
          const SizedBox(),

        forgetPassword(),

        SizedBox(
          height: IZIDimensions.ONE_UNIT_SIZE * 20,
        ),

        registerAccount(),
      ],
    );
  }

  Row socialNetworkButton() {
    return Row(
      children: [
        Expanded(
          child: IZIButton(
            onTap: () {
              controller.handleSignIn();
            },
            imageUrlIcon: ImagesPath.google,
            label: "Google",
            borderRadius: 10,
            space: 20,
            colorText: ColorResources.BLACK,
            colorBG: ColorResources.WHITE,
          ),
        ),
        SizedBox(
          width: IZIDimensions.SPACE_SIZE_2X,
        ),
        Expanded(
            child: IZIButton(
          onTap: () async {
            // IZIOther.openLink(url: "https://www.facebook.com/login.php");
            controller.signInWithFacebook();
          },
          imageUrlIcon: ImagesPath.facebook,
          label: "Facebook",
          borderRadius: 10,
          space: 20,
          colorText: ColorResources.BLACK,
          colorBG: ColorResources.WHITE,
        ))
      ],
    );
  }

//hoặc đăng nhập với
  Row orlogin() {
    return Row(
      children: [
        Expanded(
          child: Container(
              margin: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_4X,
                  right: IZIDimensions.SPACE_SIZE_4X),
              child: Divider(
                color: ColorResources.NEUTRALS_5,
                height: IZIDimensions.ONE_UNIT_SIZE * 50,
              )),
        ),
        Text(
          "Hoặc đăng nhập với",
          style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
              color: ColorResources.NEUTRALS_5,
              fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Container(
              margin: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_4X,
                  right: IZIDimensions.SPACE_SIZE_4X),
              child: Divider(
                color: ColorResources.NEUTRALS_5,
                height: IZIDimensions.ONE_UNIT_SIZE * 50,
              )),
        ),
      ],
    );
  }

  ///
  /// phone input
  ///
  Widget phoneInput() {
    return IZIInput(
      controller: controller.phone.isNotEmpty
          ? TextEditingController(text: controller.phone)
          : null,
      type: IZIInputType.PHONE,
      placeHolder: 'Nhập số điện thoại',
      initValue: controller.phone,
      fillColor: ColorResources.WHITE,
      borderRadius: 10,
      // disbleError: true,
      onChanged: (val) {
        controller.phone = val;
      },
      prefixIcon: (val) {
        return Container(
          margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: ColorResources.ORANGE4),
            ),
          ),
          child: Icon(
            Icons.phone,
            // color: ColorResources.ORANGE,
            color: IZIValidate.nullOrEmpty(controller.phone)
                ? ColorResources.NEUTRALS_4
                : ColorResources.ORANGE,
          ),
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  ///
  /// password input
  ///
  Widget passwordInput() {
    return IZIInput(
      controller: controller.password.isNotEmpty
          ? TextEditingController(text: controller.password)
          : null,
      type: IZIInputType.PASSWORD,
      placeHolder: 'Mật khẩu',
      // disbleError: true,
      initValue: controller.password,
      prefixIcon: (val) {
        return Container(
          margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: ColorResources.ORANGE4),
            ),
          ),
          child: Icon(
            Icons.lock,
            color: IZIValidate.nullOrEmpty(controller.password)
                ? ColorResources.NEUTRALS_4
                : ColorResources.ORANGE,
          ),
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      fillColor: ColorResources.WHITE,
      borderRadius: 10,
      onChanged: (val) {
        controller.password = val;
      },
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  ///
  /// forget password
  ///
  Widget forgetPassword() {
    return Padding(
      padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X * 1.2),
      child: Center(
        child: GestureDetector(
          onTap: () {
            controller.onForgetPassword();
          },
          child: Text(
            "Quên mật khẩu?",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.RED_COLOR_2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// register account
  ///
  Widget registerAccount() {
    return Padding(
      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_3X),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            "Bạn chưa có tài khoản? ",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.NEUTRALS_5,
              fontWeight: FontWeight.w400,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.onRegister();
            },
            child: Text(
              "Đăng ký",
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                color: ColorResources.RED_COLOR_2,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// login button
  ///
  Widget loginButton() {
    return IZIButton(
      margin: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_4X,
          right: IZIDimensions.SPACE_SIZE_4X,
          top: IZIDimensions.SPACE_SIZE_3X),
      onTap: () {
        // Get.toNamed(SplashRoutes.HOME);
        controller.onLogin();
      },
      label: "Đăng nhập",
      borderRadius: 10,
      colorBG: ColorResources.ORANGE,
    );
  }
}
