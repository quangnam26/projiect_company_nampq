import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/question/question_response.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/help_wating_list_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';

import '../../../di_container.dart';

class MyQuestionListController extends GetxController {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();

  /// Declare Data.
  RxList<QuestionResponse> questionResponseList = <QuestionResponse>[].obs;
  RefreshController refreshController = RefreshController();
  bool isLoading = true;
  int page = 1;
  int limitPage = 10;

  @override
  void onInit() {
    super.onInit();

    /// Call API get data my question
    getDatMyQuestionList(isRefresh: true);
  }

  @override
  void dispose() {
    questionResponseList.close();
    super.dispose();
  }

  ///
  /// Call API get data my question
  ///
  void getDatMyQuestionList({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      questionResponseList.clear();
    } else {
      page++;
    }

    questionProvider.paginate(
      page: page,
      limit: limitPage,
      filter: "&idUser=${sl<SharedPreferenceHelper>().getIdUser}&populate=idUser,idSubSpecialize,idUser.idProvince&sort=-updatedAt",
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

        /// Just [update] first load [My question list page].
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

    getDatMyQuestionList(isRefresh: true);
  }

  ///
  /// On loading more data.
  ///
  Future<void> onLoadingData() async {
    getDatMyQuestionList(isRefresh: false);
  }

  ///
  /// Generate status question.
  ///
  Widget genStatusQuestion({required String statusQuestion, required String statusShare}) {
    if (statusQuestion == SELECTED_PERSON) {
      return Text(
        'Selected'.tr,
        style: TextStyle(
          color: ColorResources.RED,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (statusQuestion == CALLED) {
      return Text(
        'call_again'.tr,
        style: TextStyle(
          color: ColorResources.LABEL_ORDER_DA_GIAO,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    if (statusQuestion == COMPLETED && statusShare == NOT_SHARED) {
      return Text(
        'Complete'.tr,
        style: TextStyle(
          color: ColorResources.CIRCLE_COLOR_BG4,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          fontWeight: FontWeight.w600,
        ),
      );
    }
    if (statusQuestion == COMPLETED && statusShare == SHARED) {
      return Text(
        'Shared'.tr,
        style: TextStyle(
          color: ColorResources.PRIMARY_1,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    if (statusQuestion == CANCELED) {
      return Text(
        'Cancelled'.tr,
        style: TextStyle(
          color: ColorResources.RED,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Text(
      'Connecting'.tr,
      style: TextStyle(
        color: ColorResources.PRIMARY_APP,
        fontSize: IZIDimensions.FONT_SIZE_SPAN,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  ///
  /// Go to [Detail question page].
  ///
  void goToDetailQuestion({required String idQuestion}) {
    Get.toNamed(HelpWatingListRoutes.HELP_WATING_LIST, arguments: idQuestion)!.then((value) {
      onRefreshData();
    });
  }
}
