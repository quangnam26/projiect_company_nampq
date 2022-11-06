import 'package:get/get.dart';
import 'package:template/view/screen/share_video/share_video_binding.dart';
import 'package:template/view/screen/share_video/share_video_page.dart';
import 'package:template/view/screen/share_video/share_video_successfully/share_video_successfully_binding.dart';
import 'package:template/view/screen/share_video/share_video_successfully/share_video_successfully_page.dart';

class ShareVideoRoutes {
  static const String SHARE_VIDEO = '/share_video';
  static const String SHARE_VIDEO_SUCCESSFULLY = '/share_video_successfulyy';

  static List<GetPage> list = [
    GetPage(
      name: SHARE_VIDEO,
      page: () => ShareVideoPage(),
      binding: ShareVideoBinding(),
    ),
    GetPage(
      name: SHARE_VIDEO_SUCCESSFULLY,
      page: () => ShareVideoSuccessfulyyPage(),
      binding: ShareVideoSuccessfullyBinding(),
    ),
  ];
}
