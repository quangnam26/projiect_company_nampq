import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/notification/notification_reponse.dart';
import 'package:template/di_container.dart';
import 'package:template/provider/notification_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/routes/route_path/history_order.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/images_path.dart';

class NotificationController extends GetxController {
  final NotificationProvider notificationProvider =
      GetIt.I.get<NotificationProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  final RefreshController refreshController = RefreshController();

  RxList<NotificationResponse> notificationResponse =
      <NotificationResponse>[].obs;

  List<Map<String, String>> notifyList = [
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
    {
      "title": "Đơn hàng #1003 đã hoàn thành",
      "subTitle":
          "Cảm ơn bạn đã sử dụng dịch vụ D&P Food. Hãy chia sẻ cảm nhận của bạn về đơn hàng để giúp những khách hàng khác có thể tham khảo nhé!",
      "image": ImagesPath.notification,
      "dateTime": "07/07/22  15:30"
    },
  ];

  RxString? idUser = ''.obs;
  int pageMax = 1;
  int limitMax = 10;

  @override
  void onInit() {
    idUser = sl<SharedPreferenceHelper>().getProfile.obs;
    onGetDataNotification(isRefresh: true);
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    onGetDataNotification(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    onGetDataNotification(isRefresh: false);
  }

  ///
  ///onGetDataNotification
  ///
  void onGetDataNotification({required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
      notificationResponse.clear();
      refreshController.resetNoData();
    } else {
      pageMax++;
    }

    notificationProvider.paginate(
        page: pageMax,
        limit: limitMax,
        filter: '&idUsers=${idUser}',
        onSuccess: (data) {
          if (data.isNotEmpty) {
            if (isRefresh) {
              notificationResponse.value = data;
              refreshController.refreshCompleted();
            } else {
              notificationResponse.value =
                  notificationResponse.value.toList() + data;
              refreshController.loadComplete();
            }
          } else {
            if (isRefresh) {
              refreshController.refreshCompleted();
            } else {
              refreshController.loadComplete();
            }
          }
          update();
        },
        onError: (error) => print(error));
  }

  ///
  ///onCheckIsRead
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
    EasyLoading.show(status: 'loading...');
    notificationProvider.markAsRead(
        id: item.id!,
        idUserRead: idUser!.value,
        onSuccess: (data) {
          orderProvider.paginateHistory(
              page: 1,
              limit: 1,
              filter:
                  '&_id=${item.idEntity}&populate=idUser,idUserShop,idVoucher,idProducts.idProduct',
              onSuccess: (value) {
                Get.toNamed(HistoryOrderRoutes.DETAILHISTORYORDER,
                        arguments: value.first)
                    ?.then((value) => onRefresh());
                EasyLoading.dismiss();
              },
              onError: (err) => {EasyLoading.dismiss()});
        },
        onError: (error) => {EasyLoading.dismiss()});
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }
}
