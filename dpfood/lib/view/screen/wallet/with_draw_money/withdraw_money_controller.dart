import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/my_dialog_alert_done.dart';
import 'package:template/data/model/transaction/transaction_resquest.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images_path.dart';

import '../../../../../base_widget/animated_custom_dialog.dart';

class WithDrawMoneyController extends GetxController {
  //Khai báo API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final TransactionProvider transactionProvider =
      GetIt.I.get<TransactionProvider>();
  UserResponse userResponse = UserResponse();

  UserRequest userRequest = UserRequest();

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
    getInforUserId();
    update();
  }

  ///
  ///Change obscure ví của tôi icon
  ///
  void onChangedIsVisible() {
    obscure = !obscure;
    update();
  }

  ///
  ///* getInforUserId
  ///
  void getInforUserId() {
    // isLoading = true;
    idUser = sl<SharedPreferenceHelper>().getProfile;
    userProvider.find(
      id: idUser!,
      onSuccess: (data) {
        Future.delayed(const Duration(milliseconds: 500), () async {
          userResponse = data;
          accountBalance = data.defaultAccount.toString();

          userRequest.bankAccountName =
              IZIValidate.nullOrEmpty(userResponse.bankAccountName)
                  ? ''
                  : userResponse.bankAccountName;
          userRequest.bankAccountNumber = userResponse.bankAccountNumber == 0
              ? 0
              : userResponse.bankAccountNumber;
          userRequest.bankName =
              IZIValidate.nullOrEmpty(userResponse.bankAccountName)
                  ? ''
                  : userResponse.bankAccountName;

          isLoading = false;

          update();
        });
      },
      onError: (onError) {},
    );
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
  /// goToWithdrawal
  ///

  void goToWithdrawal(BuildContext context) {
    if (moneyRechargeController.text.isEmpty) {
      IZIAlert.error(message: 'Vui lòng nhập số tiền');
    } else if (IZINumber.parseInt(
            moneyRechargeController.text.replaceAll('.', '')) >
        IZINumber.parseInt(accountBalance)) {
      IZIAlert.error(message: 'Số tiền rút phải nhỏ hoặc bằng số dư trong ví');
    } else if (IZIValidate.nullOrEmpty(userRequest.bankAccountName)) {
      IZIAlert.error(message: 'Vui lòng nhập tên tài khoản');
    } else if (IZIValidate.nullOrEmpty(userRequest.bankAccountNumber) ||
        userRequest.bankAccountNumber == 0) {
      IZIAlert.error(message: 'Vui lòng nhập số tài khoản');
    } else if (IZIValidate.nullOrEmpty(userRequest.bankName)) {
      IZIAlert.error(message: 'Vui lòng nhập tên ngân hàng');
    } else {
      showAnimatedDialog(
        context,
        MyDialogAlertDone(
          icon: Icons.check,
          title: "Rút tiền",
          description: 'Bạn có chắc chắn rút tiền từ Ví DPPay',
          imagesIcon: ImagesPath.RECHARGE,
          onTapCancle: () {
            Get.back();
          },
          onTapConfirm: () {
            EasyLoading.show(status: 'loading...');
            userProvider.update(
                id: userResponse.id!,
                data: userRequest,
                onSuccess: (data) {
                  final TransactionRequest transactionRequest =
                      TransactionRequest(
                    idUser: userResponse.id,
                    methodTransaction: 'transfers',
                    typeTransaction: 'withdraw',
                    money: IZINumber.parseInt(
                        moneyRechargeController.text.replaceAll('.', '')),
                    title: 'Yêu cầu rút tiền từ ví DPPay',
                    content: 'Rút tiền từ ví DPPay',
                  );

                  transactionProvider.add(
                      data: transactionRequest,
                      onSuccess: (value) {
                        EasyLoading.dismiss();
                        showAnimatedDialog(
                          context,
                          MyDialogAlertDone(
                            icon: Icons.check,
                            title: "Yêu cầu rút tiền thành công",
                            description:
                                'Hệ thống đang kiểm duyệt.\nVui lòng chờ 1 - 2 ngày để hoàn thành thủ tục.',
                            imagesIcon: ImagesPath.RECHARGE,
                            direction: Axis.vertical,
                            textAlignDescription: TextAlign.center,
                            onTapCancle: () {
                              Get.back();
                              Get.back();
                              Get.back(result: true);
                            },
                            onTapConfirm: () {
                              Get.back();
                              Get.back();
                              Get.back(result: true);
                            },
                          ),
                        );
                      },
                      onError: (err) {
                        EasyLoading.dismiss();
                      });
                },
                onError: (error) {
                  EasyLoading.dismiss();
                });
          },
        ),
      );
    }
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
}
