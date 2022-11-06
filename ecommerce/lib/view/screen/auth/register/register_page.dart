import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/auth/register/register_controller.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_validate.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: IZIScreen(
        // isSingleChildScrollView: false,
        background: Container(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            color: ColorResources.NEUTRALS_6),
        body: GetBuilder(
          builder: (RegisterController controller) {
            return SizedBox(
              // height: IZIDimensions.iziSize.height,
              // width: IZIDimensions.iziSize.width,
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    header(),

                    // Form
                    form(
                      context,
                    ),
                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    //
                    signupSocial(),
                  ],
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
      // color: Colors.red,
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
            "Đăng ký tài khoản",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: IZIDimensions.FONT_SIZE_H5 * 0.9,
              color: ColorResources.PRIMARY_9,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Text(
            "Tạo tài khoản mới",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
              color: ColorResources.NEUTRALS_4,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  ///Form
  Widget form(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),

          // inputname
          nameInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),

          //input Phone
          phoneInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          passwordInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_3X,
          ),
          confirmPassword(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          signupButton(),
        ],
      ),
    );
  }

  ///
  /// name input
  ///
  Widget nameInput() {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: 'Nhập vào tên',
      initValue: controller.name,
      fillColor: ColorResources.WHITE,
      borderRadius: 10,
      onChanged: (val) {
        controller.name = val;
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
            Icons.lock_outline,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_5
                : val!.hasFocus
                    ? ColorResources.PRIMARY_3
                    : ColorResources.NEUTRALS_5,
          ),
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  ///
  /// phone input
  ///
  Widget phoneInput() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: 'Nhập số điện thoại',
      initValue: controller.phone,
      fillColor: ColorResources.WHITE,
      borderRadius: 10,
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
            Icons.phone_outlined,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_5
                : val!.hasFocus
                    ? ColorResources.PRIMARY_3
                    : ColorResources.NEUTRALS_5,
          ),
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  ///
  /// password input
  ///
  Widget passwordInput() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      placeHolder: 'Mật khẩu',
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
            Icons.lock_outline,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_5
                : val!.hasFocus
                    ? ColorResources.PRIMARY_3
                    : ColorResources.NEUTRALS_5,
          ),
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      fillColor: ColorResources.WHITE,
      borderRadius: 5,
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
  /// password input
  ///
  Widget confirmPassword() {
    return IZIInput(
      type: IZIInputType.PASSWORD,
      placeHolder: 'Xác nhận mật khẩu',
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
            Icons.lock_outline,
            color: IZIValidate.nullOrEmpty(val)
                ? ColorResources.NEUTRALS_5
                : val!.hasFocus
                    ? ColorResources.PRIMARY_3
                    : ColorResources.NEUTRALS_5,
          ),
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      fillColor: ColorResources.WHITE,
      borderRadius: 5,
      onChanged: (val) {
        controller.repeatPassword = val;
      },
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  ///
  /// register account
  ///
  Widget loginAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Đã có tài khoản? ",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
            color: ColorResources.NEUTRALS_4,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(SplashRoutes.LOGIN);
            // controller.onToLogin();
          },
          child: Text(
            "Đăng nhập",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.RED_COLOR_2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  ///
  ///  Đăng nhập với mạng xã hội
  ///
  Widget signupSocial() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          Row(
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
                "Hoặc đăng ký với",
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
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          Row(
            children: [
              Expanded(
                child: IZIButton(
                  onTap: () async {
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
                width: IZIDimensions.SPACE_SIZE_4X,
              ),
              Expanded(
                child: IZIButton(
                  onTap: () {
                    // controller.onLogin();
                  },
                  imageUrlIcon: ImagesPath.facebook,
                  label: "Facebook",
                  borderRadius: 10,
                  space: 20,
                  colorText: ColorResources.BLACK,
                  colorBG: ColorResources.WHITE,
                ),
              ),
            ],
          ),
          if (Platform.isIOS)
            IZIButton(
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
                controller.handleSignInApple();
              },
            )
          else
            const SizedBox(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          loginAccount(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          )
        ],
      ),
    );
  }

  ///
  /// login button
  ///
  Widget signupButton() {
    return IZIButton(
      onTap: () {
        controller.signUp();
      },
      label: "Đăng ký",
      borderRadius: 10,
      colorBG: ColorResources.ORANGE,
    );
  }
}
