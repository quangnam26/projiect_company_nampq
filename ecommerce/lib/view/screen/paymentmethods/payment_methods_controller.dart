import 'package:get/get.dart';
import 'package:template/routes/route_path/payment_methods_routes.dart';

import '../../../helper/izi_validate.dart';

enum PaymentMethod { app, momo, atm, visa, cash }

class PaymentMethodsController extends GetxController {
  List<Map<String, dynamic>> menusPay = [
    // {
    //   'image': 'assets/images/ic_momo.png',
    //   'title': 'Ví app',
    //   'title1': '',
    //   'image2': '',
    //   'onTap': () {
    //     Get.back(result: PaymentMethod.app);
    //   }
    // },
    {
      'image': 'assets/images/ic_momo.png',
      'title': 'Ví MoMo',
      'title1': '',
      'image2': '',
      'onTap': () {
        Get.back(result: PaymentMethod.momo);
      },
    },
    // {
    //   'image': 'assets/images/ic_card.png',
    //   'title': 'Thẻ ATM',
    //   'title1': 'Hổ trợ Internet Banking',
    //   'image2': '',
    //   'onTap': () {
    //     Get.toNamed(PaymentmethodsRoutes.DOMESTIC_ATM_CARD);
    //   },
    // },
    // {
    //   'image': 'assets/images/ic_cardvisa.png',
    //   'title': 'Thêm thẻ Tín dụng/Ghi nợ',
    //   'title1': '',
    //   'image2': 'assets/icons/ic_visacard.png',
    //   'onTap': () {
    //     Get.toNamed(PaymentmethodsRoutes.ADD_CREDIT_CARD);
    //   }
    // },
    {
      'image': 'assets/images/ic_cardvisa.png',
      'title': 'Thanh toán khi nhận hàng',
      'title1': '',
      'image2': '',
      'onTap': () {
        Get.back(result: PaymentMethod.cash);
      },
    }
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    Get.arguments;
    super.onInit();
  }
}
