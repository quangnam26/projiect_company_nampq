import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import '../../../data/model/transaction/transaction_request.dart';
import '../../../provider/transaction_provider.dart';

class WithDrawMoneyController extends GetxController {
  //Khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final TransactionProvider transactionProvider = GetIt.I.get<TransactionProvider>();

  //Khai báo data
  TextEditingController moneyRechargeController = TextEditingController();
  String obscureCharacters = "************";
  String accountBalance = "0";
  String? nameAccountController;
  String? errorTextNameAccount;
  String? bankNumberAccountController;
  String? errorTextBankNumberAccount;
  String? nameBankController;
  String? errorTextNameBank;
  List<String> defaultAmountList = [
    "10000",
    "50000",
    "100000",
  ];
  String initValueNameAccount = '';
  String initValueNumberAccount = '';
  String initValueNameBank = '';
  bool isEnableErrorNameAccount = true;
  bool isEnableErrorBankNumberAccount = true;
  bool isEnabledErrorNameBank = true;
  bool obscure = true;
  bool isLoading = true;
  bool isJustOneClick = false;
  bool isEnabledValidateAmount = false;
  int selected = 0;
  bool isFocus = false;
  bool isFocusAccountName = false;
  bool isFocusAccountNumber = false;
  bool isFocusBankName = false;
  QuestionRequest questionRequest = QuestionRequest();
  UserResponse userResponse = UserResponse();
  FocusNode focusNodeInput = FocusNode();
  FocusNode focusNodeInputAccountName = FocusNode();
  FocusNode focusNodeInputAccountNumber = FocusNode();
  FocusNode focusNodeInputBankName = FocusNode();

  @override
  void onInit() {
    super.onInit();

    focusNodeInput.addListener(() {
      isFocus = focusNodeInput.hasFocus;
      update();
    });
    focusNodeInputAccountName.addListener(() {
      isFocusAccountName = focusNodeInputAccountName.hasFocus;
      update();
    });
    focusNodeInputAccountNumber.addListener(() {
      isFocusAccountNumber = focusNodeInputAccountNumber.hasFocus;
      update();
    });
    focusNodeInputBankName.addListener(() {
      isFocusBankName = focusNodeInputBankName.hasFocus;
      update();
    });
    getInfoUser();
  }

  ///
  /// getInfoUser
  ///
  void getInfoUser() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {
        userResponse = model;
        accountBalance = userResponse.defaultAccount.toString();

        if (!IZIValidate.nullOrEmpty(userResponse.bankAccountName)) {
          initValueNameAccount = userResponse.bankAccountName.toString();
          nameAccountController = userResponse.bankAccountName;
          isEnableErrorNameAccount = false;
        }

        if (!IZIValidate.nullOrEmpty(userResponse.bankAccountNumber)) {
          initValueNumberAccount = userResponse.bankAccountNumber.toString();
          bankNumberAccountController = userResponse.bankAccountNumber;
          isEnableErrorBankNumberAccount = false;
        }

        if (!IZIValidate.nullOrEmpty(userResponse.bankName)) {
          initValueNameBank = userResponse.bankName.toString();
          nameBankController = userResponse.bankName;
          isEnabledErrorNameBank = false;
        }

        isLoading = false;
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  ///Change obscure ví của tôi
  ///
  void onChangedIsVisible() {
    obscure = !obscure;
    update();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void setDefaultAmount(int index) {
    selected = index;

    final moneyConvert = IZIPrice.currencyConverterVND(double.parse(defaultAmountList[index].replaceAll(".", "").replaceAll("đ", "").toString()));
    moneyRechargeController.text = moneyConvert.substring(0, moneyConvert.length - 1);
    moneyRechargeController.selection = TextSelection.fromPosition(TextPosition(offset: moneyRechargeController.text.length));
    if (IZINumber.parseInt(IZINumber.parseDouble(moneyRechargeController.text.replaceAll(".", ""))) < IZINumber.parseInt(accountBalance)) {
      isEnabledValidateAmount = false;
    } else {
      isEnabledValidateAmount = true;
    }
    update();
  }

  ///
  /// onChangedValueAmount
  ///
  void onChangedValueAmount(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnabledValidateAmount = true;
    } else if (IZINumber.parseInt(IZINumber.parseDouble(moneyRechargeController.text.replaceAll(".", ""))) < IZINumber.parseInt(accountBalance)) {
      isEnabledValidateAmount = false;
    } else {
      isEnabledValidateAmount = true;
    }

    if (!IZIValidate.nullOrEmpty(val) && moneyRechargeController.text.replaceAll(".", "") != '0') {
      List<int> valueMulti = [];
      int lengthList = 0;
      if (moneyRechargeController.text.replaceAll(".", "").length < 4) {
        valueMulti = [1000, 10000, 100000];
        lengthList = 3;
      } else if (moneyRechargeController.text.replaceAll(".", "").length < 6) {
        valueMulti = [10, 100, 1000];
        lengthList = 3;
      } else if (moneyRechargeController.text.replaceAll(".", "").length >= 6) {
        valueMulti = [10];
        lengthList = 1;
      }
      defaultAmountList.clear();
      for (int i = 0; i < lengthList; i++) {
        defaultAmountList.add((IZINumber.parseInt(moneyRechargeController.text.replaceAll(".", "")) * valueMulti[i]).toString());
      }
    }
    update();
  }

  ///
  /// onValidateNameAccount
  ///
  String? onValidateNameAccount(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnableErrorNameAccount = true;
      update();
      return errorTextNameAccount = "ten_tai_khoan_khong_de_trong".tr;
    }
    isEnableErrorNameAccount = false;
    update();
    return errorTextNameAccount = "";
  }

