import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../utils/images_path.dart';
import 'update_password_controller.dart';

class UpdatePasswordPage extends GetView<UpdatePasswordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(height: IZIDimensions.iziSize.height, width: IZIDimensions.iziSize.width, color: ColorResources.NEUTRALS_7),
      body: GetBuilder(
        builder: (UpdatePasswordController controller) {
          return Container(
            margin: EdgeInsets.symmetric(
              horizontal: IZIDimensions.ONE_UNIT_SIZE * 40,
            ),
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),

                  // button
                  // backButton(),

                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                  ),

                  Expanded(
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
                          "ĐỔI MẬT KHẨU",
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 30,
                        ),

                        /// FORM
                        fogetpasswordForm(),

                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 30,
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
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
            "Nhập mật khẩu mới của bạn để cập nhật lại mật khẩu",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          passwordInput(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          repeatPassword(),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          nextButton()
        ],
      ),
    );
  }

  ///
  ///  PASSSWORD INPUT
  ///
  Widget passwordInput() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: 'Mật khẩu mới',
      initValue: controller.phone,
      fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
      borderRadius: 5,
      disbleError: true,
      onChanged: (val) {
        controller.phone = val;
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
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  ///
  /// repeat password INPUT
  ///
  Widget repeatPassword() {
    return IZIInput(
      type: IZIInputType.PHONE,
      placeHolder: 'Xác nhận mật khẩu',
      initValue: controller.phone,
      fillColor: ColorResources.NEUTRALS_5.withOpacity(0.25),
      borderRadius: 5,
      disbleError: true,
      onChanged: (val) {
        controller.phone = val;
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
      style: const TextStyle(
        fontWeight: FontWeight.w700,
        color: ColorResources.PRIMARY_3,
      ),
    );
  }

  Widget nextButton() {
    return IZIButton(
      onTap: () {
        controller.updatePassword();
      },
      label: "Đổi mật khẩu",
      borderRadius: 10,
    );
  }
}
