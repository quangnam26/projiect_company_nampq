import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/change_password_routers.dart';
import '../../../../data/model/provider/provider.dart';
import '../../../../sharedpref/constants/enum_helper.dart';

class VerifyOtpController extends GetxController {
  StreamController<ErrorAnimationType>? errorController;
  final Provider provider = Provider();
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  bool isRegister = false;
  AuthRequest authRequest = AuthRequest();
  AuthEnum authEnum = AuthEnum.FORGET_PASSWORD;
  @override
  void onInit() {
    // init error pin code controller
    final arg = Get.arguments;
    print(arg);
    if (arg != null) {
      if (arg['type'] != null) {
        authEnum = arg['type'] as AuthEnum;
      }
    }
    // errorController = StreamController<ErrorAnimationType>();
    // super.onInit();
  }

  ///
  /// on forget password button
  ///
  void onVerifyOtp() {
    validateOTP();
    // Nếu là đỏi mật khẩu authEnum =>  API đổi mật khẩu
    // Nếu là quên mật khẩu authEnum => API quên mật khẩu
    if (authEnum == AuthEnum.CHANGE_PASSWORD) {
      Get.toNamed(
        ChangePassWordRoutes.CHANGEPASS,
      );
    } else {
      Get.offAllNamed(
        AuthRoutes.UPDATE_PASSWORD,
      );
    }

    // if (hasError == false) {
    //   authRequest.otpCode = textEditingController.text;
    //   if (isRegister) {
    //     provider.auth(
    //       AuthResponse(),
    //       requestBody: authRequest,
    //       onSuccess: (data) {
    //         Get.offAllNamed(
    //           AuthRoutes.LOGIN,
    //         );
    //         IZIAlert.success(message: "Đăng ký tài khoản thành công");
    //       },
    //       onError: (onError) {
    //         IZIAlert.success(message: "Mã OTP không đúng hoặc hết hạn. Vui lòng thử lại");
    //         print(" An error occurred while sign up $onError");
    //       },
    //     );
    //   }
    // }
  }

  ///
  /// Validate
  ///
  void validateOTP() {
    formKey.currentState!.validate();
    if (textEditingController.text.length != 4) {
      errorController!.add(ErrorAnimationType.shake);
      hasError = true;
      update();
    } else {
      hasError = false;
      update();
    }
  }

  ///
  /// onback
  ///
  void onBack() {
    Get.back();
  }

  @override
  void onClose() {
    errorController?.close();
    super.onClose();
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }
}
