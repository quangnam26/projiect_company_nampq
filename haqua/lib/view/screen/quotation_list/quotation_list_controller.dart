import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/quotation_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

class QuotationListController extends GetxController {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  RxList<QuestionResponse> questionResponseList = <QuestionResponse>[].obs;

  /// Declare Data.
  RxInt currentIndexTabBar = 0.obs;
  List<String> tabBarStringList = [
    "All".tr,
    "đang_cho".tr,
    "selected_answer_list".tr,
    "refuse".tr,
    "Complete".tr,
  ];

  bool isLoading = true;
  int page = 1;
  int limitPage = 10;
  RefreshController refreshController = RefreshController();
  AutoScrollController? autoScrollController;

  @override
  void onInit() {
    super.onInit();
    autoScrollController = AutoScrollController();
    autoScrollController!.scrollToIndex(currentIndexTabBar.value, preferPosition: AutoScrollPosition.middle);
    getDataQuotedList(isRefresh: true);
  }

  @override
  void dispose() {
    questionResponseList.close();
    currentIndexTabBar.close();
    refreshController.dispose();
    autoScrollController!.dispose();
    super.dispose();
  }

  ///
  ///selectIndexTabBar=
  ///
  void selectIndexTabBar(int index) {
    currentIndexTabBar.value = index;
    autoScrollController!.scrollToIndex(currentIndexTabBar.value, preferPosition: AutoScrollPosition.middle);
    getDataQuotedList(isRefresh: true);
  }

  ///
  /// getDataQuotedList
  ///
  void getDataQuotedList({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      questionResponseList.clear();
    } else {
      page++;
    }

    String filter = '';
    if (currentIndexTabBar.value == 0) {
      filter = "&answerList.idUser=${sl<SharedPreferenceHelper>().getIdUser}&populate=answerList.idUser";
    } else if (currentIndexTabBar.value == 1) {
      filter = "&answererStatus=$WAITING&idAnswerer=${sl<SharedPreferenceHelper>().getIdUser}";
    } else if (currentIndexTabBar.value == 2) {
      filter = "&answererStatus=$SELECTED&idAnswerer=${sl<SharedPreferenceHelper>().getIdUser}&statusQuestion=$SELECTED_PERSON,$CALLED";
    } else if (currentIndexTabBar.value == 3) {
      filter = "&answererStatus=$FAILURE&idAnswerer=${sl<SharedPreferenceHelper>().getIdUser}";
    } else if (currentIndexTabBar.value == 4) {
      filter = "&answererStatus=$SELECTED&idAnswerer=${sl<SharedPreferenceHelper>().getIdUser}&statusQuestion=$COMPLETED";
    }
    questionProvider.paginate(
      page: page,
      limit: limitPage,
      filter: filter,
      onSuccess: (models) {
        if (models.isEmpty) {
          refreshController.loadNoData();
          Future.delayed(
            const Duration(milliseconds: 2000),
            () {
              refreshController.refreshCompleted();
            },
          );
        } else {
          if (isRefresh) {
            questionResponseList.value = models;
            refreshController.refreshCompleted();
          } else {
            questionResponseList.value = questionResponseList.toList() + models;
            refreshController.loadComplete();
          }
        }

        /// Just [update] first load [Quotation list page].
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
  /// On refresh data.
  ///
  Future<void> onRefreshData() async {
    refreshController.resetNoData();

    getDataQuotedList(isRefresh: true);
  }

  ///
  /// On loading more data.
  ///
  Future<void> onLoadingData() async {
    getDataQuotedList(isRefresh: false);
  }

  ///
  /// Go to [Detail question quoted page].
  ///
  void goToDetailQuestionQuoted({required String idQuestion}) {
    Get.toNamed(QuotationRoutes.DETAILQUOTATIONITEM, arguments: idQuestion)!.then((value) {
      onRefreshData();
    });
  }

  ///
  /// Generate status selected.
  ///
  Widget genStatusSelected({required QuestionResponse questionResponse}) {
    if (questionResponse.answerList![questionResponse.answerList!.indexWhere((e) => e.idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser)].statusSelect == FAILURE && questionResponse.statusQuestion == COMPLETED) {
      return Text(
        'Complete'.tr,
        style: TextStyle(
          color: ColorResources.CALL_VIDEO,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (questionResponse.answerList![questionResponse.answerList!.indexWhere((e) => e.idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser)].statusSelect == FAILURE) {
      return Text(
        'refuse'.tr,
        style: TextStyle(
          color: ColorResources.RED,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (questionResponse.answerList![questionResponse.answerList!.indexWhere((e) => e.idUser!.id.toString() == sl<SharedPreferenceHelper>().getIdUser)].statusSelect == SELECTED) {
      return Text(
        'selected_answer_list'.tr,
        style: TextStyle(
          color: ColorResources.LABEL_ORDER_DA_GIAO,
          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Text(
      'đang_cho'.tr,
      style: TextStyle(
        color: ColorResources.PRIMARY_APP,
        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
