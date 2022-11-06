import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/auth/forget_password/forget_password_controller.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../utils/images_path.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
          height: IZIDimensions.iziSize.height -
              MediaQuery.of(context).viewPadding.vertical,
          width: IZIDimensions.iziSize.width,
          color: ColorResources.NEUTRALS_6),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: GetBuilder(
          builder: (ForgetPasswordController controller) {
            return SizedBox(
              width: IZIDimensions.iziSize.width,
              child: SingleChildScrollView(
                child: Container(
                  // color: ColorResources.RED,
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.ONE_UNIT_SIZE * 40,
                  ),
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.iziSize.height -
                      MediaQuery.of(context).viewPadding.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_4X,
                      ),

                      // button
                      backButton(),

                      SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 120,
                      ),

                      Expanded(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(
                                height: IZIDimensions.ONE_UNIT_SIZE * 250,
                                width: IZIDimensions.ONE_UNIT_SIZE * 250,
                                child: IZIImage(
                                  ImagesPath.updatepassword,
                                ),
                              ),

                              SizedBox(
                                height: IZIDimensions.ONE_UNIT_SIZE * 30,
                              ),

                              Text(
                                "QUÊN MẬT KHẨU?",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              SizedBox(
                                height: IZIDimensions.ONE_UNIT_SIZE * 30,
                              ),

                              /// FORM
                              fogetpasswordForm(),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: iRememberPassword(),
                        ),
                      )
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

  Widget iRememberPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Nhớ mật khẩu? ",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6,
              fontWeight: FontWeight.w400,
              color: ColorResources.NEUTRALS_5),
        ),
        GestureDetector(
          onTap: () {
            Get.toNamed(SplashRoutes.LOGIN);
            // controller.onGoToLogin();
          },
          child: Text(
            "Đăng nhập",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                fontWeight: FontWeight.w500,
                color: ColorResources.RED_COLOR_2),
          ),
        ),
      ],
    );
  }

  ///
  /// FORM FORGE PASSWORD
  ///
  Widget fogetpasswordForm() {
    return Container(
      padding: EdgeInsets.all(
        IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 20,
        ),
        color: ColorResources.WHITE,
      ),
      child: Column(
        children: [
          Text(
            "Nhập số điên thoại đã đăng ký của bạn vào bên dưới để nhận hướng dẫn đặt lại mật khẩu",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                fontWeight: FontWeight.w300,
                color: ColorResources.NEUTRALS_5),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          // button iphone input
          phoneInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          nextButton()
        ],
      ),
    );
  }

  ///
  ///  PHONE INPUT
  ///
  Widget phoneInput() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: 'Nhập số điện thoại',
      initValue: controller.phone,
      fillColor: ColorResources.YELLOW2,
      borderRadius: 5,
      // disbleError: true,
      onChanged: (val) {
        controller.phone = val;
      },
      prefixIcon: (val) {
        return Icon(
          Icons.phone_outlined,
          color: IZIValidate.nullOrEmpty(val)
              ? ColorResources.NEUTRALS_4
              : val!.hasFocus
                  ? ColorResources.PRIMARY_3
                  : ColorResources.NEUTRALS_4,
        );
      },
      cursorColor: ColorResources.NEUTRALS_5,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  Widget nextButton() {
    return IZIButton(
      onTap: () {
        controller.updatePassword();
      },
      label: "Tiếp tục",
      borderRadius: 10,
      colorBG: ColorResources.ORANGE,
    );
  }
}
