import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_splash.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/splash/splash_controller.dart';

class SplashPage extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: IZIScreen(
        background: const BackgroundSplash(),
        isSingleChildScrollView: false,
        body: GetBuilder(
          init: SplashController(),
          builder: (controller) {
            return Center(
              child: SizedBox(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width * 0.8,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_5X,
                    ),
                    child: Image.asset(
                      ImagesPath.splash_haqua,
                      fit: BoxFit.contain,
                      height: IZIDimensions.ONE_UNIT_SIZE * 200,
                      width: IZIDimensions.ONE_UNIT_SIZE * 200,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
