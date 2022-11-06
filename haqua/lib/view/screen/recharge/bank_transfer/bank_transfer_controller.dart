import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/settings/settings_reponse.dart';
import 'package:template/data/model/transaction/transaction_request.dart';
import 'package:template/data/model/upload_files/upload_files_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/transaction_provider.dart';
import 'package:template/provider/upload_files_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../provider/settings_provider.dart';

class BankTransferPageController extends GetxController {
  //Khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final UploadFilesProvider uploadFilesProvider = GetIt.I.get<UploadFilesProvider>();
  final TransactionProvider transactionProvider = GetIt.I.get<TransactionProvider>();
  final SettingsProvider settingProvider = GetIt.I.get<SettingsProvider>();
  QuestionRequest questionRequest = QuestionRequest();
  UserResponse userResponse = UserResponse();
  SettingResponse settingResponse = SettingResponse();

  //Khai báo data
  bool isLoading = true;
  bool isLoadingImage = false;
  bool isEnableButton = true;
  File? fileTranslation;
  int typeRecharge = 0;
  String depositAmount = '0';
  String? imageTransaction;
  String transferType = TRANSFERS;

  @override
  void onInit() {
    super.onInit();

    /// Call API get setting data.
    getQuizPercent();
  }

  ///
  /// Call API get setting data.
  ///
  void getQuizPercent() {
    settingProvider.findSetting(
      onSuccess: (model) {
        if (!IZIValidate.nullOrEmpty(model)) {
          settingResponse = model!;
        }

        /// Get the from before screen.
        getArgument();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// getArgument
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.parameters["typeRecharge"])) {
      typeRecharge = IZINumber.parseInt(Get.parameters["typeRecharge"].toString());
    }
    if (!IZIValidate.nullOrEmpty(Get.parameters["depositAmount"])) {
      depositAmount = Get.parameters["depositAmount"].toString();
    }
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      questionRequest = Get.arguments as QuestionRequest;
    }

    if (!IZIValidate.nullOrEmpty(Get.parameters['transferType'])) {
      transferType = Get.parameters['transferType'].toString();
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

        isLoading = false;
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  ///Show dialog Login
  ///
  void rechargeMoney(BuildContext context) {
    IZIDialog.showDialog(
      lable: "recharge".tr,
      confirmLabel: "Agree".tr,
      cancelLabel: "back".tr,
      description: "content_dialog_recharge".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();
        if (isEnableButton == true) {
          if (typeRecharge == 1) {
            {
              confirmUrlFilesBeforeCreateQuestion();
            }
          } else {
            EasyLoading.show(status: 'please_waiting'.tr);
            final UploadFilesRequest uploadImagesRequest = UploadFilesRequest();
            uploadImagesRequest.files = [imageTransaction];
            uploadFilesProvider.confirmUploadFiles(
              data: uploadImagesRequest,
              onSuccess: (models) {
                final TransactionRequest transactionRequest = TransactionRequest();
                transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
                transactionRequest.methodTransaction = TRANSFERS;
                transactionRequest.typeTransaction = RECHARGE;
                transactionRequest.statusTransaction = WAITING_TRANSACTION;
                transactionRequest.title = "Nạp tiền vào tài khoản";
                transactionRequest.money = IZINumber.parseInt(depositAmount);
                transactionRequest.content = "Nạp tiền vào tài khoản Haqua";
                transactionRequest.transactionImage = models.map((e) => e.files!.first.toString()).toList().first;
                transactionProvider.add(
                  data: transactionRequest,
                  onSuccess: (models) {
                    EasyLoading.dismiss();
                    IZIToast().successfully(message: 'Giao dịch thành đã hoàn tất!');
                    Get.back(result: true);
                  },
                  onError: (onError) {
                    print(onError);
                  },
                );
              },
              onError: (onError) {
                print(onError);
              },
            );
          }
        }
      },
    );
  }

