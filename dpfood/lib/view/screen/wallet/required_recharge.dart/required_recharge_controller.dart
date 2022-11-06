import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/setting/setting_response.dart';
import 'package:template/data/model/transaction/transaction_resquest.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/provider/image_upload_provider.dart';
import 'package:template/provider/setting_provider.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class RequiredRechargeController extends GetxController {
  final TransactionProvider transactionProvider =
      GetIt.I.get<TransactionProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();

  final SettingProvider settingProvider = GetIt.I.get<SettingProvider>();
  final ImageUploadProvider imageUploadProvider =
      GetIt.I.get<ImageUploadProvider>();

  SettingResponse settingResponse = SettingResponse();
  TransactionRequest transactionRequest = TransactionRequest();

  Rx<UserResponse> userResponse = UserResponse().obs;

  String? idUser;
  String? money;
  String contentTransaction = '';
  bool isLoading = true;

  // Upload Avatar
  List<File> files = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('bbb');

    idUser = sl<SharedPreferenceHelper>().getProfile;
    money = Get.arguments as String;
    onGetDataSetting();
    update();
  }

  ///
  ///getDataUser
  ///
  void getDataUser(String idUser) {
    userProvider.find(
        id: idUser,
        onSuccess: (data) {
          userResponse.value = data;
          contentTransaction =
              "${userResponse.value.phone}-${money!.replaceAll('.', '')}VND";
          update();
        },
        onError: (onError) => print(onError));

    isLoading = false;
    update();
  }

  ///
  ///onGetDataSetting
  ///
  void onGetDataSetting() {
    settingProvider.all(
        onSuccess: (data) {
          print(data.toList());
          if (data.isNotEmpty) {
            settingResponse = data.first;
            update();
            getDataUser(idUser!);
          }
        },
        onError: (error) => print(error));
  }

  ///
  ///copyAccount
  ///
  void copyAccount(String content) {
    FlutterClipboard.copy(content).then((value) {
      IZIAlert.success(message: "Đã sao chép $content");
    });
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

  void onSummit() {
    if (files.isNotEmpty) {
      EasyLoading.show(status: 'loading...');
      imageUploadProvider.addImages(
          files: files,
          onSuccess: (data) => {
                if (data.isNotEmpty)
                  {
                    onCreateTransaction(image: data[0]),
                  },
              },
          onError: (error) => {
                EasyLoading.dismiss(),
              });
    } else {
      IZIAlert.error(message: 'Bạn phải chọn hình ảnh giao dịch');
    }
  }

  ///
  ///onCreateTransaction
  ///
  void onCreateTransaction({required String image}) {
    transactionRequest.idUser = idUser;
    transactionRequest.money = IZINumber.parseInt(money!.replaceAll('.', ''));
    transactionRequest.transactionImage = image;
    transactionRequest.title = 'Nạp tiền vào tài khoản';
    transactionRequest.content = 'Nạp tiền vào tài khoản';

    transactionProvider.add(
        data: transactionRequest,
        onSuccess: (data) {
          IZIAlert.success(
              message: 'Yêu cầu nạp tiền thành công. Vui lòng đợi phê duyệt');
          EasyLoading.dismiss();
          Get.back(result: true);
        },
        onError: (error) {
          print(error);
          EasyLoading.dismiss();
        });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
