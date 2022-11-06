// ignore_for_file: use_setters_to_change_properties

import 'dart:io';
import 'package:app_settings/app_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rich_text_controller/rich_text_controller.dart';
import 'package:template/data/model/question/question_request.dart';
import 'package:template/data/model/subspecialize/subspecialize_response.dart';
import 'package:template/di_container.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/subspecialize_provider.dart';
import 'package:template/provider/upload_files_provider.dart';
import 'package:template/routes/route_path/create_question_routers.dart';
import 'package:template/routes/route_path/izi_preview_image_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class CreateQuestionController extends GetxController {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final SubSpecializeProvider subSpecializeProvider = GetIt.I.get<SubSpecializeProvider>();
  final UploadFilesProvider uploadFilesProvider = GetIt.I.get<UploadFilesProvider>();
  RxList<SubSpecializeResponse> subSpecializeList = <SubSpecializeResponse>[].obs;
  Rx<SubSpecializeResponse> specializeResponse = SubSpecializeResponse().obs;
  final SpeechToText speech = SpeechToText();

  //Declare Data.
  bool isLoading = true;
  RxBool isFirstValidateTopic = false.obs;
  RxBool isErrorTextContent = false.obs;
  RxBool isErrorTextHashtag = false.obs;
  RxBool isEnabledContentQues = false.obs;
  RxBool isEnabledContentHashTag = false.obs;
  RxBool isEnabledMoneyFrom = false.obs;
  RxBool isEnabledMoneyTo = false.obs;
  RxBool isVoice = false.obs;
  RxBool isHaveChangeTextField = false.obs;
  RxInt valueFreeRadio = 0.obs;
  RxInt valuePaymentRadio = 1.obs;
  RxInt groupValueRadio = 0.obs;
  RxList<String> filesUpload = <String>[].obs;
  RxList<String> imagesUpload = <String>[].obs;
  RxString errorTextMoneyFrom = ''.obs;
  RxString errorTextMoneyTo = ''.obs;
  RxString moneyFromController = ''.obs;
  RxString moneyToController = ''.obs;
  RxList<String> suggestedHashtag = <String>[].obs;
  final GlobalKey keyTopic = GlobalKey();
  final GlobalKey keyButtonTopic = GlobalKey();
  final TextEditingController contentQuestionController = TextEditingController();
  late RichTextController controllerRichText;

  @override
  void onInit() {
    super.onInit();

    /// Initialize Rich Text Controller.
    initRichTextController();

    /// Check permission device.
    checkPermission();
  }

  @override
  void onClose() {
    subSpecializeList.close();
    specializeResponse.close();
    isFirstValidateTopic.close();
    isErrorTextContent.close();
    isErrorTextHashtag.close();
    isEnabledContentQues.close();
    isEnabledContentHashTag.close();
    isEnabledMoneyFrom.close();
    isEnabledMoneyTo.close();
    isVoice.close();
    isHaveChangeTextField.close();
    valueFreeRadio.close();
    valuePaymentRadio.close();
    groupValueRadio.close();
    filesUpload.close();
    imagesUpload.close();
    errorTextMoneyFrom.close();
    errorTextMoneyTo.close();
    moneyFromController.close();
    moneyToController.close();
    suggestedHashtag.close();
    contentQuestionController.dispose();
    controllerRichText.dispose();
    super.onClose();
  }

  ///
  /// Check permission device.
  ///
  Future<void> checkPermission() async {
    final status = await Permission.speech.request();
    if (status == PermissionStatus.granted) {
      initSpeech();
    } else if (status == PermissionStatus.denied) {
      await openAppSettings();
    } else if (status == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  ///
  /// Initialize Rich Text Controller.
  ///
  void initRichTextController() {
    controllerRichText = RichTextController(
      patternMatchMap: {
        RegExp(r"\B#[a-zA-Z0-9]+\b"): TextStyle(
          color: ColorResources.PRIMARY_APP,
          fontSize: IZIDimensions.FONT_SIZE_H6,
          fontWeight: FontWeight.w600,
        ),
      },
      deleteOnBack: true,
      onMatch: (List<String> match) {},
    );

    /// Call API get data sub -specializes.
    getAllDataSubSpecialize();
  }

  ///
  /// Initialize Speech.
  ///
  Future<void> initSpeech() async {
    await speech.initialize();
  }

  ///
  /// Start listen Speech controller.
  ///
  Future<void> startListening() async {
    isVoice.value = true;

    /// Check permission device.
    checkPermission();

    await speech.listen(
      onResult: (val) {
        if (!IZIValidate.nullOrEmpty(val)) {
          contentQuestionController.text = val.recognizedWords;
          contentQuestionController.selection = TextSelection.fromPosition(TextPosition(offset: contentQuestionController.text.length));
          isEnabledContentQues.value = true;
        }
        update();
      },
      localeId: sl<SharedPreferenceHelper>().getLanguage,
    );
  }

  ///
  ///stopListening
  ///
  Future<void> stopListening() async {
    isVoice.value = false;
    update();
    await speech.stop();
  }

  ///
  /// Call API get data sub -specializes.
  ///
  void getAllDataSubSpecialize() {
    subSpecializeProvider.all(
      onSuccess: (models) {
        if (models.isNotEmpty) {
          subSpecializeList.addAll(models);

          /// Just [update] first load [Ask and Answer page].
          if (isLoading) {
            isLoading = false;
            update();
          }
        }
      },
      onError: (e) {
        print("Error question $e");
      },
    );
  }

  ///
  /// On change radio button.
  ///
  void onChangedRadioButton({required int val}) {
    groupValueRadio.value = val;
    if (valueFreeRadio == groupValueRadio) {
      moneyFromController.value = "0";
      moneyToController.value = "0";
    }
  }

  ///
  /// Pick images.
  ///
  Future pickImages() async {
    try {
      final images = await ImagePicker().pickMultiImage();
      if (images == null) return;
      EasyLoading.show(status: 'please_waiting'.tr);

      final List<File> files = images.map((e) => File(e.path)).toList();

      if (files.length > 5) {
        EasyLoading.dismiss();
        IZIToast().error(message: "validate_images".tr);
      } else {
        // load files
        uploadFilesProvider.uploadFilesTemp(
          files: files,
          onSuccess: (value) {
            imagesUpload.addAll(value.files!.map<String>((e) => e.toString()).toList());
            EasyLoading.dismiss();
          },
          onError: (e) {
            EasyLoading.dismiss();
            IZIToast().error(message: e.toString());
          },
        );
      }
    } on PlatformException catch (e) {
      print("Failed to pick file: $e");
      EasyLoading.dismiss();
      IZIToast().error(message: 'allow_system'.tr);
      AppSettings.openAppSettings();
    }
  }

  ///
  /// Pick files.
  ///
  Future pickFiles() async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result == null) return;
      EasyLoading.show(status: 'please_waiting'.tr);

      final List<File> files = result.paths.map((path) => File(path!)).toList();

      // load files
      uploadFilesProvider.uploadFilesTemp(
        files: files,
        onSuccess: (value) {
          filesUpload.addAll(value.files!.map<String>((e) => e.toString()).toList());
          EasyLoading.dismiss();
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
  /// On delete images.
  ///
  void onDeleteImage({required String file, required List<String> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
  }

  ///
  /// On delete images.
  ///
  void onDeleteFiles({required String file, required List<String> files}) {
    files.removeWhere((element) => element.hashCode == file.hashCode);
  }

  ///
  /// On change topic question.
  ///
  void onChangedTopic(SubSpecializeResponse val) {
    specializeResponse.value = val;
  }

  ///
  /// On change content question.
  ///
  void onChangedContentQuestion(String val) {
    if (!IZIValidate.nullOrEmpty(val)) {
      isEnabledContentQues.value = true;
      isErrorTextContent.value = false;
    } else {
      isEnabledContentQues.value = false;
      isErrorTextContent.value = true;
    }
  }

  ///
  /// Set value for hashtag.
  ///
  void setValueHashTag({required String value}) {
    if (isHaveChangeTextField.value == true) {
      final List<String> newValueList = controllerRichText.text.replaceAllMapped(' ', (match) => '').replaceAllMapped(',', (match) => '').replaceAllMapped('.', (match) => '').split('#').toList();
      newValueList.removeLast();
      controllerRichText.text = '';

      for (int i = 0; i < newValueList.length; i++) {
        if (newValueList[i].isNotEmpty) {
          if (i == 0) {
            controllerRichText.text += '#${newValueList[i].toString()}';
          } else {
            controllerRichText.text += '#${newValueList[i].toString()} ';
          }
        }
      }
    }
    if (controllerRichText.text.isNotEmpty) {
      controllerRichText.text = '${controllerRichText.text} $value ';
    } else {
      controllerRichText.text = '$value ';
    }
    controllerRichText.selection = TextSelection.fromPosition(TextPosition(offset: controllerRichText.text.length));
    isEnabledContentHashTag.value = true;
    isErrorTextHashtag.value = false;
    isHaveChangeTextField.value = false;
    suggestedHashtag.clear();
  }

  ///
  /// On change value hashtag.
  ///
  void onChangedHashtag(String val) {
    if (!IZIValidate.nullOrEmpty(val)) {
      Future.delayed(const Duration(seconds: 1), () async {
        if (!IZIValidate.nullOrEmpty(keyButtonTopic.currentContext)) {
          final indexTopic = keyButtonTopic.currentContext!;
          await Scrollable.ensureVisible(
            indexTopic,
            duration: const Duration(milliseconds: 500),
            alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
          );

          FocusManager.instance.primaryFocus?.unfocus();
        }
      });

      isEnabledContentHashTag.value = true;
      isErrorTextHashtag.value = false;
      isHaveChangeTextField.value = true;
      String? valueSearch;

      /// Split and get value last to search.
      final List<String> newValueList = controllerRichText.text.replaceAllMapped(' ', (match) => '').replaceAllMapped(',', (match) => '').replaceAllMapped('.', (match) => '').split('#').toList();

      if (newValueList.last.isNotEmpty) {
        valueSearch = newValueList.last;
      } else {
        valueSearch = val;
      }
      suggestedHashtag.clear();

      /// Loop value search in [DATA_HASHTAG].
      for (final e in DATA_HASHTAG) {
        if (e.toString().toLowerCase().contains(valueSearch.toLowerCase())) {
          if (suggestedHashtag.any((element) => element.toString() == e.toString()) == false) {
            suggestedHashtag.add(e);
          }
        }
      }
    } else {
      isEnabledContentHashTag.value = false;
      isErrorTextHashtag.value = true;
      suggestedHashtag.clear();
    }
  }

  ///
  /// On validate money from.
  ///
  String? onValidateMoneyFrom(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnabledMoneyFrom.value = false;

      return errorTextMoneyFrom.value = "validate_money_1".tr;
    }

    if (IZINumber.parseInt(val.replaceAllMapped('.', (match) => '')) <= 0) {
      isEnabledMoneyFrom.value = false;

      return errorTextMoneyFrom.value = "validate_money_3".tr;
    }

    if (!IZIValidate.nullOrEmpty(moneyToController)) {
      if (IZINumber.parseInt(val.replaceAllMapped('.', (match) => '')) > IZINumber.parseInt(moneyToController.value.replaceAllMapped('.', (match) => ''))) {
        isEnabledMoneyFrom.value = false;

        return errorTextMoneyFrom.value = "validate_money_5".tr;
      }
    }
    isEnabledMoneyFrom.value = true;

    return errorTextMoneyFrom.value = "";
  }

  ///
  /// Set value and position for hashtag.
  ///
  void setHashtag() {
    controllerRichText.text = '${controllerRichText.text}#';
    controllerRichText.selection = TextSelection.fromPosition(TextPosition(offset: controllerRichText.text.length));
    isEnabledContentHashTag.value = true;
    isErrorTextHashtag.value = false;
  }

  ///
  /// On change value money from.
  ///
  void onChangedValueMoneyFrom(String val) {
    moneyFromController.value = val;
  }

  ///
  /// On validate money to.
  ///
  String? onValidateMoneyTo(String val) {
    if (IZIValidate.nullOrEmpty(val)) {
      isEnabledMoneyTo.value = false;

      return errorTextMoneyTo.value = "validate_money_1".tr;
    }

    if (IZINumber.parseInt(val.replaceAllMapped('.', (match) => '')) <= 0) {
      isEnabledMoneyTo.value = false;

      return errorTextMoneyTo.value = "validate_money_2".tr;
    }

    if (!IZIValidate.nullOrEmpty(moneyFromController)) {
      if (IZINumber.parseInt(val.replaceAllMapped('.', (match) => '')) < IZINumber.parseInt(moneyFromController.value.replaceAllMapped('.', (match) => ''))) {
        isEnabledMoneyTo.value = false;

        return errorTextMoneyTo.value = "validate_money_4".tr;
      }
    }
    isEnabledMoneyTo.value = true;

    return errorTextMoneyTo.value = "";
  }

  ///
  /// On change value money to.
  ///
  void onChangedValueMoneyTo(String val) {
    moneyToController.value = val;
  }

  ///
  /// Generate value enable button.
  ///
  bool genValueEnableButton() {
    if (valueFreeRadio.value == groupValueRadio.value) {
      if (isEnabledContentQues.value == true && isEnabledContentHashTag.value == true) {
        return true;
      }
    }

    if (valuePaymentRadio.value == groupValueRadio.value) {
      if (isEnabledContentQues.value == true && isEnabledContentHashTag.value == true && isEnabledMoneyFrom.value == true && isEnabledMoneyTo.value == true) {
        return true;
      }
    }

    return false;
  }

  ///
  /// On go to [Preview image page].
  ///
  void onGoToPreviewImage({required String urlImage}) {
    Get.toNamed(IZIPreviewImageRoutes.IZI_PREVIEW_IMAGE, arguments: urlImage);
  }

  ///
  /// On go to [Ask and Answer page].
  ///
  Future<void> goToAskAndAnswer() async {
    if (IZIValidate.nullOrEmpty(specializeResponse.value.id)) {
      isFirstValidateTopic.value = true;

      final indexTopic = keyTopic.currentContext!;

      await Scrollable.ensureVisible(indexTopic, duration: const Duration(milliseconds: 500));
    } else {
      final QuestionRequest questionRequest = QuestionRequest();
      questionRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser;
      questionRequest.idSubSpecializeRequest = specializeResponse.value.id.toString();
      questionRequest.content = contentQuestionController.text;
      if (!IZIValidate.nullOrEmpty(imagesUpload)) {
        questionRequest.attachImages = imagesUpload;
      }
      if (!IZIValidate.nullOrEmpty(filesUpload)) {
        questionRequest.attachFiles = filesUpload;
      }
      questionRequest.hashTag = controllerRichText.text;

      if (valueFreeRadio == groupValueRadio) {
        questionRequest.moneyFrom = 0;
        questionRequest.moneyTo = 0;
      } else {
        questionRequest.moneyFrom = IZINumber.parseInt(moneyFromController.value.replaceAllMapped('.', (match) => ''));
        questionRequest.moneyTo = IZINumber.parseInt(moneyToController.value.replaceAllMapped('.', (match) => ''));
      }

      Get.toNamed(CreateQuestionRoutes.ASK_AND_ANSWER, arguments: questionRequest);
    }
  }
}
