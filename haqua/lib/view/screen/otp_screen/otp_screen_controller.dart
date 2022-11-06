// ignore_for_file: use_setters_to_change_properties

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/otp/otp_request.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/auth_provider.dart';
import 'package:template/provider/otp_provider.dart';
import 'package:template/routes/route_path/areas_of_expertise_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class OTPScreenController extends GetxController {
  /// Declare API.
  final OTPProvider oTPProvider = GetIt.I.get<OTPProvider>();
  final AuthProvider authProvider = GetIt.I.get<AuthProvider>();
  final DioClient dioClient = GetIt.I.get<DioClient>();
  Rx<AuthRequest> authRequest = AuthRequest().obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isEnabledButton = true.obs;
  RxString otpCodeController = ''.obs;

  @override
  void onInit() {
    super.onInit();

    /// Get Argument from before screen.
    getArguments();
  }

  @override
  void dispose() {
    isEnabledButton.close();
    otpCodeController.close();
    super.dispose();
  }

  ///
  /// Get Argument from before screen.
  ///
  void getArguments() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      authRequest.value = Get.arguments as AuthRequest;

      /// Call API for get OTP code.
      getOTP();
    }
  }

  ///
  /// On change OTP code.
  ///
  void onChangedOTPCode(String value) {
    otpCodeController.value = value;
  }

  ///
  /// Call API for get OTP code.
  ///
  void getOTP() {
    final OTPRequest otpRequest = OTPRequest();
    otpRequest.phone = authRequest.value.phone.toString();
    oTPProvider.sendOTP(
      request: otpRequest,
      onSuccess: (otp) {
        isLoading = false;
        update();
        IZIToast().successfully(message: "Mã OTP: $otp");
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// goToAreasOfExpertisePage
  ///
  void goToAreasOfExpertisePage() {
    isEnabledButton.value = false;

    EasyLoading.show(status: "please_waiting".tr);
    authRequest.value.otpCode = otpCodeController.value;
    authRequest.value.typeRegister = "haqua";
    authRequest.value.deviceId = sl<SharedPreferenceHelper>().getTokenDevice.toString();
    authProvider.signUpHaQua(
      request: authRequest.value,
      onSuccess: (model) async {
        print("Token Login ${model.accessToken}");
        sl<SharedPreferenceHelper>().setLogin(status: true);
        sl<SharedPreferenceHelper>().setIdUser(model.id.toString());
        await sl<SharedPreferenceHelper>().setJwtToken(model.accessToken.toString());

        /// Reset Dio jwtToken when first time Login App.
        await dioClient.resetInit();

        isEnabledButton.value = true;

        EasyLoading.dismiss();
        Get.toNamed(AreasOfExpertiseRoutes.AREAS_OF_EXPERTISE);
      },
      onError: (error) {
        print(error);
        isEnabledButton.value = true;

        EasyLoading.dismiss();
        IZIToast().error(message: "error_otp".tr);
      },
    );
  }
}
