import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/routes/route_path/auth_routes.dart';

import '../../../../data/model/provider/provider.dart';
import '../../../../helper/izi_alert.dart';

class VerifyOtpController extends GetxController {
  StreamController<ErrorAnimationType>? errorController;
  final Provider provider = Provider();
  TextEditingController textEditingController = TextEditingController();
  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  bool isRegister = false;
  AuthRequest authRequest = AuthRequest();
  @override
  void onInit() {
    // init error pin code controller
    final arg = Get.arguments;
    if (arg != null) {
      // isRegister = true là đăng ký
      isRegister = arg['isRegister'] as bool;
      authRequest = arg['data'] as AuthRequest;
    }
    errorController = StreamController<ErrorAnimationType>();
    super.onInit();
  }

  ///
  /// on forget password button
  ///
  void onVerifyOtp() {
    validateOTP();
    if (hasError == false) {
      authRequest.otpCode = textEditingController.text;
      if (isRegister) {
        provider.auth(
          AuthResponse(),
          requestBody: authRequest,
          onSuccess: (data) {
            Get.offAllNamed(
              AuthRoutes.LOGIN,
            );
            IZIAlert.success(message: "Đăng ký tài khoản thành công");
          },
          onError: (onError) {
            IZIAlert.success(message: "Mã OTP không đúng hoặc hết hạn. Vui lòng thử lại");
            print(" An error occurred while sign up $onError");
          },
        );
      }
    }
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

  @override
  void onClose() {
    errorController!.close();

    super.onClose();
  }

  @override
  void dispose() {
    errorController!.close();
    textEditingController.dispose();
    super.dispose();
  }
}
