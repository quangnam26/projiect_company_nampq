import 'package:get/get.dart';
import 'package:template/view/screen/accounts/account_controller.dart';
import 'package:template/view/screen/cart/cart_controller.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';
import 'package:template/view/screen/news/new_controller.dart';
// import '../account/account_controller.dart';
import '../home/home_controller.dart';
import '../huntingvouchers/hunting_vouchers_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() { 
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.put<HomeController>(HomeController());
    Get.put<AccountController>(AccountController());
    Get.put<NewsController>(NewsController());
    Get.put<HuntingVouchersController>(HuntingVouchersController());
    Get.lazyPut<CartController>(() => CartController());

    // Get.lazyPut<HomeController>(() => HomeController());
    // Get.lazyPut<TestController>(() => TestController());
    // Get.lazyPut<SavedController>(() => SavedController());
    // Get.lazyPut<AskController>(() => AskController());
    // Get.put<AskController>(AskController());
  }
}
