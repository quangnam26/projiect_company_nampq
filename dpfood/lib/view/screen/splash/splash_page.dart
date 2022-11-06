import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: const Color.fromARGB(255, 255, 20, 4),
      ),
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Center(
            child: SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width * 0.8,
              child: Center(
                child: IZIImage(
                  ImagesPath.logo_app,
                  fit: BoxFit.contain,
                  height: IZIDimensions.iziSize.height,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
