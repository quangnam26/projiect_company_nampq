import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/otp_page_router.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/otp/phone/phone_controller.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../utils/images_path.dart';

class OTPPhonePage extends GetView<OTPPhoneController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
     
      background: Container(
        height: IZIDimensions.iziSize.height,
        width: IZIDimensions.iziSize.width,
        color: ColorResources.NEUTRALS_7,
      ),
      body: GetBuilder(
        builder: (OTPPhoneController controller) {
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
                      "XÁC THỰC OTP",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ColorResources.BLACK,
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
                    Container(
                      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
                      height: IZIDimensions.ONE_UNIT_SIZE * 280,
                      width: IZIDimensions.ONE_UNIT_SIZE * 280,
                      child: IZIImage(
                        ImagesPath.forgetpassword,
                      ),
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
        // controller.onBack();
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
        
          IZIInput(
            type: IZIInputType.TEXT,
            autofocus: true,
            fillColor: const Color(0xfff0f6f7),
          
            onTap: () {},
            onChanged: (v) {},
          ),
          
          verifyOtpButton(),
        ],
      ),
    );
  }

  ///
  /// _verifier OTP Widget
  ///
  Widget _verifierOTPWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
      child: Text(
        "Nhập số điện thoại để xác thực mã OTP",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorResources.NEUTRALS_4,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .8,
        ),
      ),
    );
  }

  Widget verifyOtpButton() {
    return IZIButton(
      onTap: () {
        Get.toNamed(OTPPageRoutes.OTP);
      },
      label: "Gửi mã",
      borderRadius: 10,
    );
  }
}
