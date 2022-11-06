import 'package:get/get.dart';
import 'package:template/routes/route_path/wallet_money_routers.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class WalletMoneyController extends GetxController {
  List<Map<String, dynamic>> list = [
    {
      "date": "17/06/2022",
      "order":
      [
        {
          
          "title": "Yêu cầu rút tiền",
          "status": "Thất bại",
          "icon_status": ImagesPath.status_fail,
          "dateTime": "10:25 - 20/04/2022",
          "price": "500.000đ",
          "color_price": ColorResources.RED,
        },
        {
          "title": "Yêu cầu rút tiền",
          "status": "Thành Công",
          "icon_status": ImagesPath.status_ok,
          "dateTime": "10:25 - 15/04/2022",
          "price": "-220.000đ",
          "color_price": ColorResources.GREEN,
        },
        {
          "title": "Yêu cầu rút tiền",
          "status": "Thành Công",
          "icon_status": ImagesPath.status_ok,
          "dateTime": "10:25 - 20/04/2022",
          "price": "500.000đ",
          "color_price": ColorResources.GREEN,
        },
        {
          "title": "Yêu cầu rút tiền",
          "status": "Đang đợi",
          "icon_status": ImagesPath.status_warning,
          "dateTime": "10:25 - 10/04/2022",
          "price": "-220.000đ",
          "color_price": ColorResources.YELLOW,
        },
      ],
    },
    {
        "date": "16/06/2022",
      "order": [
        {
          "title": "Yêu cầu rút tiền",
          "status": "Thất bại",
          "icon_status": ImagesPath.status_fail,
          "dateTime": "10:25 - 8/04/2022",
          "price": "500.000đ",
          "color_price": ColorResources.RED,
        },
        {
          "title": "Yêu cầu rút tiền",
          "status": "Thành Công",
          "icon_status": ImagesPath.status_ok,
          "dateTime": "10:25 - 6/04/2022",
          "price": "-220.000đ",
          "color_price": ColorResources.GREEN,
        },
      ]
    }
  ];

  void onGotozReCharge() {
    Get.toNamed(WalletMoneyRoutes.RECHARGE);
  }
}
