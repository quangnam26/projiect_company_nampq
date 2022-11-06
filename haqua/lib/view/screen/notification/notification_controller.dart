import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/notification/notification_request.dart';
import 'package:template/data/model/notification/notification_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/routes/route_path/%20transaction_details_routers.dart';
import 'package:template/routes/route_path/detail_question_routers.dart';
import 'package:template/routes/route_path/help_wating_list_routers.dart';
import 'package:template/routes/route_path/quotation_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/images_path.dart';

import '../../../base_widget/izi_dialog.dart';
import '../../../di_container.dart';

class NotificationController extends GetxController {
  /// Declare API.
  final NotificationProvider notificationProvider = GetIt.I.get<NotificationProvider>();
  RxList<NotificationResponse> notificationResponseList = <NotificationResponse>[].obs;
  RefreshController refreshController = RefreshController();

  /// Declare Data.
  bool isLoading = true;
  int page = 1;
  int limitPage = 10;

  @override
  void onInit() {
    super.onInit();

    /// Call API get data notifications.
    getDataNotifications(isRefresh: true);
    refreshController = RefreshController();
  }

  @override
  void dispose() {
    notificationResponseList.close();
    super.dispose();
  }

  ///
  /// Call API get data notifications.
  ///
  void getDataNotifications({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      notificationResponseList.clear();
    } else {
      page++;
    }

    notificationProvider.paginate(
      page: page,
      limit: limitPage,
      filter: "&idUsers=${sl<SharedPreferenceHelper>().getIdUser}",
      onSuccess: (models) {
        if (models.isEmpty) {
          refreshController.loadNoData();
          Future.delayed(
            const Duration(milliseconds: 1000),
            () {
              refreshController.refreshCompleted();
            },
          );
        } else {
          if (isRefresh) {
            /// Check is read notices not yet.
            for (int i = 0; i < models.length; i++) {
              /// If readId == null then set isRead = false.
              if (IZIValidate.nullOrEmpty(models[i].readId)) {
                models[i].isRead = false;
                notificationResponseList.add(models[i]);
              }

              /// If readId have my id then set isRead = true.
              else if (models[i].readId!.any((e) => e.toString() == sl<SharedPreferenceHelper>().getIdUser) == true) {
                models[i].isRead = true;
                notificationResponseList.add(models[i]);
              }

              /// Else set isRead = false.
              else {
                models[i].isRead = false;
                notificationResponseList.add(models[i]);
              }
            }
            refreshController.refreshCompleted();
          } else {
            for (int i = 0; i < models.length; i++) {
              /// Check is read notices not yet when load more data.
              if (IZIValidate.nullOrEmpty(models[i].readId)) {
                models[i].isRead = false;
                notificationResponseList.add(models[i]);
              }

              /// If readId have my id then set isRead = true when load more.
              else if (models[i].readId!.any((e) => e.toString() == sl<SharedPreferenceHelper>().getIdUser) == true) {
                models[i].isRead = true;
                notificationResponseList.add(models[i]);
              }

              /// Else set isRead = false when load more.
              else {
                models[i].isRead = false;
                notificationResponseList.add(models[i]);
              }
            }
            refreshController.loadComplete();
          }
        }

        /// Just [update] first load Notification page].
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
  /// Generate value local.
  ///
  String genValueLocale() {
    if (sl<SharedPreferenceHelper>().getLanguage == 'en') {
      return sl<SharedPreferenceHelper>().getLanguage;
    }
    return 'vi';
  }

  ///
  /// Generate Avatar Notices.
  ///
  String genAvatarNotice({required String typeNotification}) {
    if (typeNotification == SHARING_VIDEO) {
      return ImagesPath.logo_notice_share_video;
    }
    if (typeNotification == TRANSACTION) {
      return ImagesPath.logo_notice_transaction;
    }

    return ImagesPath.logo_notice_question;
  }

  ///
  /// On Refresh.
  ///
  Future<void> onRefreshData() async {
    refreshController.resetNoData();

    getDataNotifications(isRefresh: true);
  }

  ///
  /// On loading.
  ///
  Future<void> onLoadingData() async {
    getDataNotifications(isRefresh: false);
  }

  ///
  /// Show dialog read all notices.
  ///
  void showReadAllNoticesDialog() {
    IZIDialog.showDialog(
      lable: "read_notices_1".tr,
      confirmLabel: "dong_y".tr,
      cancelLabel: "quay_lai".tr,
      description: "read_notices_2".tr,
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        Get.back();
        notificationResponseList.map((element) => element.isRead = true).toList();
        update();

        /// Call API read all notices.
        notificationProvider.readALlNotices(
          onSuccess: (models) {},
          onError: (error) {
            print(error);
          },
        );
      },
    );
  }

  ///
  /// Read Notices.
  ///
  void readNotice({required String idNotification}) {
    final NotificationRequest notificationRequest = NotificationRequest();
    notificationRequest.idUser = sl<SharedPreferenceHelper>().getIdUser;
    notificationProvider.readNotice(
      id: idNotification,
      data: notificationRequest,
      onSuccess: (val) {},
      onError: (error) {
        {
          print(error);
        }
      },
    );
  }

  ///
  /// Go to Details notices.
  ///
  void goToDetailsNotice({required String typeQuestion, required int index}) {
    notificationResponseList[index].isRead = true;
    update();
    switch (typeQuestion) {

      /// If type notice is QUESTION_ASK then go to [Help waiting list page].
      case QUESTION_ASK:
        {
          readNotice(idNotification: notificationResponseList[index].id.toString());
          Get.toNamed(HelpWatingListRoutes.HELP_WATING_LIST, arguments: notificationResponseList[index].idEntity.toString());
          break;
        }

      /// If type notice is QUESTION_ANSWER then go to [Detail question page].
      case QUESTION_ANSWER:
        {
          readNotice(idNotification: notificationResponseList[index].id.toString());
          Get.toNamed(DetailQuestionRoutes.DETAIL_QUESTION, arguments: notificationResponseList[index].idEntity.toString());
          break;
        }

      /// If type notice is TRANSACTION then go to [Transaction detail page].
      case TRANSACTION:
        {
          readNotice(idNotification: notificationResponseList[index].id.toString());
          Get.toNamed(TransactionDetailsRouters.TRANSACTIONDETAILS, arguments: notificationResponseList[index].idEntity.toString());
          break;
        }

      /// If type notice is CUSTOMER_ANSWER then go to [TODO page].
      case CUSTOMER_ANSWER:
        {
          //TODO: User Answer
          readNotice(idNotification: notificationResponseList[index].id.toString());
          break;
        }

      /// If type notice is SHARING_VIDEO then go to [Detail quotation page].
      case SHARING_VIDEO:
        {
          //TODO: Share Video
          readNotice(idNotification: notificationResponseList[index].id.toString());
          Get.toNamed(QuotationRoutes.DETAILQUOTATIONITEM, arguments: notificationResponseList[index].idEntity.toString());
          break;
        }
      case OPTION:
        {
          //TODO: Quan điểm
          readNotice(idNotification: notificationResponseList[index].id.toString());
          break;
        }
      case SURVEY:
        {
          //TODO: Khảo sát
          readNotice(idNotification: notificationResponseList[index].id.toString());
          break;
        }
      case DATING:
        {
          //TODO: Hẹn hò
          readNotice(idNotification: notificationResponseList[index].id.toString());
          break;
        }
    }
  }
}
