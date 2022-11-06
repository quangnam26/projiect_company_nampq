import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/orders/order_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/helper/socket_service.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/images_path.dart';

class OrderController extends GetxController {
  int page = 1;

  int selectTitleOrder = 0;
  List<Map<String, dynamic>> map = [
    {
      "icon": ImagesPath.checkout,
      "text": "Chờ xác nhận",
    },
    {
      "icon": ImagesPath.payment,
      "text": "Chờ lấy hàng",
    },
    {
      "icon": ImagesPath.confirm,
      "text": "Đang giao",
    },
    {
      "icon": ImagesPath.confirm_select,
      "text": "Đánh giá",
    }
  ];
  OrderProvider orderProvider = OrderProvider();
  List<OrderResponse> orderList = <OrderResponse>[];

  final RefreshController refreshController = RefreshController();

  final socket = sl<SocketService>();
  String? id;

  @override
  void onInit() {
    super.onInit();
    Get.arguments;

    getAllOrder(isRefesh: true);
  }

  void getAllOrder({required bool isRefesh}) {
    if (isRefesh) {
      page = 1;
      orderList.clear();
    } else {
      page++;
    }
    EasyLoading.show(status: "Please waiting");
    orderProvider.paginate(
        page: page++,
        limit: 50,
        filter: "&user=${sl<SharedPreferenceHelper>().getProfile}&populate=items.product,voucher",
        onSuccess: (onSuccess) {
          orderList.addAll(onSuccess
              .where((element) =>
                  element.items!.where((element) => !IZIValidate.nullOrEmpty(element.idProduct)).isNotEmpty)
              .toList());
          if (isRefesh) {
            refreshController.resetNoData();
            refreshController.refreshCompleted();
          } else {
            refreshController.loadComplete();
          }
          update();
          EasyLoading.dismiss();
        },
        onError: (onError) {
          print(onError);
          EasyLoading.dismiss();
        });
  }

  void onChangeTitleOrder(int id) {
    selectTitleOrder = id;
    update();
  }

  ///
  /// OnGoToPage
  ///
  void onGoToPage(String page, OrderResponse orderResponse) {
    Get.toNamed(page, arguments: orderResponse)!.then((value) {
      getAllOrder(isRefesh: true);
      update();
    });
  }

  @override
  void onClose() {
    super.onClose();
    socket.getSocket().off(ecommerce_socket);
  }

  ///
  /// Listen user or admin send a message.
  ///
  /// Listen user entering a new message.
  ///
  void _onListeningOrder() {
    if (!socket.hasListeners(ecommerce_socket)) {
      socket.on(
        ecommerce_socket,
        (event) {},
      );
    }
  }

  ///
  /// Send a message to the conversation.
  ///
  void _sendOrder({required bool enteringMessage}) {
    socket.emit(ecommerce_socket, {});
  }

  // loadmore
  void loadMore() {
    getAllOrder(isRefesh: false);
  }
  //refresh

  void refresh2() {
    getAllOrder(isRefesh: true);
  }
}
