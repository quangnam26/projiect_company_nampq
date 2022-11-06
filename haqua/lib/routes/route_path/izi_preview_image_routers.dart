
import 'package:get/get.dart';
import 'package:template/base_widget/izi_preview_image/izi_preview_image_binding.dart';
import 'package:template/base_widget/izi_preview_image/izi_preview_image_page.dart';


class IZIPreviewImageRoutes {
  static const String IZI_PREVIEW_IMAGE = '/izi_preview_image';

  static List<GetPage> list = [
    GetPage(
      name: IZI_PREVIEW_IMAGE,
      page: () => IZIPreviewImagesPage(),
      binding: IZIPreviewImagesBinding(),
    ),
  ];
}