import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/auth/register/register_controller.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_validate.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      safeAreaTop: false,
      safeAreaBottom: false,
      background: Container(height: IZIDimensions.iziSize.height, width: IZIDimensions.iziSize.width, color: ColorResources.NEUTRALS_7),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          builder: (RegisterController controller) {
            return IZILoaderOverLay(
              body: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
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
                          height: IZIDimensions.SPACE_SIZE_4X * 2,
                        ),
                        // signupSocial(),
                        SizedBox(height: IZIDimensions.ONE_UNIT_SIZE * 100),
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_4X * 2,
                        ),
                      ],
                    ),
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
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 250,
            width: IZIDimensions.ONE_UNIT_SIZE * 250,
            child: IZIImage(
              ImagesPath.signup,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Text(
            "TẠO TÀI KHOẢN",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H3,
              color: ColorResources.NEUTRALS_2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  color: ColorResources.NEUTRALS_4,
                  height: 1,
                  width: IZIDimensions.iziSize.width,
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Expanded(
                child: Text(
                  "Hoặc đăng ký với",
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    color: ColorResources.NEUTRALS_4,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_1X,
              ),
              Expanded(
                child: Container(
                  color: ColorResources.NEUTRALS_4,
                  height: 1,
                  width: IZIDimensions.iziSize.width,
                ),
              ),
            ],
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Row(
            children: [
              Expanded(
                child: IZIButton(
                  onTap: () {
                    // controller.onLogin();
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
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X * 2,
          ),
          loginAccount(),
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
        top: IZIDimensions.SPACE_SIZE_4X * 2,
      ),
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          // Phone
          phoneInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          passwordInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          confirmPassword(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X * 2,
          ),
          signupButton(),
        ],
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
      borderRadius: 5,
      onChanged: (val) {
        controller.phone = val;
      },
      isValidate: (validate) {
        controller.isValidates[0] = validate;
      },
      prefixIcon: (val) {
        return Icon(
          Icons.phone,
          color: IZIValidate.nullOrEmpty(val)
              ? ColorResources.NEUTRALS_4
              : val!.hasFocus
                  ? ColorResources.PRIMARY_3
                  : ColorResources.NEUTRALS_4,
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
      type: IZIInputType.PASSWORD,
      placeHolder: 'Mật khẩu',
      initValue: controller.password,
      isValidate: (validate) {
        controller.isValidates[1] = validate;
      },
      prefixIcon: (val) {
        return Icon(
          Icons.lock,
          color: IZIValidate.nullOrEmpty(val)
              ? ColorResources.NEUTRALS_4
              : val!.hasFocus
                  ? ColorResources.PRIMARY_3
                  : ColorResources.NEUTRALS_4,
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
      initValue: controller.repeatPassword,
      isValidate: (validate) {
        controller.isValidates[2] = validate;
      },
      prefixIcon: (val) {
        return Icon(
          Icons.lock,
          color: IZIValidate.nullOrEmpty(val)
              ? ColorResources.NEUTRALS_4
              : val!.hasFocus
                  ? ColorResources.PRIMARY_3
                  : ColorResources.NEUTRALS_4,
        );
      },
      validate: (val) {
        if (val == controller.password) {
          return null;
        }
        return 'Mật khẩu không trùng khớp';
      },
      cursorColor: ColorResources.NEUTRALS_5,
      fillColor: ColorResources.WHITE,
      borderRadius: 5,
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
          "Tôi đã có tài khoản? ",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6,
            color: ColorResources.NEUTRALS_2,
            fontWeight: FontWeight.w300,
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.onToLogin();
          },
          child: Text(
            "Đăng nhập",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.NEUTRALS_2,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
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
      label: "Tạo tài khoản",
      borderRadius: 10,
    );
  }
}
