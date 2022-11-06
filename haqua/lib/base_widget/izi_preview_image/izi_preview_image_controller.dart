

import 'package:get/get.dart';
import 'package:template/helper/izi_validate.dart';

class IZIPreviewImagesController extends GetxController {
  //Khai báo isLoading
  bool isLoading = true;

  //Khai bao image
  String? imageUrl;

  @override
  void onInit() {
    //getImageUrl
    getImageUrl();
    super.onInit();
  }


  ///
  /// Get imageUrl
  ///
  void getImageUrl() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      imageUrl = Get.arguments as String;
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }
}