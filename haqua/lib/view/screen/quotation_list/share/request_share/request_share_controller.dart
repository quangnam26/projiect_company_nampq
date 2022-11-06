import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/quotation_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class RequestShareController extends GetxController {
  //Khai bao API
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();

  //Khai bao data
  bool isLoading = true;
  QuestionResponse? questionResponse;
  String? idQuestion;
  String? errorTextMoneyShare;
  bool isMore = false;
  bool isJustOneClick = false;
  bool isFocus = false;
  bool isEnabledValidateAmount = false;
  FocusNode focusNodeInput = FocusNode();
  List<String> defaultAmountList = [
    "10000",
    "50000",
    "100000",
  ];
  TextEditingController moneyRechargeController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    focusNodeInput.addListener(() {
      isFocus = focusNodeInput.hasFocus;
      update();
    });
    getArgument();
  }

  ///
  /// getArgument
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idQuestion = Get.arguments.toString();
    }

    getDetailQuestionById();
  }

  ///
  /// getDetailQuestionById
  ///
  void getDetailQuestionById() {
    questionProvider.find(
      filterPopulate: "idUser.idProvince",
      id: idQuestion.toString(),
      onSuccess: (model) {
        questionResponse = model;
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///onChangeIsMore
  ///
  void onChangeIsMore() {
    isMore = !isMore;
    update();
  }

  ///
  /// genBoolButton
  ///
  bool genBoolButton() {
    if (!IZIValidate.nullOrEmpty(moneyRechargeController.text)) {
      return true;
    }
    return false;
  }

  ///
  ///Change obscure ví của tôi
  ///
  void setDefaultAmount(int index) {
    final moneyConvert = IZIPrice.currencyConverterVND(double.parse(defaultAmountList[index].replaceAll(".", "").replaceAll("đ", "").toString()));
    moneyRechargeController.text = moneyConvert.substring(0, moneyConvert.length - 1);

    update();
  }

  ///
  /// onChangedValueAmount
  ///
  void onChangedValueAmount(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      errorTextMoneyShare = "validate_import_money_1".tr;
    } else {
      errorTextMoneyShare = "";
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
  /// confirmShareVideo
  ///
  void confirmShareVideo() {
    EasyLoading.show(status: "please_waiting".tr);
    if (isJustOneClick == false) {
      isJustOneClick = true;
      update();

      final QuestionRequest questionRequest = QuestionRequest();
      questionRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser;
      questionRequest.price = IZINumber.parseInt(moneyRechargeController.text.replaceAllMapped('.', (match) => ''));
      questionProvider.shareVideo(
        id: idQuestion.toString(),
        data: questionRequest,
        onSuccess: (val) {
          isJustOneClick = false;
          update();
          EasyLoading.dismiss();
          Get.toNamed(QuotationRoutes.NOTIFYSHARE, arguments: moneyRechargeController.text.replaceAllMapped('.', (match) => ''));
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }
}
