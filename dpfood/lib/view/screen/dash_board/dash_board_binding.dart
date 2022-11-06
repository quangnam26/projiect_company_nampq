import 'package:get/get.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';
import '../account/account_controller.dart';
import '../home/home_controller.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashBoardController>(() => DashBoardController());
    Get.put<HomeController>(HomeController());
    Get.put<AccountController>(AccountController());
  }
}