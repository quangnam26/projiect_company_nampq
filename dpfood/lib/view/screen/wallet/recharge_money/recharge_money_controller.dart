import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/routes/route_path/wallet_money_routers.dart';

import '../../../../base_widget/animated_custom_dialog.dart';
import '../../../../base_widget/my_dialog_alert_done.dart';
import '../../../../utils/images_path.dart';

class RechargeMoneyController extends GetxController {
  //Khai báo API

  UserResponse userResponse = UserResponse();

  // WithDrawMoneyRespository withDrawMoneyRespository =
  //     GetIt.I.get<WithDrawMoneyRespository>();

// Khai báo data
  String? idUser;

// khai bao obscure so du
  TextEditingController moneyRechargeController = TextEditingController();
  //so du
  bool obscure = true;
  String accountBalance = "0";
  String obscureCharacters = "************";

// khai bao
  bool isFirstValidateAmount = false;
  bool isEnabledValidateAmount = false;

  // khai bao Amount to deposit
  String? erroTextAmountToDeposit;
  bool? isTextAmountToDeposit = false;
  String? toMoney;

  // khai bao nameAccountNumber
  String? errorTextName;
  bool isEnableButtonName = false;
  String? fullName;

  // khai bao AccountNumber
  String? errorTextAccountNumber;
  bool isEnableButtonAccountNumber = false;
  String? accountNumber;

  // khai bao nameBank
  String? errorTextNameBank;
  bool isEnableButtonNameBank = false;
  String? nameBank;

  int typeRecharge = 0;
  //  khai báo color
  int selected = 0;
  // khai bao
  bool isLoading = true;

  // disable Button
  bool disableButton = false;

  String depositAmount = '0';

  String? inputMoney;

  String? imageTransaction;

  List<String> defaultAmountList = [
    "100.000",
    "200.000",
    "300.000",
    "600.000",
    "800.000",
    "1.000.000",
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  ///
  ///Change obscure ví của tôi icon
  ///
  void onChangedIsVisible() {
    obscure = !obscure;
    update();
  }

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

//
// onTap color
//
  void ontap(int index) {
    selected = index;
    update();
  }

  ///
  ///Change obscure ví của tôi
  ///
  void setDefaultAmount(int index) {
    final moneyConvert = IZIPrice.currencyConverterVND(double.parse(
        defaultAmountList[index]
            .replaceAll(".", "")
            .replaceAll("đ", "")
            .toString()));
    moneyRechargeController.text =
        moneyConvert.substring(0, moneyConvert.length - 1);
    isEnabledValidateAmount = false;
    update();
  }

  ///
  /// genIsEnableButton
  ///
  bool genIsEnableButton() {
    if (isEnabledValidateAmount == true) {
      return false;
    }
    return true;
  }

  ///
  /// onChangedValueName
  ///
  void onChangeValueName(String val) {
    fullName = val;
    update();
  }

  ///
  /// onValidateName nhập tên tài khoản bắt buộc
  ///
  String? onValidateName(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnableButtonName = false;
      update();
      return errorTextName = 'Tên tài khoản không được để trống';
    }
    if (userResponse.fullName != val) {
      isEnableButtonName = false;
      print('so sanh ${userResponse.fullName}');
      update();
      return errorTextName = 'Số tài khoản không đúng';
    }
    isEnableButtonName = true;
    disableButton = true;
    isEnabledValidateAmount = isEnableButtonName == true &&
        isEnableButtonNameBank == true &&
        isEnableButtonAccountNumber == true;

    update();
    return errorTextName = "";
  }

  ///
  /// onChangedValueAccountNumber
  ///
  void onChangedValueAccountNumber(String val) {
    accountNumber = val;
    update();
  }

  ///
  /// onValidate AccountNumber nhập số tài khoản nhận
  ///
  String? onValidateAcountNumber(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnableButtonAccountNumber = false;
      update();
      return errorTextAccountNumber = "Số tài khoản không được để trống";
    }

    // if (userResponse.bankAccountNumber != val) {
    //   isEnableButtonAccountNumber = false;
    //   update();
    //   return errorTextAccountNumber = "so_tai_khoan_khong_dung".tr;
    // }

