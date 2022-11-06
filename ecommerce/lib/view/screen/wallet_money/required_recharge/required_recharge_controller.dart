import 'dart:io';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/setting_bank/setting_bank_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/setting_bank_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_controller.dart';
import '../../../../data/model/transaction/transaction_request.dart';
import '../../../../helper/izi_number.dart';
import '../../../../provider/image_upload_provider.dart';
import '../../../../provider/transaction_provider.dart';
import '../../../../provider/user_provider.dart';

class RequiredRechargeController extends GetxController {
  // khai báo API
  final TransactionProvider transactionProvider =
      GetIt.I.get<TransactionProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ImageUploadProvider imageUploadProvider =
      GetIt.I.get<ImageUploadProvider>();

  final SettingBankProvider settingProvider =
      GetIt.I.get<SettingBankProvider>();

  SettingBankResponse settingResponse = SettingBankResponse();
  UserResponse userResponse = UserResponse();
  TransactionRequest transactionRequest = TransactionRequest();

  // Upload Avatar
  List<File> files = [];

  // Khai báo biến
  String accountNumber = '';
  String? idUser;
  String? money;
  String? contentTransaction;
  bool isLoading = true;
  String contentAcount = '';
  PaymentMethod? paymentMethod;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    if (Get.arguments != null) {
      if (Get.arguments is! String &&
          !IZIValidate.nullOrEmpty(Get.arguments['money']) &&
          !IZIValidate.nullOrEmpty(Get.arguments['type'])) {
        print("ABC");
        money = Get.arguments['money'] as String;
        paymentMethod = Get.arguments['type'] as PaymentMethod;
      } else {
        money = Get.arguments as String;
      }
    }
    onGetDataSetting();
  }

  ///
  ///OnGetDataSetting
  ///
  void onGetDataSetting() {
    settingProvider.all(
        onSuccess: (model) {
          print(model.toList());
          if (model.isNotEmpty) {
            settingResponse = model.first;
            _getDataUser(idUser!);
            update();
          }
        },
        onError: (error) => print(error));
  }

  ///
  ///GetDataUser
  ///
  void _getDataUser(String idUser) {
    userProvider.find(
        id: idUser,
        onSuccess: (data) {
          userResponse = data;
          contentTransaction = userResponse.phone ?? "23423";
          update();
        },
        onError: (onError) => print(onError));

    // isLoading = false;
    update();
  }

  ///
  ///CopyAccount
  ///
  void copyAccount(String content) {
    FlutterClipboard.copy(content).then((value) {
      IZIAlert.success(message: "Đã sao chép $content");
    });
  }

  void copyAccount1(String content1) {
    FlutterClipboard.copy(content1).then((value) {
      IZIAlert.success(message: "Đã sao chép $content1");
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

  ///
  ///OnSummit
  ///
  void onSummit() {
    if (files.isNotEmpty) {
      EasyLoading.show(status: 'loading...');
      imageUploadProvider.addImages(
        files: files,
        onSuccess: (data) => {
          if (data.isNotEmpty)
            {
              onCreateTransaction(
                image: data[0],
              ),
            },
        },
        onError: (error) => {
          EasyLoading.dismiss(),
        },
      );
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
    if (paymentMethod == PaymentMethod.momo) {
      transactionRequest.title = 'Đặt hàng';
      transactionRequest.content = 'Thanh toán sản phẩm';
      transactionRequest.typeTransaction = "MOMO";
    }

    transactionProvider.add(
      data: transactionRequest,
      onSuccess: (data) {
        if (paymentMethod != null) {
          IZIAlert.success(
              message: 'Yêu cầu thanh toán thành công. Vui lòng đợi phê duyệt');
        } else {
          IZIAlert.success(
              message: 'Yêu cầu nạp tiền thành công. Vui lòng đợi phê duyệt');
        }

        EasyLoading.dismiss();
        Get.back(result: true);
      },
      onError: (error) {
        print(error);
        EasyLoading.dismiss();
      },
    );
  }
}
