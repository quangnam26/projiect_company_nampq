import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/auth/otp_request.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/provider/auth_provider.dart';
import '../../../../data/model/user/user_response.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_alert.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../provider/user_provider.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class ChangeThePassWordController extends GetxController {
  //khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserRequest userRequest = UserRequest();
  UserResponse userResponse = UserResponse();
  OTPRequest otpRequest = OTPRequest();
  AuthProvider authProvider = AuthProvider();

  String? idUser;
  String phone = '';

  String? oldPassword, newPassWord, confirmPassWord;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getDatatUser();
  }

  ///
  ///Get User by Id
  ///
  void getDatatUser() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      userProvider.find(
        id: (Get.arguments as UserResponse).id!,
        onSuccess: (model) {
          userResponse = model;
          update();
        },
        onError: (onError) {},
      );
    } else {
      userProvider.find(
        id: sl<SharedPreferenceHelper>().getProfile,
        onSuccess: (model) {
          userResponse = model;
          update();
        },
        onError: (onError) {},
      );
    }
  }

  ///
  ///update Account
  ///
  void updateData() {
    if (isValidateValidSignup()) {
      if (!IZIValidate.nullOrEmpty(Get.arguments)) {
        otpRequest.phone = (Get.arguments as UserResponse).phone;

        authProvider.sendOTP(
            phone: otpRequest,
            onSuccess: (data) {
              userRequest.phone = otpRequest.phone;
              userRequest.password = newPassWord;
              userRequest.otpCode = data;
              userProvider.updatePasswordbyPhone(
                  data: userRequest,
                  onSuccess: (onSuccess) {
                    IZIAlert.success(message: "Tạo mật khẩu mới thành công");
                  },
                  onError: (onError) {
                    IZIAlert.error(
                        message: "Tạo mật khẩu mới không thành công");
                  });
            },
            onError: (onError) {
              print(onError);
            });
      } else {
        userRequest.phone = userResponse.phone;
        userRequest.password = oldPassword;
        userRequest.newPassword = newPassWord;
        userProvider.checkPassword(
            idUser: sl<SharedPreferenceHelper>().getProfile,
            password: oldPassword!,
            onSuccess: (onSuccess) {
              userProvider.updatePassword(
                data: userRequest,
                onSuccess: (onSuccess) {
                  IZIAlert.success(message: "Thay đổi mật khẩu thành công");
                },
                onError: (onError) {
                  IZIAlert.error(message: "Mật khẩu cũ không đúng");
                  print("$onError");
                },
              );
            },
            onError: (onError) {
              IZIAlert.error(message: "Mật khẩu cũ không đúng");
              print("$onError");
            });
      }
    }
  }

  ///
  /// check validate input infor
  ///
  bool isValidateValidSignup() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      if (IZIValidate.nullOrEmpty(newPassWord)) {
        IZIAlert.error(message: "vui lòng nhập mật mới ");
        return false;
      }
      if (IZIValidate.nullOrEmpty(confirmPassWord)) {
        IZIAlert.error(message: "vui lòng nhập lại mật khẩu");
        return false;
      }
      if (newPassWord != confirmPassWord) {
        IZIAlert.error(message: "Mật khẩu không trùng khớp");
        return false;
      }
    } else if (IZIValidate.nullOrEmpty(oldPassword)) {
      IZIAlert.error(message: "Vui lòng nhập mật khẩu");
      return false;
    } else if (IZIValidate.nullOrEmpty(newPassWord)) {
      IZIAlert.error(message: "vui lòng nhập mật mới ");
      return false;
    } else if (IZIValidate.nullOrEmpty(confirmPassWord)) {
      IZIAlert.error(message: "vui lòng nhập lại mật khẩu");
      return false;
    }
    if (newPassWord != confirmPassWord) {
      IZIAlert.error(message: "Mật khẩu không trùng khớp");
      return false;
    }

    return true;
  }

  ///
  /// Input old Password
  ///
  void inputOldPassWord(String newOldPassWord) {
    oldPassword = newOldPassWord;
    update();
  }

  ///
  /// Input New PassWord
  ///
  void inputNewPassWord(String newPassword1) {
    newPassWord = newPassword1;
    update();
  }

  ///
  /// Confirm PassWord
  ///
  void inputConfirmPassWord(String newConfirmPassWord) {
    confirmPassWord = newConfirmPassWord;
    update();
  }
}