  ///
  /// onChangeValueNameAccount
  ///
  void onChangeValueNameAccount(String val) {
    nameAccountController = val;
    update();
  }

  ///
  /// onValidateBankNumberAccount
  ///
  String? onValidateBankNumberAccount(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnableErrorBankNumberAccount = true;
      update();
      return errorTextBankNumberAccount = "so_tai_khoan_khong_dung".tr;
    }
    isEnableErrorBankNumberAccount = false;
    update();
    return errorTextBankNumberAccount = "";
  }

  ///
  /// onChangeValueBankNumberAccount
  ///
  void onChangeValueBankNumberAccount(String val) {
    bankNumberAccountController = val;
    update();
  }

  ///
  /// onValidateBankName
  ///
  String? onValidateBankName(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnabledErrorNameBank = true;
      update();
      return errorTextNameBank = "so_tai_khoan_khong_dung".tr;
    }
    isEnabledErrorNameBank = false;
    update();
    return errorTextNameBank = "";
  }

  ///
  /// onChangeValueBankName
  ///
  void onChangeValueBankName(String val) {
    nameBankController = val;
    update();
  }

  ///
  /// genIsEnableButton
  ///
  bool genIsEnableButton() {
    if (isEnabledValidateAmount == false && isEnableErrorNameAccount == false && isEnabledErrorNameBank == false && isEnableErrorBankNumberAccount == false) {
      return true;
    }
    return false;
  }

  ///
  /// goToWithdrawal
  ///

  void goToWithdrawal() {
    IZIDialog.showDialog(
      lable: "rut_tien".tr,
      confirmLabel: "dong_y".tr,
      cancelLabel: "quay_lai".tr,
      description: "vui_long_kiem_tra".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();
        withDrawMoney();
      },
    );
  }

  ///
  /// withDrawMoney
  ///
  void withDrawMoney() {
    if (isJustOneClick = false) {
      isJustOneClick = true;
      update();

      EasyLoading.show(status: 'please_waiting'.tr);
      final TransactionRequest transactionRequest = TransactionRequest();
      transactionRequest.money = IZINumber.parseInt(moneyRechargeController.text);
      transactionProvider.withdrawMoney(
        data: transactionRequest,
        onSuccess: (data) {
          final UserRequest userRequest = UserRequest();
          userRequest.bankAccountName = nameAccountController;
          userRequest.bankAccountNumber = bankNumberAccountController;
          userRequest.bankName = nameBankController;
          userProvider.update(
            data: userRequest,
            onSuccess: (data) {
              isJustOneClick = false;
              update();
              EasyLoading.dismiss();
              Get.back();
            },
            onError: (error) {
              print(error);
            },
          );
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }
}
