import 'package:get/get.dart';
import 'package:template/view/screen/account_user/introduced_friend/introduced_friend_controller.dart';

class IntroducedFriendBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IntroducedFriendController>(() => IntroducedFriendController());
  }
}
