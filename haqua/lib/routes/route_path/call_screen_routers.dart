import 'package:get/get.dart';

import '../../view/screen/room_video_call/room_video_call_binding.dart';
import '../../view/screen/room_video_call/room_video_call_page.dart';

class CallVideoScreenRoutes {
  static const String ROOM_VIDEO_CALL = '/room_video_call';

  static List<GetPage> list = [
    GetPage(
      name: ROOM_VIDEO_CALL,
      page: () => RoomVideoCallPage(),
      binding: RoomVideoCallBinding(),
    ),
  ];
}
