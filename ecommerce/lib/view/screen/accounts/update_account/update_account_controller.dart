import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';

import '../../../../data/model/provider/provider.dart';
import '../../../../di_container.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class UpdateAccountController extends GetxController {
  final Provider provider = Provider();
  String idUser = '';
  UserRequest currentUser = UserRequest();
  UserRequest userRequest = UserRequest();
  bool isLoadingUser = true;

  RxString avatar = ''.obs;

  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    _getUser();
  }

  ///
  ///get user
  ///
  void _getUser() {
    provider.findOne(
      UserRequest(),
      id: idUser,
      onSuccess: (data) {
        currentUser = data as UserRequest;
        isLoadingUser = false;
        update();
      },
      onError: (onError) {
        print("An error occurred while getting the user $onError");
      },
    );
  }

  ///
  /// update user
  ///
  void onUpdateUser() {
    EasyLoading.show(status: "Đang cập nhật ...");
    // updateUser();

    if (!IZIValidate.nullOrEmpty(avatar.value)) {
      print("endPoint: ${avatar.value}");
      provider.uploadImage(
        files: [],
        endPoint: avatar.value,
        method: IZIMethod.GET,
        onSuccess: (data) {
          print("Đã upload");
          if (!IZIValidate.nullOrEmpty(data) &&
              !IZIValidate.nullOrEmpty(data.files)) {
            print(data.files!.first);
            userRequest.avatar = "$BASE_URL_IMAGE/static/${data.files!.first}";
            updateUser();
          }
        },
        onError: (onError) {
          print("An error occurred while uploading the user $onError");
        },
      );
    } else {
      updateUser();
    }
  }

///
/// updateUser
///
  void updateUser() {
    provider.update(
      UserRequest(),
      id: idUser,
      requestBody: userRequest,
      onSuccess: (data) {
        EasyLoading.dismiss();
        Get.back();
      },
      onError: (onError) {
        print("An error occurred while updating the user $onError");
      },
    );
  }

  ///
  /// Pick image
  ///
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      final imagePicker = imageTemporary;
      provider.uploadImage(
        files: [imagePicker],
        onSuccess: (data) {
          if (!IZIValidate.nullOrEmpty(data)) {
            // avatar.value = data.files!.first;
            userRequest.avatar = "$BASE_URL_IMAGE/static/${avatar.value}";
          }
        },
        onError: (onError) {
          print("An error occurred while uploading the image $onError");
        },
      );
      update();
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
      //chưa cấp quyền thì vào setting hệ thống cho phép
      openAppSettings();
    }
  }

  void onUpdateAccount() {
    updateUser();
  }
}
