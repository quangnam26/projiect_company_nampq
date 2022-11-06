import 'package:get/get.dart';
import 'package:template/routes/route_path/other_policies_routes.dart';

class OtherPoliciesController extends GetxController {

  // List 
  List<Map<String, dynamic>> menusList = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    menusList = [
      {
        'title': 'Chính sách đổi hàng',
        'onTap': () {
          print("object");
          Get.toNamed(OtherPoliciesRoutes.EXCHANGE_POLICY);
        }
      },
      {
        'title': 'Chính sách vận chuyển',
        'onTap': () {
          Get.toNamed(OtherPoliciesRoutes.SHIPPING_POLICY);
        },
      },
      {
        'title': 'Chính sách bảo hành',
        'onTap': () {
          Get.toNamed(OtherPoliciesRoutes.WARRANTY_POLICY);
        },
      },
      {
        'title': 'Hướng dẫn mua hàng',
        'onTap': () {
          Get.toNamed(OtherPoliciesRoutes.SHOPPING_GUIDE);
          // Get.toNamed(OtherPoliciesRoutes.PURCHASE_POLICY);
        },
      },
      {
        'title': 'Điều khoản và chính sách',
        'onTap': () {
          Get.toNamed(OtherPoliciesRoutes.TERMS_AND_POLICIES);
        },
      },
      {
        'title': 'Thông tin và chuyển khoản',
        'onTap': () {
          Get.toNamed(OtherPoliciesRoutes.TRANSFER_INFORMATION);
        },
      },
    ];
  }
}
