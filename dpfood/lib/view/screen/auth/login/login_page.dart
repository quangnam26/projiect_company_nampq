import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../base_widget/izi_loader_overlay.dart';
import '../../../../helper/izi_validate.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      safeAreaTop: false,
      safeAreaBottom: false,
      background: Container(
        height: IZIDimensions.iziSize.height,
        width: IZIDimensions.iziSize.width,
        color: ColorResources.NEUTRALS_7,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          builder: (LoginController controller) {
            return IZILoaderOverLay(
              loadingWidget: spinKitWanderingCubes,
              overlayColor: LoaderOverlay.defaultOverlayColor,
              body: SizedBox(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width,
                child: Center(
                  child: Stack(
                    children: [
                      Positioned(
                        top: IZIDimensions.ONE_UNIT_SIZE * 80,
                        right: IZIDimensions.ONE_UNIT_SIZE * 30,
                        child: Icon(
                          Icons.help,
                          size: IZIDimensions.ONE_UNIT_SIZE * 80,
                          color: ColorResources.NEUTRALS_5,
                        ),
                      ),
                      SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_4X,
                            ),
                            header(),

                            // loginSocial(),
                            SizedBox(height: IZIDimensions.ONE_UNIT_SIZE * 100),
                            // Form
                            form(
                              context,
                            ),
                          ],
                        ),
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
            height: IZIDimensions.ONE_UNIT_SIZE * 150,
          ),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 200,
            width: IZIDimensions.ONE_UNIT_SIZE * 200,
            child: IZIImage(
              ImagesPath.login,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Text(
            "ĐĂNG NHẬP",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H3,
              color: ColorResources.NEUTRALS_2,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Text(
            "Chào mừng bạn đến với D&P Food",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.PRIMARY_2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  ///
  ///  Đăng nhập với mạng xã hội
  ///
  Widget loginSocial() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          IZIButton(
            onTap: () {
              controller.onLogin(ACCOUNT.GOOGLE);
            },
            imageUrlIcon: ImagesPath.google,
            label: "Đăng nhập bằng google",
            borderRadius: 10,
            space: 20,
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_1X,
            ),
            colorText: ColorResources.BLACK,
            colorBG: ColorResources.WHITE,
          ),
          IZIButton(
            onTap: () {
              controller.onLogin(ACCOUNT.FACEBOOK);
            },
            margin: EdgeInsets.zero,
            imageUrlIcon: ImagesPath.facebook,
            label: "Đăng nhập bằng facebook",
            borderRadius: 10,
            space: 20,
            colorText: ColorResources.BLACK,
            colorBG: ColorResources.WHITE,
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
        top: IZIDimensions.ONE_UNIT_SIZE * 80,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            IZIDimensions.ONE_UNIT_SIZE * 30,
          ),
          topRight: Radius.circular(
            IZIDimensions.ONE_UNIT_SIZE * 30,
          ),
        ),
        color: ColorResources.WHITE,
      ),
      child: Column(
        children: [
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),

          Text(
            'Đăng nhập bằng số điện thoại',
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.PRIMARY_2,
              fontWeight: FontWeight.w400,
            ),
          ),

          const Divider(
            color: ColorResources.PRIMARY_3,
          ),

          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),

          // Phone
          phoneInput(),

          SizedBox(
            height: IZIDimensions.SPACE_SIZE_1X,
          ),
          passwordInput(),

          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),

          loginButton(context),

          forgetPassword(),

          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 20,
          ),

          registerAccount(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
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
      fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
      borderRadius: 5,
      disbleError: true,
      onChanged: (val) {
        controller.phone = val;
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
      disbleError: true,
      initValue: controller.password,
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
      fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
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
  /// forget password
  ///
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
            "Quên mật khẩu?",
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              color: ColorResources.NEUTRALS_4,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// register account
  ///
  Widget registerAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "Bạn chưa có tài khoản? ",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6,
            color: ColorResources.NEUTRALS_2,
            fontWeight: FontWeight.w300,
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
  Widget loginButton(BuildContext context) {
    return IZIButton(
      onTap: () {
        onShowLoaderOverlay();
        controller.onLogin(
          ACCOUNT.DPFOOD,
        );
      },
      label: "Đăng nhập",
      borderRadius: 10,
    );
  }
}