    isEnableButtonAccountNumber = true;
    isEnabledValidateAmount = isEnableButtonName == true &&
        isEnableButtonNameBank == true &&
        isEnableButtonAccountNumber == true;
    update();
    return errorTextAccountNumber = "";
  }

  ///
  /// onChangedValueAccountNumber
  ///
  void onChangedValueNameBank(String val) {
    nameBank = val;
    update();
  }

  ///
  /// onValidateName nhập tên ngân hàng
  ///
  String? onValidateNameBank(String val) {
    // if (IZIValidate.nullOrEmpty(val)) {
    //   isEnableButtonNameBank = false;
    //   update();
    //   return errorTextNameBank = "Tên tài khoản không được để trống";
    // }
    // if (userResponse.bankName != val) {
    //   isEnableButtonNameBank = false;

    //   update();
    //   return errorTextNameBank = "Tên ngân hàng không đúng ";
    // }
    isEnableButtonNameBank = true;
    // isEnabledValidateAmount = true;
    isEnabledValidateAmount = isEnableButtonName == true &&
        isEnableButtonNameBank == true &&
        isEnableButtonAccountNumber == true;
    update();
    return errorTextNameBank = '';
  }

  void gotoWalletHistory() {
    // final input = inputMoney!.replaceAll(".", "");
    // final TransactionRequest transactionRequest = TransactionRequest();
    // print("transaction1 ${transactionRequest.statusTransaction}");
    // transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
    // transactionRequest.statusTransaction = 1;
    // transactionRequest.typeTransaction = 1;
    // transactionRequest.title = "rut_tien_tu_tai_khoan".tr;
    // transactionRequest.money = IZINumber.parseInt(input);
    // transactionRequest.transactionImage = imageTransaction;

    // transactionProvider.add(
    //   data: transactionRequest,
    //   onSuccess: (models) {
    //     Get.back();
    //     Get.back();
    //     update();
    //   },
    //   onError: (onError) {
    //     print(onError);
    //   },
    // );
  }

  ///
  /// goToWithdrawal
  ///

  void goToWithdrawal(BuildContext context) {
    showAnimatedDialog(
      context,
      MyDialogAlertDone(
        icon: Icons.check,
        title: "Rút tiền",
        description: 'Bạn có chắc chắn nạp tiền vào Ví tài khoản',
        imagesIcon: ImagesPath.RECHARGE,
        direction: Axis.horizontal,
        onTapCancle: () {
          Get.back();
        },
        onTapConfirm: () {
          Get.back();
          showAnimatedDialog(
            context,
            MyDialogAlertDone(
              icon: Icons.check,
              title: "Yêu cầu nạp tiền thành công",
              description:
                  'Hệ thống đang kiểm duyệt.Vui lòng chờ 1 - 2 ngày để hoàn thành thủ tục.',
              imagesIcon: ImagesPath.RECHARGE,
              direction: Axis.vertical,
              textAlignDescription: TextAlign.center,
              onTapCancle: () {
                Get.back();
              },
            ),
          );
        },
      ),
    );

    // final input = inputMoney!.replaceAll(".", "");
    // if (IZINumber.parseInt(accountBalance) - IZINumber.parseInt(input) < 0) {
    //   IZIAlert.error(message: 'Tài khoản của bạn');
    // } else {
    //   IZIDialog.showDialog(
    //     lable: 'Rút tiền',
    //     confirmLabel: 'Đồng ý',
    //     cancelLabel: 'Quay lại',
    //     description: 'Vui lòng kiểm tra',
    //     onCancel: () {
    //       Get.back();
    //     },
    //     onConfirm: () {
    //       gotoWithdrawMoney();
    //       gotoWalletHistory();
    //       update();
    //     },
    //   );
    // }
  }

  ///
  /// gotoWithdrawMoney
  ///
  void gotoWithdrawMoney() {
    final abc = inputMoney!.replaceAll(".", "");
    // withDrawMoneyProvider.update(
    //   money: {"money": int.parse(abc)},
    //   onSuccess: (onSuccess) {
    //     print("sucsac ${onSuccess}");
    //     // getInforUserId();()
    //     gotoWalletHistory();
    //     update();
    //   },
    //   onError: (onError) {},
    // );
  }

  ///
  /// on Go to required recharge
  ///
  void onGoToRequiredRecharge() {
    if (moneyRechargeController.text.isNotEmpty) {
      Get.toNamed(WalletMoneyRoutes.REQUIRED_RECHARGE,
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
