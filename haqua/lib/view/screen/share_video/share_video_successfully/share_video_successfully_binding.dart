import 'package:get/get.dart';
import 'package:template/view/screen/share_video/share_video_successfully/share_video_successfully_controller.dart';

class ShareVideoSuccessfullyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShareVideoSuccessfullyController>(() => ShareVideoSuccessfullyController());
  }
}
