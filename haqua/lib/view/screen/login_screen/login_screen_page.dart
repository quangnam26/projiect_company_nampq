import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/login_screen/login_screen_controller.dart';
import '../../../base_widget/izi_button.dart';

class LoginPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: LoginController(),
        builder: (LoginController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
              backgroundColor: ColorResources.BACKGROUND,
              body: Container(
                width: IZIDimensions.iziSize.width,
                color: ColorResources.BACKGROUND,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_1X,
                            bottom: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_5X,
                                ),
                                child: IZIImage(
                                  ImagesPath.splash_haqua,
                                  width: IZIDimensions.iziSize.width * .35,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_5X,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Welcome_to_Haqua_sign_in".tr,
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H5,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.TITLE_LOGIN,
                                  ),
                                ),
                                Text(
                                  " HAQUA",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.mali(
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.PRIMARY_APP,
                                    fontSize: IZIDimensions.FONT_SIZE_H2,
                                  ),
                                ),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_5X,
                            vertical: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          child: Text(
                            "title_create_account".tr,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.PRIMARY_APP,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        //Button
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                          child: Column(
                            children: [
                              /// Import phone number.
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_5X,
                                ),
                                child: _importPhoneNumber(controller),
                              ),

                              /// Import password.
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_5X,
                                ),
                                child: _importPassword(controller),
                              ),

                              /// HaQua login button.
                              _haQuaLoginButton(controller),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          width: IZIDimensions.iziSize.width,
                          child: Row(
                            children: [
                              Container(
                                width: IZIDimensions.iziSize.width * .3,
                                height: IZIDimensions.ONE_UNIT_SIZE * 2,
                                decoration: BoxDecoration(
                                  color: ColorResources.BLACK.withOpacity(.6),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "or_sign_in_with".tr,
                                      style: TextStyle(
                                        color: ColorResources.BLACK.withOpacity(.6),
                                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: IZIDimensions.iziSize.width * .3,
                                height: IZIDimensions.ONE_UNIT_SIZE * 2,
                                decoration: BoxDecoration(
                                  color: ColorResources.BLACK.withOpacity(.6),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_5X * 3,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        /// Google Login Button.
                                        Expanded(
                                          child: _googleLoginButton(controller),
                                        ),
                                        SizedBox(
                                          width: IZIDimensions.SPACE_SIZE_2X,
                                        ),

                                        /// Facebook login button.
                                        Expanded(
                                          child: _facebookLoginButton(controller),
                                        ),
                                      ],
                                    ),

                                    ///  IOS login button.
                                    Obx(() {
                                      if (controller.isIOS.value) _iosLoginButton(controller);
                                      return const SizedBox();
                                    })
                                  ],
                                ),
                              ),

                              /// Forgot Password and Sign up widget.
                              _forgotPasswordAndSignUp(controller),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  ///
  /// Import phone number.
  ///
  Widget _importPhoneNumber(LoginController controller) {
    return Obx(
      () => IZIInput(
        prefixIcon: const Icon(
          Icons.call,
          color: ColorResources.PRIMARY_APP,
        ),
        placeHolder: "phone_number".tr,
        type: IZIInputType.PHONE,
        isBorder: true,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        onChanged: (val) {
          controller.onChangedValuePhoneNumber(val);
        },
        errorText: controller.errorTextPhoneNumber.value,
        validate: (val) {
          controller.onValidatePhoneNumber(val);
          return null;
        },
      ),
    );
  }

  ///
  /// Import password.
  ///
  Widget _importPassword(LoginController controller) {
    return Obx(
      () => IZIInput(
        prefixIcon: const Icon(
          Icons.lock,
          color: ColorResources.PRIMARY_APP,
        ),
        placeHolder: "password".tr,
        type: IZIInputType.PASSWORD,
        isBorder: true,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        onChanged: (val) {
          controller.onChangedPassword(val);
        },
        errorText: controller.errorTextPassword.value,
        validate: (val) {
          controller.onValidatePassword(val);
          return null;
        },
      ),
    );
  }

  ///
  /// HaQua login button.
  ///
  Widget _haQuaLoginButton(LoginController controller) {
    return Obx(
      () => IZIButton(
        margin: EdgeInsets.only(
          bottom: IZIDimensions.SPACE_SIZE_5X,
        ),
        isEnabled: controller.genValueEnableButton(),
        label: "sign_in".tr,
        onTap: () async {
          controller.loginSocial(typeRegister: 1);
        },
      ),
    );
  }

  ///
  /// Google Login Button.
  ///
  Widget _googleLoginButton(LoginController controller) {
    return IZIButton(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      type: IZIButtonType.OUTLINE,
      imageUrlIcon: ImagesPath.google_icon,
      label: "sign_in_with_google".tr,
      colorText: ColorResources.BLACK,
      onTap: () async {
        controller.signInGoogle();
      },
    );
  }

  ///
  /// Facebook login button.
  ///
  Widget _facebookLoginButton(LoginController controller) {
    return IZIButton(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      type: IZIButtonType.OUTLINE,
      imageUrlIcon: ImagesPath.facebook_icon,
      label: "sign_in_with_facebook".tr,
      colorText: ColorResources.BLACK,
      onTap: () async {
        controller.signInWithFacebook();
      },
    );
  }

  ///
  /// IOS login button.
  ///
  Widget _iosLoginButton(LoginController controller) {
    return IZIButton(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_5X * 3,
      ),
      padding: EdgeInsets.symmetric(
        vertical: IZIDimensions.SPACE_SIZE_2X,
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      type: IZIButtonType.OUTLINE,
      imageUrlIcon: ImagesPath.apple_icon,
      label: "sign_in_with_apple".tr,
      colorText: ColorResources.BLACK,
      onTap: () async {
        controller.signInWithApple();
      },
    );
  }

  ///
  /// Forgot Password and Sign up widget.
  ///
  Widget _forgotPasswordAndSignUp(LoginController controller) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: GestureDetector(
            onTap: () {
              controller.goToForgotPassword();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "forgot_pass".tr,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H5 * .8,
                    color: ColorResources.PRIMARY_APP,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "create_a_new_account".tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                    ),
                  ),
                  WidgetSpan(
                    child: GestureDetector(
                      onTap: () {
                        controller.goToSignUpPage();
                      },
                      child: Text(
                        "sign_up".tr,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H5 * .8,
                          color: ColorResources.PRIMARY_APP,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
