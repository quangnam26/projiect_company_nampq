import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/image_upload_provider.dart';

import '../../../../data/model/user/user_request.dart';
import '../../../../data/model/user/user_response.dart';
import '../../../../provider/user_provider.dart';

class DetailPersonalController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUploadProvider imageUploadProvider =
      GetIt.I.get<ImageUploadProvider>();
  Rx<UserResponse> userResponse = UserResponse().obs;

  TextEditingController fullNameController = TextEditingController();

  final List<String> filesConfirm = <String>[];

  // Upload Avatar
  File? fileAvatar;

  List<File> files = [];

  bool isClickAvatar = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userResponse.value = Get.arguments as UserResponse;
    if (!IZIValidate.nullOrEmpty(userResponse.value.fullName)) {
      fullNameController.text = userResponse.value.fullName.toString();
    }
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future pickImageAvatar() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      EasyLoading.show(status: 'Please waiting...');
      fileAvatar = File(images.path);
      isClickAvatar = true;
      update();
      files = [File(images.path)];
      print('Count images select ${files.length}');
      EasyLoading.dismiss();
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
    }
  }

  // Future pickMultiImage() async {
  //   try {
  //     final images = await ImagePicker().pickMultiImage();
  //     if (images == null) return;
  //     EasyLoading.show(status: 'Please waiting...');
  //     fileAvatar = File(images[0].path);
  //     update();
  //     for (final item in images) {
  //       files.add(File(item.path));
  //     }

  //     print('Count images select ${files.length}');
  //     EasyLoading.dismiss();
  //   } on PlatformException catch (e) {
  //     print("Failed to pick file: $e");
  //     EasyLoading.dismiss();
  //     IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
  //   }
  // }

  ///
  ///onSummit
  ///
  void onSummit() {
    if (fullNameController.text.isNotEmpty) {
      if (files.isNotEmpty && isClickAvatar) {
        EasyLoading.show(status: 'loading...');
        imageUploadProvider.addImages(
            files: files,
            onSuccess: (data) => {
                  if (data.isNotEmpty)
                    {
                      onUpdateUser(fullNameController.text, data[0]),
                    },
                },
            onError: (error) => {
                  EasyLoading.dismiss(),
                });
      } else if (!isClickAvatar && userResponse.value.avatar!.isNotEmpty) {
        onUpdateUser(fullNameController.text, userResponse.value.avatar);
      } else {
        IZIAlert.error(message: 'Bạn phải chọn ảnh đại diện');
      }
    } else {
      IZIAlert.error(message: 'Bạn phải nhập họ và tên');
    }
  }

  ///
  ///onUpdateUser
  ///
  void onUpdateUser(String? name, String? url) {
    final UserRequest userRequest = UserRequest();
    userRequest.id = userResponse.value.id;
    if (name!.isNotEmpty) userRequest.fullName = name;
    if (url!.isNotEmpty) userRequest.avatar = url;

    userProvider.update(
        data: userRequest,
        id: userRequest.id!,
        onSuccess: (onSuccess) => {
              EasyLoading.dismiss(),
              IZIAlert.success(message: 'Cập nhật thành công'),
              Get.back(),
            },
        onError: (onError) => {
              EasyLoading.dismiss(),
              IZIAlert.error(message: 'Cập nhật không thành công'),
            });
  }
}
