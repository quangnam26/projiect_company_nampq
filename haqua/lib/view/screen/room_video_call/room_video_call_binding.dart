import 'package:get/get.dart';
import 'package:template/view/screen/room_video_call/room_video_call_controller.dart';

class RoomVideoCallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RoomVideoCallController>(() => RoomVideoCallController());
  }
}
