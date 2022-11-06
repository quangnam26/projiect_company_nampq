// ignore_for_file: use_setters_to_change_properties

import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/order/order_history_response.dart';
import 'package:template/data/model/order/order_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/routes/route_path/history_order.dart';
import 'package:template/routes/route_path/home_routes.dart';
import 'package:template/utils/images_path.dart';

class HistoryOrderController extends GetxController {
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();
  final RefreshController refreshController = RefreshController();

  RxList<OrderHistoryResponse> orderResponse = <OrderHistoryResponse>[].obs;

  Rx<UserResponse> userResponse = UserResponse().obs;

  int pageMax = 1;
  int limitMax = 10;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    userResponse.value = Get.arguments as UserResponse;
    onGetDataOrderByIdUser(isRefresh: true);
  }

  ///
  /// on refresh
  ///
  Future<void> onRefresh() async {
    onGetDataOrderByIdUser(isRefresh: true);
  }

  ///
  /// on loading
  ///
  Future<void> onLoading() async {
    onGetDataOrderByIdUser(isRefresh: false);
  }

  void onGetDataOrderByIdUser({required bool isRefresh}) {
    if (isRefresh) {
      pageMax = 1;
      orderResponse.clear();
      refreshController.resetNoData();
    } else {
      pageMax++;
    }

    orderProvider.paginateHistory(
        page: pageMax,
        limit: limitMax,
        filter:
            '&idUser=${userResponse.value.id}&status!=0&populate=idUser,idUserShop,idVoucher,idProducts.idProduct',
        onSuccess: (data) {
          if (data.isNotEmpty) {
            if (isRefresh) {
              orderResponse.value = data;
              refreshController.refreshCompleted();
            } else {
              orderResponse.value = orderResponse.value.toList() + data;
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
        onError: (onError) => print(onError));
  }

  ///
  /// onGotoDetail
  ///
  void onGotoDetail({required OrderHistoryResponse order}) {
    Get.toNamed(HistoryOrderRoutes.DETAILHISTORYORDER, arguments: order)
        ?.then((value) => onRefresh());
  }

  ///
  /// Đến màn hình đánh giá
  ///
  void onGoToRatingPage({required OrderHistoryResponse order}) {
    Get.toNamed(HistoryOrderRoutes.REVIEWER, arguments: order)
        ?.then((value) => onRefresh());
  }

  ///
  /// On tap transport
  ///
  void onTapToStore({required UserResponse store}) {
    Get.toNamed(HomeRoutes.STORE, arguments: {
      'store': store,
    })?.then((value) {
      onRefresh();
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }
}
