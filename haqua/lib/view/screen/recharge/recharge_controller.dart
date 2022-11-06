import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/bank_transfer_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';

class RechargeController extends GetxController {
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  QuestionRequest questionRequest = QuestionRequest();
  Rx<UserResponse> userResponse = UserResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  RxString obscureCharacters = '*********'.obs;
  RxString accountBalance = "0".obs;
  RxString transferType = TRANSFERS.obs;
  RxBool obscure = true.obs;
  RxBool isSelected = true.obs;
  RxBool isFirstValidateAmount = false.obs;
  RxBool isEnabledValidateAmount = false.obs;
  RxBool isFocus = false.obs;
  RxList<String> defaultAmountList = [
    "10000",
    "50000",
    "100000",
  ].obs;
  RxInt select = 0.obs;
  RxInt typeRecharge = 0.obs;
  final List<int> radioIndex = [0, 1];
  FocusNode focusNodeInput = FocusNode();
  TextEditingController moneyRechargeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    focusNodeInput.addListener(() {
      isFocus.value = focusNodeInput.hasFocus;
    });

    /// Get argument the from before screen.
    getArgument();
  }

  @override
  void dispose() {
    userResponse.close();
    obscureCharacters.close();
    accountBalance.close();
    transferType.close();
    obscure.close();
    isSelected.close();
    isFirstValidateAmount.close();
    isEnabledValidateAmount.close();
    isFocus.close();
    defaultAmountList.close();
    select.close();
    typeRecharge.close();
    super.dispose();
  }

  ///
  /// Get argument the from before screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.parameters["typeRecharge"])) {
      typeRecharge.value = IZINumber.parseInt(Get.parameters["typeRecharge"].toString());
    }
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      questionRequest = Get.arguments as QuestionRequest;
    }

    /// Call API get info user.
    getInfoUser();
  }

  ///
  /// Call API get info user.
  ///
  void getInfoUser() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {
        userResponse.value = model;
        accountBalance.value = userResponse.value.defaultAccount.toString();
        if (typeRecharge.value == 1) {
          isFirstValidateAmount.value = true;
          moneyRechargeController.text = IZIPrice.currencyConverterVND(
            IZINumber.parseDouble(questionRequest.moneyTo),
          ).substring(
              0,
              IZIPrice.currencyConverterVND(
                    IZINumber.parseDouble(questionRequest.moneyTo),
                  ).length -
                  1);
        }

        /// Just [update] first load [Recharge page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// On click radio button.
  ///
  void onClickRadioButton(int index) {
    select.value = index;
    if (select.value == 0) {
      transferType.value = TRANSFERS;
    } else {
      transferType.value = MOMO;
    }

  }

  ///
  /// On change obscure my wallet.
  ///
  void onChangedIsVisible() {
    obscure.value = !obscure.value;
  }

  ///
  /// On change obscure my wallet.
  ///
  void setDefaultAmount(int index) {
    isFirstValidateAmount.value = true;
    isEnabledValidateAmount.value = false;
    final moneyConvert = IZIPrice.currencyConverterVND(double.parse(defaultAmountList[index].replaceAll(".", "").replaceAll("đ", "").toString()));
    moneyRechargeController.text = moneyConvert.substring(0, moneyConvert.length - 1);
    moneyRechargeController.selection = TextSelection.fromPosition(TextPosition(offset: moneyRechargeController.text.length));
  }

  ///
  /// On change value amount.
  ///
  void onChangedValueAmount(String val) {
    isFirstValidateAmount.value = true;
    if (IZIValidate.nullOrEmpty(val)) {
      isEnabledValidateAmount.value = true;
    } else if (IZINumber.parseInt(IZINumber.parseDouble(moneyRechargeController.text.replaceAll(".", ""))) <= 0) {
      isEnabledValidateAmount.value = true;
    } else {
      isEnabledValidateAmount.value = false;
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
  }

  ///
  /// Generate enable button.
  ///
  bool genIsEnableButton() {
    if (isEnabledValidateAmount.value == false && isFirstValidateAmount.value == true) {
      return true;
    }
    return false;
  }

  ///
  /// Go to [Bank transfer page].
  ///
  void goToBankTransfer() {
    if (IZIValidate.nullOrEmpty(moneyRechargeController.text) || IZINumber.parseInt(moneyRechargeController.text.replaceAll(".", "")) <= 0) {
    } else {
      if (typeRecharge.value == 0) {
        Get.toNamed("${BankTranferRouters.BANKTRANFER}?typeRecharge=$typeRecharge&transferType=$transferType&depositAmount=${moneyRechargeController.text.replaceAll(".", '').trim()}")!.then((value) {
          if (!IZIValidate.nullOrEmpty(value) && value == true) {
            Get.back();
          }
        });
      } else {
        Get.toNamed("${BankTranferRouters.BANKTRANFER}?typeRecharge=$typeRecharge&transferType=$transferType&depositAmount=${moneyRechargeController.text.replaceAll(".", '').trim()}", arguments: questionRequest);
      }
    }
  }
}
