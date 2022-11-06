import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/detail_profile_people_routers.dart';
import 'package:template/routes/route_path/detail_question_routers.dart';
import 'package:template/routes/route_path/notification_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../../../data/datasource/remote/dio/izi_socket.dart';
import '../../../routes/route_path/help_wating_list_routers.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final NotificationProvider notificationProvider = GetIt.I.get<NotificationProvider>();
  final IZISocket iziSocket = GetIt.I.get<IZISocket>();
  RxList<QuestionResponse> questionResponseList = <QuestionResponse>[].obs;
  Rx<QuestionResponse> questionResponseShowHome = QuestionResponse().obs;

  /// Declare Data.
  List<String> titleTabBar = ["question".tr, "my_question".tr];
  bool isLoading = true;
  RxBool isLoadingQuestion = false.obs;
  RxBool isLoadingMore = false.obs;
  bool isLogin = false;
  RxInt currentIndex = 0.obs;
  int page = 1;
  int limitPage = 6;
  RxInt countNotice = 0.obs;
  RxString fullNameUserQuoteQuestion = ''.obs;
  final Controller controllerTikTok = Controller();

  @override
  void onInit() {
    super.onInit();

    /// Get value isLogin for check logged not yet.
    isLogin = sl<SharedPreferenceHelper>().getLogin;

    /// Create TikTok controller and listen controller.
    controllerTikTok.addListener((event) {
      ///
      /// Handel call back event.
      _handleCallbackEvent(event.direction, event.success);
    });

    /// Start listen event socket.
    startSocket();
  }

  @override
  void dispose() {
    isLoadingMore.close();
    isLoadingMore.close();
    currentIndex.close();
    countNotice.close();
    fullNameUserQuoteQuestion.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ///
      /// Start listen event socket.
      startSocket();
    }
  }

  ///
  /// Start listen event socket.
  ///
  void startSocket() {
    if (!iziSocket.socket.hasListeners('notification_socket')) {
      iziSocket.socket.on('notification_socket', (data) {
        ///
        /// List notification event socket.
        listNotificationSocket(dataSocket: data);
      });
    }

    if (!iziSocket.socket.hasListeners('proposal_socket')) {
      iziSocket.socket.on('proposal_socket', (data) {
        ///
        /// List proposal event socket.
        listProposalSocket(dataSocket: data);
      });
    }

    /// Call API get data question.
    getDataQuestion(isRefresh: true);
  }

  ///
  /// List notifications event socket.
  ///
  void listNotificationSocket({required dynamic dataSocket}) {
    if (!IZIValidate.nullOrEmpty(dataSocket)) {
      ///
      /// If type == All then call API count Notifications else call get API count notifications yourself.
      if (dataSocket["type"] == NOTICE_TO_ALL_USERS) {
        //
        // Call API count notifications.
        getCountNoticeSocket();
      } else if (dataSocket["type"] == NOTICE_TO_CHANNEL) {
        final List<dynamic> idUserList = dataSocket["idUsers"] as List<dynamic>;
        if (idUserList.map<String>((e) => e.toString()).toList().contains(sl<SharedPreferenceHelper>().getIdUser) == true) {
          ///
          /// Call API count notifications.
          getCountNoticeSocket();
        }
      }
    }
  }

  ///
  /// List proposal event socket.
  ///
  void listProposalSocket({required dynamic dataSocket}) {
    if (!IZIValidate.nullOrEmpty(dataSocket)) {
      ///
      /// Check null my question then update name quoted.
      if (!IZIValidate.nullOrEmpty(questionResponseShowHome.value.id)) {
        if (dataSocket['idAuthorQuestion'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['idQuestion'].toString() == questionResponseShowHome.value.id.toString()) {
          fullNameUserQuoteQuestion.value = dataSocket['fullNameQuote'].toString();
        }
      }
    }
  }

  ///
  /// Call API get data question.
  ///
  void getDataQuestion({required bool isRefresh}) {
    String filter = '';
    if (currentIndex.value == 0) {
      filter = "&statusPayment=$DEPOSITED&populate=idUser,idSubSpecialize,idUser.idProvince&idUserSubSpecialize=${sl<SharedPreferenceHelper>().getIdUser}";
    } else {
      filter = "&idUser=${sl<SharedPreferenceHelper>().getIdUser}&populate=idUser,idSubSpecialize,idUser.idProvince";
    }

    if (isRefresh) {
      page = 1;
      questionResponseList.clear();
    } else {
      page++;
    }
    questionProvider.paginate(
      page: page,
      limit: limitPage,
      filter: filter,
      onSuccess: (models) {
        if (isRefresh) {
          questionResponseList.value = models;
        } else {
          questionResponseList.value = questionResponseList.toList() + models;
        }

        /// If logger then take action below.
        if (isLogin == false) {
          ///
          /// Just [update] first load home page.
          if (isLoading) {
            isLoading = false;
            update();
          }
          isLoadingQuestion.value = false;
          isLoadingMore.value = false;
        } else {
          ///
          /// Call API get count notice.
          getCountNotice();
        }
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get count notices.
  ///
  void getCountNotice() {
    notificationProvider.countNotice(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (val) {
        countNotice.value = val.length;

        /// Call API get data my question.
        getQuestionShowHome();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data count notices from notification event socket.
  ///
  void getCountNoticeSocket() {
    notificationProvider.countNotice(
      id: sl<SharedPreferenceHelper>().getIdUser,
      onSuccess: (val) {
        countNotice.value = val.length;
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data my question.
  ///
  void getQuestionShowHome() {
    questionProvider.paginate(
      page: 1,
      limit: 1,
      filter: '&idUser=${sl<SharedPreferenceHelper>().getIdUser}&statusQuestion=$CONNECTING,$SELECTED_PERSON,$CALLED',
      onSuccess: (models) {
        if (models.isNotEmpty) {
          questionResponseShowHome.value = models.first;
        } else {
          questionResponseShowHome.value = QuestionResponse();
        }

        /// Just [update] first load [Home page].
        if (isLoading) {
          isLoading = false;
          update();
        }
        isLoadingQuestion.value = false;
        isLoadingMore.value = false;
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// On change TabBar.
  ///
  void onChangeTabBar({required int index}) {
    if (isLogin == false && index == 1) {
      Get.find<DashBoardController>().showDialogLogin();
    } else {
      currentIndex.value = index;

      isLoadingQuestion.value = true;
      getDataQuestion(isRefresh: true);
    }
  }

  ///
  /// On go to [Detail question page] or [Helping wating list page].
  ///
  void onGoToDetailQuestion({
    required String idQuestion,
    required String idUser,
  }) {
    ///
    /// If this's my question then go to [Helping wating list page] else go to [Detail question page].
    if (idUser == sl<SharedPreferenceHelper>().getIdUser) {
      Get.toNamed(HelpWatingListRoutes.HELP_WATING_LIST, arguments: idQuestion)!.then((value) {
        if (isLogin) {
          getCountNotice();
        }
      });
    } else {
      Get.toNamed(DetailQuestionRoutes.DETAIL_QUESTION, arguments: idQuestion)!.then((value) {
        if (isLogin) {
          getCountNotice();
        }
      });
    }
  }

  ///
  /// On go to [Helping wating list page].
  ///
  void onGoToHelpWatingListPage({
    required String idQuestion,
  }) {
    if (isLogin == false) {
      Get.find<DashBoardController>().showDialogLogin();
    } else {
      Get.toNamed(HelpWatingListRoutes.HELP_WATING_LIST, arguments: idQuestion)!.then((value) {
        if (isLogin == true) {
          getCountNotice();
        }
      });
    }
  }

  ///
  /// On go to [View profile user create question page].
  ///
  void onGoToViewProfileUserCreateQues({required String idUser}) {
    Get.toNamed(DetailProfilePeopleListRoutes.VIEW_PROFILE_USER_CREATED_QUES, arguments: idUser)!.then((value) {
      if (isLogin == true) {
        getCountNotice();
      }
    });
  }

  ///
  /// Handle call back event when scroll.
  ///
  void _handleCallbackEvent(ScrollDirection direction, ScrollSuccess success) {
    ///
    /// If when to scroll to haft length data in a call API before then call API again for load more data.
    if (questionResponseList.length - controllerTikTok.getScrollPosition() == 4) {
      getDataQuestion(isRefresh: false);
    } else if (ScrollDirection.BACKWARDS == direction && ScrollSuccess.FAILED_END_OF_LIST == success) {
      isLoadingQuestion.value = true;
      getDataQuestion(isRefresh: true);
    } else if (ScrollDirection.FORWARD == direction && ScrollSuccess.FAILED_END_OF_LIST == success) {
      isLoadingMore.value = true;
      getDataQuestion(isRefresh: false);
    }
  }

  ///
  /// Go to [Notifications page].
  ///
  void goToNotificationPage() {
    if (isLogin == false) {
      Get.find<DashBoardController>().showDialogLogin();
    } else {
      Get.toNamed(NotificationRouters.NOTIFICATION)!.then((value) {
        getCountNotice();
      });
    }
  }
}
