import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/routes/route_path/account_routers.dart';
import '../../../../base_widget/izi_dialog.dart';
import '../../../../data/model/certificate/certificate_response.dart';
import '../../../../data/model/history_quiz/history_quiz_response.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../provider/certificate_provider.dart';
import '../../../../provider/history_quiz_provider.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class DetailAbilitiesController extends GetxController {
  ///
  /// Declare API.
  final CertificateProvider certificateProvider = GetIt.I.get<CertificateProvider>();
  final HistoryQuizProvider historyQuizProvider = GetIt.I.get<HistoryQuizProvider>();
  Rx<CertificateResponse> certificateResponse = CertificateResponse().obs;
  Rx<HistoryQuizResponse> historyResponses = HistoryQuizResponse().obs;

  /// Declare Data.
  bool isLoading = true;
  String? idCertificate;
  RxString fullNameUser = ''.obs;

  @override
  void onInit() {
    ///
    /// Get id of the certificate.
    getIdOfCertificate();
    super.onInit();
  }

  @override
  void onClose() {
    fullNameUser.close();
    historyResponses.close();
    certificateResponse.close();
    super.onClose();
  }

  ///
  /// Get id of the certificate.
  ///
  void getIdOfCertificate() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idCertificate = Get.arguments.toString();
    }

    /// Call API get data certificate.
    getDataCertificate();
  }

  ///
  /// Call API get data certificate.
  ///
  void getDataCertificate() {
    certificateProvider.find(
      id: idCertificate.toString(),
      onSuccess: (model) {
        certificateResponse.value = model;

        /// Call API get data history quiz.
        getDataHistoryQuiz();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data history quiz.
  ///
  void getDataHistoryQuiz() {
    historyQuizProvider.paginate(
      page: 1,
      limit: 1,
      filter: '&idUser=${sl<SharedPreferenceHelper>().getIdUser}&idCertificate=$idCertificate&populate=idUser',
      onSuccess: (models) {
        if (models.isNotEmpty) {
          historyResponses.value = models.first;
          fullNameUser.value = historyResponses.value.idUser!.fullName.toString();
        }

        /// Just [update] first load [Detail Abilities page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Back to before screen.
  ///
  void getBack() {
    Get.back();
  }

  ///
  /// Show dialog start contest.
  ///
  void showStartContest() {
    IZIDialog.showDialog(
      lable: "Bắt đầu thi",
      confirmLabel: "dong_y".tr,
      cancelLabel: "quay_lai".tr,
      description: "Bạn có đồng ý bắt đầu cuộc thi",
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();
        Get.toNamed('${AccountRouter.QUIZZ}?timeOut=${certificateResponse.value.timeOut}', arguments: idCertificate.toString())!.then((value) {
          if (!IZIValidate.nullOrEmpty(value)) {
            historyResponses.value = value as HistoryQuizResponse;
            update();
          }
        });
      },
    );
  }
}
