import 'package:get/get.dart';
import 'package:template/base_widget/izi_preview_image/izi_preview_image_controller.dart';

class IZIPreviewImagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IZIPreviewImagesController>(() => IZIPreviewImagesController());
  }
}
