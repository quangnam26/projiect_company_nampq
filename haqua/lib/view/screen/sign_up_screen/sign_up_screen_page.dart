import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/sign_up_screen/sign_up_screen_controller.dart';

import '../../../base_widget/izi_image.dart';

class SignUpPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SignUpController(),
      builder: (SignUpController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: Container(
              width: IZIDimensions.iziSize.width,
              color: ColorResources.BACKGROUND,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                          vertical: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: IZIDimensions.ONE_UNIT_SIZE * 40,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
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

                            /// Import phone number.
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: _importPhoneNumber(controller),
                            ),

                            /// Import name.
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: _importName(controller),
                            ),

                            /// Import password.
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              child: _importPassword(controller),
                            ),

                            /// Import confirm password.
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_5X,
                              ),
                              child: _importConfirmPassword(controller),
                            ),

                            /// Sign up button.
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: IZIDimensions.SPACE_SIZE_5X,
                              ),
                              child: _signUpButton(controller),
                            ),
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
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        child: SizedBox(
                          width: IZIDimensions.iziSize.width,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /// Google button login.
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

                              /// Button login app by HaQua when platform device is Android.
                              Obx(() {
                                if (!controller.isIOS.value) _buttonLoginHaQuaWhenPlatformIsAndroid(controller);
                                return const SizedBox();
                              }),

                              /// Button login app with HaQua or Apple when platform device is IOS.
                              Obx(() {
                                if (controller.isIOS.value) _buttonLoginByHaQuaOrApple(controller);
                                return const SizedBox();
                              }),

                              /// Login HaQua by text bottom.
                              _loginHaQuaText(controller),
                            ],
                          ),
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
    );
  }

  ///
  /// Import phone number.
  ///
  Widget _importPhoneNumber(SignUpController controller) {
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
  /// Import name.
  ///
  Widget _importName(SignUpController controller) {
    return Obx(
      () => IZIInput(
        prefixIcon: const Icon(
          Icons.person,
          color: ColorResources.PRIMARY_APP,
        ),
        placeHolder: "name".tr,
        type: IZIInputType.TEXT,
        isBorder: true,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        onChanged: (val) {
          controller.onChangedValueName(val);
        },
        errorText: controller.errorTextName.value,
        validate: (val) {
          controller.onValidateName(val);
          return null;
        },
      ),
    );
  }

  ///
  /// Import password.
  ///
  Widget _importPassword(SignUpController controller) {
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
  /// Import confirm password.
  ///
  Widget _importConfirmPassword(SignUpController controller) {
    return Obx(
      () => IZIInput(
        prefixIcon: const Icon(
          Icons.lock,
          color: ColorResources.PRIMARY_APP,
        ),
        placeHolder: "confirm_password".tr,
        type: IZIInputType.PASSWORD,
        isBorder: true,
        colorBorder: ColorResources.PRIMARY_APP,
        disbleError: true,
        onChanged: (val) {
          controller.onChangedConfirmPassword(val);
        },
        errorText: controller.errorTextConfirmPassword.value,
        validate: (val) {
          controller.onValidateConfirmPassword(val);
          return null;
        },
      ),
    );
  }

  ///
  /// Sign up button.
  ///
  Widget _signUpButton(SignUpController controller) {
    return Obx(
      () => IZIButton(
        isEnabled: controller.genValueEnableButton(),
        label: "sign_up".tr,
        onTap: () {
          controller.goToOTPScreen();
        },
      ),
    );
  }

  ///
  /// Google button login.
  ///
  Widget _googleLoginButton(SignUpController controller) {
    return Obx(
      () => IZIButton(
        isEnabled: controller.isEnabledButton.value,
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
      ),
    );
  }

  ///
  /// Facebook login button.
  ///
  Widget _facebookLoginButton(SignUpController controller) {
    return IZIButton(
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
  /// Button login app by HaQua when platform device is Android.
  ///
  Widget _buttonLoginHaQuaWhenPlatformIsAndroid(SignUpController controller) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: IZIButton(
        width: IZIDimensions.iziSize.width / 2 - IZIDimensions.SPACE_SIZE_2X,
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_2X,
          horizontal: IZIDimensions.SPACE_SIZE_2X,
        ),
        type: IZIButtonType.OUTLINE,
        imageUrlIcon: ImagesPath.logo_haqua,
        label: "sign_in_with_haqua".tr,
        colorText: ColorResources.BLACK,
        onTap: () {
          controller.loginHaQua();
        },
      ),
    );
  }

  ///
  /// Button login app with HaQua or Apple when platform device is IOS.
  ///
  Widget _buttonLoginByHaQuaOrApple(SignUpController controller) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: IZIButton(
              padding: EdgeInsets.symmetric(
                vertical: IZIDimensions.SPACE_SIZE_2X,
                horizontal: IZIDimensions.SPACE_SIZE_2X,
              ),
              type: IZIButtonType.OUTLINE,
              imageUrlIcon: ImagesPath.logo_haqua,
              label: "sign_in_with_haqua".tr,
              colorText: ColorResources.BLACK,
              onTap: () {
                controller.loginHaQua();
              },
            ),
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_2X,
          ),
          Expanded(
            child: IZIButton(
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
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Login HaQua by text bottom.
  ///
  Widget _loginHaQuaText(SignUpController controller) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "have_account".tr,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    color: ColorResources.BLACK,
                  ),
                ),
                WidgetSpan(
                  child: GestureDetector(
                    onTap: () {
                      controller.loginHaQua();
                    },
                    child: Text(
                      "sign_in".tr,
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
    );
  }
}
