import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/reviews/reviews_response.dart';
import 'package:template/provider/reviews_provider.dart';
import '../../../../data/model/history_quiz/history_quiz_response.dart';
import '../../../../data/model/user/user_response.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_number.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../provider/history_quiz_provider.dart';
import '../../../../provider/settings_provider.dart';
import '../../../../provider/user_provider.dart';
import '../../../../routes/route_path/account_routers.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class BriefCaseController extends GetxController {
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ReviewsProvider reviewsProvider = GetIt.I.get<ReviewsProvider>();
  final SettingsProvider settingProvider = GetIt.I.get<SettingsProvider>();
  final HistoryQuizProvider historyQuizProvider = GetIt.I.get<HistoryQuizProvider>();
  RxList<ReviewsResponse> reviewsResponseList = <ReviewsResponse>[].obs;
  Rx<UserResponse> userResponse = UserResponse().obs;
  RxList<HistoryQuizResponse> historyQuizResponseList = <HistoryQuizResponse>[].obs;

  /// Declare Data.
  bool isLoading = true;
  RxBool isShowMore = false.obs;
  double quizPercent = 0;

  @override
  void onInit() {
    super.onInit();

    /// Call API get quiz percent .
    getQuizPercent();
  }

  @override
  void dispose() {
    reviewsResponseList.close();
    userResponse.close();
    isShowMore.close();
    historyQuizResponseList.close();
    super.dispose();
  }

  ///
  /// Call API get quiz percent .
  ///
  void getQuizPercent() {
    settingProvider.findSetting(
      onSuccess: (model) {
        if (!IZIValidate.nullOrEmpty(model)) {
          quizPercent = IZINumber.parseDouble(model!.quizPassPercent.toString());
        }

        /// Call API get data info user.
        getInfoUser();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data info user.
  ///
  void getInfoUser() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (models) {
        userResponse.value = models;

        /// Call API get data reviews.
        getDataReviews();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data reviews.
  ///
  void getDataReviews() {
    reviewsProvider.paginate(
      page: 1,
      limit: 2,
      filter: "&idAnswerer=${sl<SharedPreferenceHelper>().getIdUser}&isAgreePay=true&populate=idAnswerer",
      onSuccess: (models) {
        reviewsResponseList.value = models;

        ///  Call API get certificates.
        getCertificates();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get certificates.
  ///
  void getCertificates() {
    historyQuizProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idUser=${sl<SharedPreferenceHelper>().getIdUser}&percent>=$quizPercent&populate=idCertificate',
      onSuccess: (models) {
        if (models.isNotEmpty) {
          historyQuizResponseList.value = models;
        }

        /// Just [update] first load [Briefcase page].
        if (isLoading) {
          isLoading = false;
          update();
        }
      },
      onError: (e) {
        print(e);
      },
    );
  }

  ///
  /// On change show more.
  ///
  void onChangedShowMore() {
    isShowMore.value = !isShowMore.value;
  }

  ///
  /// Go go [Info user page].
  ///
  void goToUpdateFiles() {
    Get.toNamed(AccountRouter.INFORACCOUNT)!.then((value) {
      getInfoUser();
    });
  }

  ///
  /// Generate item count.
  ///
  int genItemCount() {
    if (userResponse.value.experiences!.length <= 5) {
      return userResponse.value.experiences!.length;
    }

    if (isShowMore.value == true) {
      return userResponse.value.experiences!.length;
    }
    if (isShowMore.value == false) {
      return 5;
    }

    return userResponse.value.experiences!.length;
  }
}
