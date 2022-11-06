import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/helper/izi_validate.dart';
import '../../../../../data/model/user/user_request.dart';
import '../../../../../data/model/user/user_response.dart';
import '../../../../../di_container.dart';
import '../../../../../helper/izi_alert.dart';
import '../../../../../helper/izi_date.dart';
import '../../../../../provider/image_upload_provider.dart';
import '../../../../../provider/user_provider.dart';
import '../../../../../sharedpref/shared_preference_helper.dart';

class InputPersonalInformationController extends GetxController {
  //khai bao API
  final ImageUploadProvider imageUploadProvider =
      GetIt.I.get<ImageUploadProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserResponse? userResponse;
  UserRequest userRequest = UserRequest();

//list

  List<dynamic>? myAlbum;
  List<File> files = [];
  List<String> albumsList = [];
  List<String> newCapacityList = [];

  //khai báo biến
  String? phoneNumberController;
  String? fullNameController;
  String? errorTextName;
  String? sexController;
  String? bornController;
  bool isEditedAvatar = false;
  bool switchValue = false;
  bool isEditedAlbum = false;
  String? errorSex;
  String? exmail;
  String? errorEmail;
  String? errorNumber;
  int? dateOfbrithController;
  String? emailController;
  String? phoneTextName;
  String? fileAvatar;
  int? initBorn;

  @override
  void onInit() {
    super.onInit();
    final UserResponse userResponse = Get.arguments as UserResponse;
    if (!IZIValidate.nullOrEmpty(userResponse.born)) {
      initBorn = userResponse.born;
    }
    print(
        "dataa ${IZIDate.formatDate(DateTime.fromMicrosecondsSinceEpoch(int.parse(userResponse.born.toString())))}");

    bornController = IZIDate.formatDate(DateTime.fromMicrosecondsSinceEpoch(
        int.parse(userResponse.born.toString())));

    sexController = getGenderValueCreateQuestion(userResponse.gender ?? "");
    fullNameController = userResponse.fullName ?? "";
    emailController = userResponse.email ?? "";
    phoneNumberController = userResponse.phone ?? "";
    fileAvatar = userResponse.avatar ?? "";
  }

  ///
  ///formatDate
  ///
  DateTime formatDateTime(String dateTime) {
    if (!IZIValidate.nullOrEmpty(dateTime)) {
      return DateFormat('dd-MM-yyyy').parse(dateTime);
    }
    return DateTime(1970);
  }

  ///
  ///getGenderValueCreateQuestion
  ///
  static String getGenderValueCreateQuestion(String value) {
    if (value.toString().contains('Nam')) {
      return 'Nam';
    } else if (value.toString().contains('Nữ')) {
      return 'Nữ';
    }
    return 'Khác';
  }

  ///
  ///  Changed Name
  ///

  void onChangedValueName(String val) {
    fullNameController = val;
    update();
  }

  ///
  /// onValidateName
  ///
  String onValidateName(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorTextName = "Tên không được để trống";
    }
    if (val.length < 5) {
      return errorTextName = "Tên quá ngắn";
    }
    if (val.length > 27) {
      return errorTextName = "Tên quá dài";
    }
    if (val.length > 10) {
      return errorTextName = "vui lòng nhập đủ @gmail";
    }

    return errorTextName = "";
  }

  ///
  /// onChangedGender
  ///
  void onChangedGender(String val) {
    sexController = val;
    update();
  }

  ///
  /// onChangedBorn
  ///
  void onChangedBorn(String val) {
    print("vall $val");

    bornController = val;
    //  (IZIDate.parse("20-02-2022")).toString();
    update();
    print(val);
  }

  ///
  ///onChangedEmail
  ///
  void onChangedEmail(String newEmail) {
    emailController = newEmail;
    update();
  }

  ///
  ///onVailiDateEmail
  ///
  String? onVailiDateEmail(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      return errorEmail = 'Tên không được để trống';
    }
    if (val.length < 3) {
      return errorEmail = "Tên quá ngắn";
    }
    if (val.length > 30) {
      return errorEmail = "Tên quá dài";
    }
    if (!val.contains('@gmail.com')) {
      return errorEmail = "Thiếu @gmail.com";
    }

    return errorEmail = null;
  }

  ///
  ///onChangedNumber
  ///
  void onChangedNumber(String newNumber) {
    phoneNumberController = newNumber;
    update();
  }

  ///
  ///pickImageAvatar
  ///
  Future pickImage() async {
    files = [];
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      EasyLoading.show(status: 'Please waiting...');
      // update();
      files = [File(images.path)];
      imageUploadProvider.addImages(
        files: files,
        onSuccess: (List<String> value) {
          fileAvatar = value.first;
          isEditedAvatar = true;
          EasyLoading.dismiss();
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          // IZIToast().error(message: e.toString());
        },
      );
      EasyLoading.dismiss();
    } on PlatformException {
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
    }
  }

  ///
  ///UpdateGender
  ///

  String updateGender(String gender) {
    if (gender.toString() == "Nữ") {
      sexController = "FEMALE";
    } else if (gender.toString() == "Nam") {
      sexController = "MALE";
    } else {
      sexController = "ORTHER";
    }
    return sexController!;
  }

  String parseTimeStamp(int value) {
    final date = DateTime.fromMillisecondsSinceEpoch(
        int.parse(bornController.toString()) * 1000);
    final d12 = DateFormat('MM-dd-yyyy, hh:mm a').format(date);
    return d12;
  }

  ///
  ///GetGoToBack
  ///
  void getGoToBack() {
    userRequest.fullName = fullNameController;
    userRequest.gender = updateGender(sexController!);
    userRequest.born = (bornController.toString().indexOf("-") == 2)
        ? initBorn
        : IZIDate.parse(bornController.toString()).microsecondsSinceEpoch;
    userRequest.email = emailController;
    userRequest.phone =
        phoneNumberController!.replaceFirst(RegExp('0'), '').toString();
    userRequest.avatar = fileAvatar;
    userProvider.update(
        data: userRequest,
        id: sl<SharedPreferenceHelper>().getProfile,
        onSuccess: (onSuccess) {
          IZIAlert.success(
              message: "Cập nhập thành công", backgroundColor: Colors.green);
          Get.back(result: onSuccess);
        },
        onError: (onError) {
          IZIAlert.success(
              message: "Vui lòng nhậ kiễm tra và  đủ đầy đủ thông tin cập nhập",
              backgroundColor: Colors.red);
        });

    // Get.arguments as UserResponse;
  }
}
