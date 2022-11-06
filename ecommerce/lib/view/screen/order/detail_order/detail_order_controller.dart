import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:template/data/model/orders/order_response.dart';
import 'package:template/provider/order_provider.dart';

enum StatusOrderEnum {
  START,
  DRIVER_ONCOMING,
  DELIVERING,
  DONE,
}

class DetailOrderController extends GetxController {
  OrderProvider orderProvider = OrderProvider();
  List<Map<String, dynamic>> statusOrder = [
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.START,
      'title': "Chờ xác nhận"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DRIVER_ONCOMING,
      'title': "Chờ lấy hàng"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DELIVERING,
      'title': "Đang giao"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DONE,
      'title': "Đã giao"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DONE,
      'title': "Đã hủy"
    },
  ];
  OrderResponse order = OrderResponse();

  int? processIndex;

  @override
  void onInit() {
    order = Get.arguments as OrderResponse;
    super.onInit();
  }

  // String statusOrder() {
  //   switch (order.status) {
  //     case " Wait for confirmation":
  //       return "Chờ xác nhận";
  //     case " get product":
  //       return "Chờ lấy hàng";
  //     case " delivering":
  //       return "Đang giao";
  //     case "delivered":
  //       return "Đã giao";
  //     case "cancelled":
  //       return "Đã hủy";
  //     default:
  //       return "Chờ xác nhận";
  //   }
  // }
  int statusOrderIndex() {
    switch (order.status) {
      case "Wait for confirmation":
        return processIndex = 0;
      case " get product":
        return processIndex = 1;
      case " delivering":
        return processIndex = 2;
      case "delivered":
        return processIndex = 3;
      case "cancelled":
        return processIndex = 4;
      default:
        return processIndex = 0;
    }
  }

  void cancelOrder() {
    EasyLoading.show(status: "Please waiting...");
    orderProvider.updateStatusOrder(
        id: order.id!,
        onSuccess: (onSuccess) {
          print(onSuccess);
          order.status = onSuccess.status;
          update();
          EasyLoading.dismiss();
        },
        onError: (onError) {});
  }
}
