import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/auth_routes.dart';
import 'package:template/routes/route_path/history_order.dart';
import 'package:template/routes/route_path/personal_routers.dart';
import 'package:template/routes/route_path/wallet_money_routers.dart';

import '../../../di_container.dart';
import '../../../provider/user_provider.dart';
import '../../../sharedpref/constants/enum_helper.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class PersonalController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  Rx<UserResponse> userResponse = UserResponse().obs;

  // List Infor Account
  List<Map<String, dynamic>> listMapAccount = [
    {
      "icon_left": CupertinoIcons.person,
      "name": "Thông tin cá nhân",
      "icon_right": Icons.arrow_forward_ios,
      "page": PersonalRoutes.DETAILPERSONAL,
      "agrument": null
    },

    // {
    //   "icon_left": CupertinoIcons.paperplane_fill,
    //   "name": "Quản lý giỏ hàng",
    //   "icon_right": Icons.arrow_forward_ios,
    //   "page": "",
    //   "agrument": null
    // },
    {
      "icon_left": Icons.timer_outlined,
      "name": "Lịch sử đơn hàng",
      "icon_right": Icons.arrow_forward_ios,
      "page": HistoryOrderRoutes.HISTORYORDER,
      "agrument": null
    },
    {
      "icon_left": Icons.wallet,
      "name": "DPPay",
      "icon_right": Icons.arrow_forward_ios,
      "page": WalletMoneyRoutes.WALLETMONEY,
      "agrument": null
    },
    {
      "icon_left": Icons.password_rounded,
      "name": "Đổi mật khẩu",
      "icon_right": Icons.arrow_forward_ios,
      "page": AuthRoutes.FORGET_PASSWORD,
      "agrument": AuthEnum.CHANGE_PASSWORD,
    },
    {
      "icon_left": Icons.logout,
      "name": "Đăng xuất",
      "icon_right": null,
      "page": AuthRoutes.LOGIN,
    },
  ];
// Upload Avatar
  File? fileAvatar;

  RxString idUser = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getDataUserWithId();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  void getDataUserWithId() {
    idUser = sl<SharedPreferenceHelper>().getProfile.obs;
    userProvider.find(
        id: idUser.value,
        onSuccess: (onSuccess) => {
              if (!IZIValidate.nullOrEmpty(onSuccess))
                {
                  userResponse.value = onSuccess,
                  for (var i = 0; i < 3; i += 1)
                    {listMapAccount[i]['agrument'] = userResponse.value}
                },
              update(),
            },
        onError: (onError) => print(onError));
  }

  ///
  /// pickImages Avatar
  ///
  Future pickImageAvatar() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      EasyLoading.show(status: 'Please waiting...');
      fileAvatar = File(images.path);
      update();
      final List<File> files = [File(images.path)];
      print('Count images select ${files.length}');
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIAlert.error(message: 'Bạn phải cho phép quyền truy cập hệ thống');
    }
  }

  ///
  /// navigator page
  ///
  void navigatorPage(String page, dynamic agrument) {
    
    if (agrument == null || agrument == '') {
       if (page == AuthRoutes.LOGIN) { 
        Get.offAllNamed(AuthRoutes.LOGIN,
            predicate: ModalRoute.withName(AuthRoutes.LOGIN)); 
      } else {
        Get.toNamed(page)!.then((value) => getDataUserWithId());
      }
    } else {
      Get.toNamed(page, arguments: agrument)!
          .then((value) => getDataUserWithId());
    }
  }
}