  ///
  /// confirmUrlFilesBeforeCreateQuestion
  ///
  Future<void> confirmUrlFilesBeforeCreateQuestion() async {
    isEnableButton = false;
    update();
    EasyLoading.show(status: 'please_waiting'.tr);

    if (!IZIValidate.nullOrEmpty(questionRequest.attachImages) && !IZIValidate.nullOrEmpty(questionRequest.attachFiles)) {
      final UploadFilesRequest uploadImagesRequest = UploadFilesRequest();
      uploadImagesRequest.files = questionRequest.attachImages;
      uploadFilesProvider.confirmUploadFiles(
        data: uploadImagesRequest,
        onSuccess: (values) {
          questionRequest.attachImages!.clear();
          for (var i = 0; i < values.length; i++) {
            questionRequest.attachImages!.add(values[i].files!.first.toString());
          }

          final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
          uploadFilesRequest.files = questionRequest.attachFiles;
          uploadFilesProvider.confirmUploadFiles(
            data: uploadFilesRequest,
            onSuccess: (values) {
              questionRequest.attachFiles!.clear();
              for (var i = 0; i < values.length; i++) {
                questionRequest.attachFiles!.add(values[i].files!.first.toString());
              }

              addQuestion();
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
    } else if (!IZIValidate.nullOrEmpty(questionRequest.attachImages) && IZIValidate.nullOrEmpty(questionRequest.attachFiles)) {
      final UploadFilesRequest uploadImagesRequest = UploadFilesRequest();
      uploadImagesRequest.files = questionRequest.attachImages;
      uploadFilesProvider.confirmUploadFiles(
        data: uploadImagesRequest,
        onSuccess: (values) {
          questionRequest.attachImages!.clear();
          for (var i = 0; i < values.length; i++) {
            questionRequest.attachImages!.add(values[i].files!.first.toString());
          }

          addQuestion();
        },
        onError: (error) {
          print(error);
        },
      );
    } else if (IZIValidate.nullOrEmpty(questionRequest.attachImages) && !IZIValidate.nullOrEmpty(questionRequest.attachFiles)) {
      final UploadFilesRequest uploadFilesRequest = UploadFilesRequest();
      uploadFilesRequest.files = questionRequest.attachFiles;
      uploadFilesProvider.confirmUploadFiles(
        data: uploadFilesRequest,
        onSuccess: (values) {
          questionRequest.attachFiles!.clear();
          for (var i = 0; i < values.length; i++) {
            questionRequest.attachFiles!.add(values[i].files!.first.toString());
          }

          addQuestion();
        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      addQuestion();
    }
  }

  ///
  /// addQuestion
  ///
  void addQuestion() {
    questionProvider.add(
      data: questionRequest,
      onSuccess: (model) {
        addTransactionPaymentQuestion();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// addTransactionPaymentQuestion
  ///
  void addTransactionPaymentQuestion() {
    final UploadFilesRequest uploadImagesRequest = UploadFilesRequest();
    uploadImagesRequest.files = [imageTransaction];
    uploadFilesProvider.confirmUploadFiles(
      data: uploadImagesRequest,
      onSuccess: (values) {
        imageTransaction = null;
        for (var i = 0; i < values.length; i++) {
          imageTransaction = values[i].files!.first.toString();
        }
        final TransactionRequest transactionRequest = TransactionRequest();
        transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
        transactionRequest.methodTransaction = TRANSFERS;
        transactionRequest.typeTransaction = WITHDRAW;
        transactionRequest.statusTransaction = WAITING_TRANSACTION;
        transactionRequest.title = "Thanh toán chi phí tạo câu hỏi";
        transactionRequest.money = questionRequest.moneyTo;
        transactionRequest.content = "Thanh toán chi phí tạo câu hỏi.";
        transactionProvider.add(
          data: transactionRequest,
          onSuccess: (models) {
            final TransactionRequest transactionRequest = TransactionRequest();
            transactionRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
            transactionRequest.methodTransaction = TRANSFERS;
            transactionRequest.typeTransaction = RECHARGE;
            transactionRequest.statusTransaction = WAITING_TRANSACTION;
            transactionRequest.title = "Nạp tiền vào tài khoản";
            transactionRequest.content = "Nạp tiền vào tài khoản Haqua";
            transactionRequest.money = IZINumber.parseInt(depositAmount);
            transactionRequest.transactionImage = imageTransaction;
            transactionProvider.add(
              data: transactionRequest,
              onSuccess: (models) {
                isEnableButton = true;
                update();
                EasyLoading.dismiss();
                IZIToast().successfully(message: 'Giao dịch thành đã hoàn tất!');
                Get.find<HomeController>().getCountNotice();
                Get.offAllNamed(HomeRoutes.DASHBOARD, predicate: ModalRoute.withName(HomeRoutes.DASHBOARD));
              },
              onError: (onError) {
                print(onError);
              },
            );
          },
          onError: (onError) {
            print(onError);
          },
        );
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///Copy
  ///
  void onBtnCopy({required String content}) {
    Clipboard.setData(ClipboardData(text: content));
    IZIToast().successfully(message: 'copy_successful'.tr);
  }

  ///
  /// pickImages
  ///
  Future pickImage() async {
    try {
      final images = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (images == null) return;
      EasyLoading.show(status: 'please_waiting'.tr);
      fileTranslation = File(images.path);
      update();
      final List<File> files = [File(images.path)];
      uploadFilesProvider.uploadFilesTemp(
        files: files,
        onSuccess: (value) {
          imageTransaction = value.files!.map<String>((e) => e.toString()).toList().first;
          EasyLoading.dismiss();
          update();
        },
        onError: (e) {
          EasyLoading.dismiss();
          IZIToast().error(message: e.toString());
        },
      );
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIToast().error(message: 'allow_system'.tr);
      AppSettings.openAppSettings();
    }
  }

  ///
  /// genIsEnableButton
  ///
  bool genIsEnableButton() {
    if (!IZIValidate.nullOrEmpty(fileTranslation)) {
      return true;
    }
    return false;
  }

  ///
  ///onBtnOpenLink
  ///
  Future<void> onBtnOpenLink() async {
    String url = settingResponse.moMo.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
