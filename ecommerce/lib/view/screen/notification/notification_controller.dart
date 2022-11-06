import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/cart/cart_response.dart';
import 'package:template/data/model/notification/notification_reponse.dart';
import 'package:template/provider/cart_provider.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/routes/route_path/authroutes.dart';
import 'package:template/routes/route_path/news%20routes.dart';
import 'package:template/routes/route_path/order_router.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import '../../../data/model/notification/notification_request.dart';
import '../../../di_container.dart';
import '../../../routes/route_path/detail_page_router.dart';
import '../../../routes/route_path/payment_methods_routes.dart';
import '../../../utils/images_path.dart';
import '../dash_board/dash_board_controller.dart';

class NotificationController extends GetxController {
  // khai bao api
  final NotificationProvider notificationProvider =
      GetIt.I.get<NotificationProvider>();
  final CartProvider cartProvider = GetIt.I.get<CartProvider>();
  NotificationResponse notificationResponse = NotificationResponse();
  NotificationRequest notificationRequest = NotificationRequest();
  RefreshController refreshController = RefreshController();

//List
  List<NotificationResponse> listNotification = [];
  List<CartResponse> listCartResponse = [];

  //vailable
  int page = 1;
  int limitPage = 10;
  int select = 0;
  String choose = '';
  bool isShowReadAllNotice = false;
  String? idUser = sl<SharedPreferenceHelper>().getProfile;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getDataNotification(isRefresh: true);
  }

  @override
  void onClose() {
    refreshController.dispose();
    // TODO: implement onClose
    super.onClose();
  }

  ///
  ///onRefresh
  ///
  void onRefreshData() {
    refreshController.resetNoData();
    _getDataNotification(isRefresh: true);
  }

  ///
  ///onLoading
  ///
  void onLoadingData() {
    _getDataNotification(isRefresh: false);
  }

  ///
  ///Get Data Notification get dữ liệu notifi
  ///

  void _getDataNotification({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      listNotification.clear();
    } else {
      page++;
    }
    notificationProvider.paginate(
      page: page,
      limit: 10,
      filter: "&idUsers=${sl<SharedPreferenceHelper>().getProfile}",
      // '&populate=reads,idUsers',
      onSuccess: (model) {
        // listNotification = model;
        listNotification.addAll(model);
        if (isRefresh) {
          Future.delayed(const Duration(milliseconds: 300), () {
            refreshController.resetNoData(); // data đã làm mới lại
            refreshController.refreshCompleted(); // data đã hoàn thành
            // data đã hoàn thành
            // làm mới dữ liệu
          });
        } else {
          refreshController.loadNoData();
          refreshController.loadComplete();
          // đã load thanh công
        }
        print("model1 $model");
        update();
      },
      onError: (onError) {
        Get.find<DashBoardController>().checkLogin();
      },
    );
  }

  ///
  ///onTap(kích chuyển sang màn hình khác)
  ///
  void onTap(int index, String typeQuestion) {
    select = index;
    choose = listNotification[index].id ?? "";
    // gotoDetailNotification(typeQuestion: typeQuestion, index: index);
    update();
  }

  ///
  ///On Check IsRead.
  ///
  bool onCheckIsRead(List<String> idUsers) {
    bool isRead = false;

    if (idUsers.isNotEmpty) {
      for (final item in idUsers) {
        if (item.toString() == idUser.toString()) {
          isRead = true;
          break;
        }
      }
    }

    return isRead;
  }

  ///
  ///onClickNotification
  ///
  void onClickNotification(NotificationResponse item) {
    // EasyLoading.show(status: 'loading...');
    notificationProvider.markAsRead(
      id: item.id!,
      idUserRead: idUser ?? "",
      // sl<SharedPreferenceHelper>().getProfile,
      onSuccess: (data) {
        if (item.typeNotification == 'ORDER') {
          Get.toNamed(OrderRoutes.ORDER, arguments: data.idEntity);
        } else if (item.typeNotification == "CART") {
          Get.toNamed(CartRoutes.CART, arguments: data.idEntity);
        } else if (item.typeNotification == "VOUCHER") {
          Get.toNamed(CartRoutes.CHOOSE_VOUCHER, arguments: data.idEntity);
        } else if (item.typeNotification == "PRODUCT") {
          Get.toNamed(DetailPageRoutes.DETAIL_PAGE, arguments: data.idEntity);
        } else if (item.typeNotification == "NEWS") {
          Get.toNamed(NewsRouters.NEWS, arguments: data.idEntity);
        } else if (item.typeNotification == "PAYMENT") {
          Get.toNamed(PaymentmethodsRoutes.PAYMENT_METHODS, arguments: data.idEntity);
        }
      },
      onError: (error) => {EasyLoading.dismiss()},
    );
  }

  ///
  /// genAvatarNotice
  ///
  String genAvatarNotice({required String typeNotification}) {
    if (typeNotification == ORDER ||
        typeNotification == CART ||
        typeNotification == PRODUCT ||
        typeNotification == PAYMENT ||
        typeNotification == NEWS) {
      return ImagesPath.facebook_icon1;
    }
    if (typeNotification == VOUCHER) {
      return ImagesPath.google_icon1;
    } else {
      return ImagesPath.facebook_icon1;
    }
  }
}
