import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/data/model/user/user_response.dart';

import '../../../../helper/izi_alert.dart';
import '../../../../helper/izi_number.dart';
import '../../../../helper/izi_price.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../routes/route_path/wallet_routes.dart';

class ReChargeController extends GetxController {
// khai bao obscure so du
  UserResponse userResponse = UserResponse();
  TextEditingController moneyRechargeController = TextEditingController();

//List
  List<String> list = [
    "100.000 đ",
    "200.000 đ",
    "300.000 đ",
    "400.000 đ",
    "500.000 đ",
    "600.000 đ"
  ];

//Khai báo biến
  bool obscure = true;
  String accountBalance = "0";
  String obscureCharacters = "************";
  String? erroTextAmountToDeposit;
  bool isFirstValidateAmount = false;
  bool isEnabledValidateAmount = false;
  int value = 0;
  String? inputMoney;

  @override
  void onInit() {
    super.onInit();
    accountBalance = (Get.arguments as UserResponse).defaultAccount.toString();
    // TODO: implement onInit
  }

  ///
  ///iziInput
  ///
  IZIInput iziInput = IZIInput(
    type: IZIInputType.NUMBER,
    placeHolder: 'Số tiền (vnđ)',
    label: 'Nhập số tiền cần nạp',
  );

  ///
  /// onChangedValueAmount
  ///
  void onChangedValueAmount(String val) {
    isFirstValidateAmount = true;
    if (IZIValidate.nullOrEmpty(val)) {
      isEnabledValidateAmount = true;
    } else if (IZINumber.parseInt(IZINumber.parseDouble(
            moneyRechargeController.text.replaceAll(".", ""))) <=
        0) {
      isEnabledValidateAmount = true;
    } else {
      isEnabledValidateAmount = false;
    }
    print(isEnabledValidateAmount);
    update();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedIsVisible() {
    obscure = !obscure;
    update();
  }

  ///
  ///selec
  ///
  void selec(int index) {
    value = index;
    update();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void setDefaultAmount(int index) {
    final moneyConvert = IZIPrice.currencyConverterVND(double.parse(
        list[index].replaceAll(".", "").replaceAll("đ", "").toString()));
    moneyRechargeController.text =
        moneyConvert.substring(0, moneyConvert.length - 1);
    isEnabledValidateAmount = false;
    update();
  }

  ///
  /// on Go to required recharge
  ///
  void onGoToRequiredRecharge() {
    if (moneyRechargeController.text.isNotEmpty) {
      Get.toNamed(WalletRouters.REQUIRED_RECHAGE,
              arguments: moneyRechargeController.text)
          ?.then((value) {
        if (value == true) {
          Get.back(result: true);
        }
      });
    } else {
      IZIAlert.error(message: 'Bạn phải chọn số tiền cần nạp');
    }
  }
}
