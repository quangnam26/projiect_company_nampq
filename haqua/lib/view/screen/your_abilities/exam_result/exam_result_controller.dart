import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../../data/model/history_quiz/history_quiz_response.dart';
import '../../../../data/model/user/user_response.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../provider/user_provider.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class ExamResultController extends GetxController {
  /// Declare API.
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  UserResponse? userResponse;

  /// Declare Data.
  HistoryQuizResponse? historyQuizResponse;
  bool isLoading = true;

  @override
  void onInit() {
    /// Get arguments from before screen.
    getArgument();
    super.onInit();
  }

  ///
  /// Get arguments from before screen.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      historyQuizResponse = Get.arguments as HistoryQuizResponse;
    }

    /// Call API get data user.
    getDataUser();
  }

  ///
  /// Call API get data user.
  ///
  void getDataUser() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (model) {
        userResponse = model;
        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  
}
