import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/recharge_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

class PaymentForPeopleAnswerQuesController extends GetxController {
  //Khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();

  //Khai bao data
  String amountAccount = "0";
  String amountAccountHide = "*************";
  bool isHide = true;
  bool isLoading = true;
  int typeRecharge = 0;
  UserResponse userResponse = UserResponse();
  QuestionRequest questionRequest = QuestionRequest();

  @override
  void onInit() {
    super.onInit();
    getArgument();
  }

  ///
  /// getArgument
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.parameters["typeRecharge"])) {
      typeRecharge = IZINumber.parseInt(Get.parameters["typeRecharge"].toString());
    }
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      questionRequest = Get.arguments as QuestionRequest;
    }

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
        amountAccount = IZIPrice.currencyConverterVND(IZINumber.parseDouble(userResponse.defaultAccount.toString()));

        isLoading = false;
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// onChangeHideAmountAccount
  ///
  void onChangeHideAmountAccount() {
    isHide = !isHide;
    update();
  }

  ///
  ///onGoToShareVideoPage
  ///
  void onGoToRechargePage() {
    Get.toNamed("${RechargeRouters.RECHARGE}?typeRecharge=1", arguments: questionRequest);
  }
}
