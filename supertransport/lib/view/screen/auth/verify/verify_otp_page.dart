import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/background/background_auth.dart';
import '../../../../base_widget/izi_button.dart';
import 'verify_otp_controller.dart';

class VerifyOtpPage extends GetView<VerifyOtpController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      // safeAreaTop: false,
      // safeAreaBottom: false,
      isSingleChildScrollView: false,
      background: const BackgroundAuth(),
      body: GetBuilder(
        builder: (VerifyOtpController controller) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: IZIDimensions.ONE_UNIT_SIZE * 40,
            ),
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
            ),
          );
        },
      ),
    );
  }

  ///
  /// _verifier OTP Widget
  ///
  Widget _verifierOTPWidget(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Xác thực tài khoản",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorResources.PRIMARY_1,
              fontSize: IZIDimensions.FONT_SIZE_H4,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            child: Text(
              "Mã xác thực sẽ được gửi đến số điện thoại của bạn",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorResources.NEUTRALS_4,
                fontSize:IZIDimensions.FONT_SIZE_H6,
              ),
            ),
          ),
        ],
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
            inactiveFillColor: ColorResources.PRIMARY_1,
            inactiveColor: ColorResources.PRIMARY_1,
          ),
          cursorColor: ColorResources.WHITE,
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          errorAnimationController: controller.errorController,
          controller: controller.textEditingController,
          keyboardType: TextInputType.number,
          
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
