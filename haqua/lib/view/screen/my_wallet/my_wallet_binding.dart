import 'package:get/get.dart';
import 'package:template/view/screen/%20my_wallet/%20my_wallet_controller.dart';

class MyWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyWalletController>(() => MyWalletController());
  }
}
