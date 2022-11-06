import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/forgot_password/forgot_password_controller.dart';

class ForgotPasswordPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: ForgotPasswordController(),
        builder: (ForgotPasswordController controller) {
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
          );
        },
      ),
    );
  }
}
