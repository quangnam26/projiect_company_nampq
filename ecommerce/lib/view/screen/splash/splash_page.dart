import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';


class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      // background: const BackgroundAppBar(),
      safeAreaTop: false,
      isSingleChildScrollView: false,
      body: GetBuilder(
        init: SplashController(),
        builder: (controller) {
          return Center(
            child: SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width * 0.5,
              child: Center(
                child: IZIImage(
                  // 'assets/images/logo_splash.png',
                  ImagesPath.logo_app,
                  fit: BoxFit.contain,
                  height: IZIDimensions.ONE_UNIT_SIZE * 300,
                  width: IZIDimensions.ONE_UNIT_SIZE * 300,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
