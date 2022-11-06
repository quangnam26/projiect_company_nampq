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
import 'package:template/routes/route_path/share_video_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';


class ShareVideoController extends GetxController {
  //Khai bao API
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();

  //Khai bao data
  String? idQuestion;
  String? errorTextMoneyShare;
  List<String> defaultAmountList = [
    "10000",
    "50000",
    "100000",
  ];
  bool isLoading = true;
  bool isFocus = false;
  TextEditingController moneyRechargeController = TextEditingController();
  FocusNode focusNodeInput = FocusNode();
  QuestionResponse? questionResponse;

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
      filterPopulate: "idUser.idProvince,answerList.idUser",
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
  /// genBoolButton
  ///
  bool genBoolButton() {
    if (!IZIValidate.nullOrEmpty(moneyRechargeController.text)) {
      return true;
    }
    return false;
  }

  ///
  /// goToShareVideoSuccessfullyPage
  ///
  void goToShareVideoSuccessfullyPage() {
    EasyLoading.show(status: "please_waiting".tr);
    final QuestionRequest questionRequest = QuestionRequest();
    questionRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser;
    questionRequest.price = IZINumber.parseInt(moneyRechargeController.text.replaceAllMapped('.', (match) => ''));
    questionProvider.shareVideo(
      id: idQuestion.toString(),
      data: questionRequest,
      onSuccess: (val) {
        EasyLoading.dismiss();
        Get.toNamed(ShareVideoRoutes.SHARE_VIDEO_SUCCESSFULLY);
      },
      onError: (error) {
        print(error);
      },
    );
  }
}
