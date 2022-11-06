// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/data/model/answer/answer_request.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/izi_preview_image_routers.dart';
import 'package:template/routes/route_path/izi_successful_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

import '../../../data/datasource/remote/dio/izi_socket.dart';
import '../dash_board/dash_board_controller.dart';

class DetailQuestionController extends GetxController {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final IZISocket iziSocket = GetIt.I.get<IZISocket>();
  Rx<QuestionResponse> questionResponse = QuestionResponse().obs;
  Rx<UserResponse> userResponse = UserResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isLogin = false.obs;
  RxBool isJustOneAddRequest = false.obs;
  String? idQuestion;
  RxString moneyAuctionController = '0'.obs;

  @override
  void onInit() {
    super.onInit();

    /// Get argument from before screen.
    getArgument();
  }

  @override
  void dispose() {
    isLogin.close();
    questionResponse.close();
    userResponse.close();
    isJustOneAddRequest.close();
    moneyAuctionController.close();
    super.dispose();
  }

  ///
  /// Get argument from before screen.
  ///
  void getArgument() {
    isLogin.value = sl<SharedPreferenceHelper>().getLogin;

    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idQuestion = Get.arguments.toString();
    }

    /// Call API get data detail question.
    getDetailQuestionById();
  }

  ///
  /// Call API get data detail question.
  ///
  void getDetailQuestionById() {
    questionProvider.find(
      filterPopulate: "answerList.idUser",
      id: idQuestion.toString(),
      onSuccess: (model) {
        questionResponse.value = model;

        ///  Call API get data user.
        getUserById();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data user.
  ///
  void getUserById() {
    if (isLogin.value == false) {
      isLoading = false;
      update();
    } else {
      userProvider.find(
        id: sl<SharedPreferenceHelper>().getIdUser,
        onSuccess: (model) {
          userResponse.value = model;
          isLoading = false;
          update();
        },
        onError: (error) {
          print(error);
        },
      );
    }
  }

  ///
  /// Download files.
  ///
  Future<void> downloadFiles({required String urlFiles}) async {
    IZIOther.downloadFiles(url: urlFiles);
  }

  ///
  /// Go to [Preview image page].
  ///
  void goToPreviewImage({required String imageUrl}) {
    Get.toNamed(IZIPreviewImageRoutes.IZI_PREVIEW_IMAGE, arguments: imageUrl);
  }

  ///
  /// Generate button.
  ///
  bool genBoolButton() {
    if (isLogin.value == false) {
      return true;
    }

    if (!IZIValidate.nullOrEmpty(questionResponse.value.answerList)) {
      if (questionResponse.value.answerList!.map((e) => e.idUser!.id.toString()).toList().any((element) => element.toString().contains(sl<SharedPreferenceHelper>().getIdUser)) == true) {
        return false;
      }
    }

    return true;
  }

  ///
  /// Go to [successful page].
  ///
  void goToDonePage() {
    if (isLogin.value == false) {
      Get.find<DashBoardController>().showDialogLogin();
    } else {
      EasyLoading.show(status: 'please_waiting'.tr);
      if (isJustOneAddRequest.value == false) {
        isJustOneAddRequest.value = true;
        final AnswerRequest answerRequest = AnswerRequest();
        answerRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser;
        if (questionResponse.value.moneyFrom == 0 && questionResponse.value.moneyTo == 0) {
          answerRequest.price = 0;
        } else {
          answerRequest.price = IZINumber.parseInt(moneyAuctionController.value.replaceAllMapped('.', (match) => ''));
        }
        answerRequest.statusSelect = WAITING;
        final QuestionRequest questionRequest = QuestionRequest();
        questionRequest.answerer = answerRequest;
        questionProvider.update(
          isisOnlyAddAnswerer: true,
          id: idQuestion.toString(),
          data: questionRequest,
          onSuccess: (model) {
            final Map<String, dynamic> paramSocket = {
              'idAuthorQuestion': questionResponse.value.idUser!.id.toString(),
              'idQuestion': idQuestion,
              'fullNameQuote': userResponse.value.fullName.toString(),
              'statusQuote': QUOTED,
            };

            /// Shoot socket for [Home page].
            iziSocket.socket.emit('proposal_socket', paramSocket);

            /// Shoot socket for [Helping waiting list page].
            iziSocket.socket.emit('quote_socket', paramSocket);
            isJustOneAddRequest.value = false;
            EasyLoading.dismiss();
            Get.back();
            Get.toNamed("${IZISuccessfulRoutes.IZI_SUCCESSFUL}?idQuestion=${questionResponse.value.id.toString()}", arguments: answerRequest);
          },
          onError: (error) {
            print(error);
          },
        );
      }
    }
  }

  ///
  /// On validate import money.
  ///
  bool onValidateMoneyAuction() {
    if (IZIValidate.nullOrEmpty(moneyAuctionController)) {
      IZIToast().error(message: "validate_money_1".tr);

      return false;
    }

    if (IZINumber.parseInt(moneyAuctionController.value.replaceAllMapped('.', (match) => '')) < IZINumber.parseInt(questionResponse.value.moneyFrom)) {
      IZIToast().error(message: "validate_import_money_1".tr);
      return false;
    }

    if (IZINumber.parseInt(moneyAuctionController.value.replaceAllMapped('.', (match) => '')) > IZINumber.parseInt(questionResponse.value.moneyTo)) {
      IZIToast().error(message: "validate_import_money_1".tr);
      return false;
    }

    return true;
  }

  ///
  /// On change value money.
  ///
  void onChangedValueMoneyAuction(String val) {
    moneyAuctionController.value = val;
  }

  ///
  /// Show Auction dialog.
  ///
  void showDialogAuction() {
    if (questionResponse.value.moneyFrom == 0 && questionResponse.value.moneyTo == 0) {
      goToDonePage();
    } else {
      IZIDialog.showDialog(
        lable: "Question_Auction".tr,
        confirmLabel: "Agree".tr,
        cancelLabel: "back".tr,
        onCancel: () {
          Get.back();
        },
        onConfirm: () {
          if (onValidateMoneyAuction()) {
            goToDonePage();
          }
        },
        content: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    "Question_Auction_content_dialog".tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: IZIDimensions.ONE_UNIT_SIZE * 10,
                        ),
                        child: IZIImage(
                          ImagesPath.logo_dollar_detail_question,
                          color: ColorResources.PRIMARY_APP,
                        ),
                      ),
                      Text(
                        (questionResponse.value.moneyFrom != 0 && questionResponse.value.moneyTo != 0) ? "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(questionResponse.value.moneyFrom))}vnđ - ${IZIPrice.currencyConverterVND(IZINumber.parseDouble(questionResponse.value.moneyTo))}vnđ" : "Miễn phí",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: IZIInput(
                    type: IZIInputType.PRICE,
                    isBorder: true,
                    colorBorder: ColorResources.PRIMARY_APP,
                    disbleError: true,
                    onChanged: (val) {
                      /// On change value money auction.
                      onChangedValueMoneyAuction(val);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
