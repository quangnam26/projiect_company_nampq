import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../utils/images_path.dart';
import 'verify_otp_controller.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      // safeAreaTop: false,
      // safeAreaBottom: false,
      isSingleChildScrollView: false,
      background: Container(
        height: IZIDimensions.iziSize.height,
        width: IZIDimensions.iziSize.width,
        color: ColorResources.NEUTRALS_7,
      ),
      body: GetBuilder(
        builder: (VerifyOtpController controller) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Stack(
              children: [
                backButton(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: IZIDimensions.iziSize.height * 0.12,
                      ),
                    ),
                    Text(
                      "Xác thực tài khoản",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorResources.PRIMARY_1,
                        fontSize: IZIDimensions.FONT_SIZE_H3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(
                      height: IZIDimensions.SPACE_SIZE_4X,
                    ),

                    ///
                    /// Form verify OTP
                    ///
                    verifyForm(
                      context,
                    ),

                    ///
                    /// other ui
                    ///
                    otherUI(),

                    Expanded(
                      child: resend(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// back button
  ///
  Widget backButton() {
    return GestureDetector(
      onTap: () {
        controller.onBack();
      },
      child: Container(
        padding: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_1X,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: ColorResources.GREY.withOpacity(0.4),
        ),
        width: IZIDimensions.ONE_UNIT_SIZE * 50,
        height: IZIDimensions.ONE_UNIT_SIZE * 50,
        child: const Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
    );
  }

  ///
  /// Verify form
  ///
  Widget verifyForm(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 20,
        ),
        color: ColorResources.WHITE,
      ),
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        children: [
          _verifierOTPWidget(context),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 50,
          ),
          otpEnterWidget(context),
          SizedBox(
            height: IZIDimensions.ONE_UNIT_SIZE * 50,
          ),
          verifyOtpButton(),
        ],
      ),
    );
  }

  ///
  /// other ui
  ///
  Widget otherUI() {
    return Column(
      children: [
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_2X,
        ),
        Text(
          "Thời gian còn lại: 0:38s",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorResources.NEUTRALS_4,
            fontSize: IZIDimensions.FONT_SIZE_H6,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_2X,
        ),
        SizedBox(
          height: IZIDimensions.ONE_UNIT_SIZE * 280,
          width: IZIDimensions.ONE_UNIT_SIZE * 280,
          child: IZIImage(
            ImagesPath.forgetpassword,
          ),
        ),
        SizedBox(
          height: IZIDimensions.SPACE_SIZE_2X,
        ),
      ],
    );
  }

  ///
  /// resend
  ///
  Widget resend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Bạn chưa nhận được mã? ",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            // resend
          },
          child: Text(
            "Gửi lại",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  ///
  /// _verifier OTP Widget
  ///
  Widget _verifierOTPWidget(BuildContext context) {
    return SizedBox(
      child: Text(
        "Nhập mã OTP đã được gửi về qua số điện thoại của bạn",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorResources.NEUTRALS_4,
          fontSize: IZIDimensions.FONT_SIZE_H6,
        ),
      ),
    );
  }

  ///
  /// _usernameEnterWidget
  ///
  Widget otpEnterWidget(BuildContext context) {
    return SizedBox(
      height: IZIDimensions.ONE_UNIT_SIZE * 100,
      child: Form(
        key: controller.formKey,
        child: PinCodeTextField(
          validator: (val) {
            if (val!.length < 4) {
              return "";
            } else {
              return null;
            }
          },
          appContext: context,
          pastedTextStyle: TextStyle(
            color: Colors.green.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 4,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: IZIDimensions.ONE_UNIT_SIZE * 100,
            fieldWidth: IZIDimensions.ONE_UNIT_SIZE * 100,
            activeFillColor: Colors.white,
            disabledColor: ColorResources.PRIMARY_1,
            inactiveFillColor: ColorResources.WHITE,
            inactiveColor: ColorResources.PRIMARY_1,
            activeColor: ColorResources.WHITE,
            selectedFillColor: ColorResources.WHITE,
            selectedColor: ColorResources.PRIMARY_1,
          ),
          cursorColor: ColorResources.WHITE,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: controller.errorController,
          controller: controller.textEditingController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          // ignore: prefer_const_literals_to_create_immutables
          boxShadows: [
            const BoxShadow(
              offset: Offset(0, 1),
              color: Colors.black12,
              blurRadius: 10,
            )
          ],
          onCompleted: (v) {
            // print("Completed $v");
            // controller.onBtnCompleteTap();
          },
          onChanged: (value) {},
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }

  Widget verifyOtpButton() {
    return IZIButton(
      onTap: () {
        controller.onVerifyOtp();
      },
      label: "Xác nhận",
      borderRadius: 10,
    );
  }
}
