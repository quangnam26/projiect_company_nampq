

import 'package:get/get.dart';
import 'package:template/view/screen/share_friend/share_friend_controller.dart';

class ShareFriendBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShareFriendController>(() => ShareFriendController());
  }
}