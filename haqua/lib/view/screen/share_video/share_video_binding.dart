

import 'package:get/get.dart';
import 'package:template/view/screen/share_video/share_video_controller.dart';

class ShareVideoBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ShareVideoController>(() => ShareVideoController());
  }
}