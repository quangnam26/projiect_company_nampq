import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/routes/route_path/home_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';

class IntroductionController extends GetxController {
  
  /// Declare Data.
  int currentIndex = 0;
  PageController pageController = PageController();
  bool isLoading = true;
  List<Widget> widgetIntroduction = [];

  @override
  void onInit() {
    super.onInit();

    /// Add data for [Introduction] page.
    addIntroPage();
  }

  ///
  /// Add data for [Introduction] page.
  ///
  void addIntroPage() {
    widgetIntroduction = [
      Container(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorResources.PRIMARY_APP,
              ColorResources.PRIMARY_APP,
              ColorResources.WHITE,
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.ONE_UNIT_SIZE * 100,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: IZIDimensions.iziSize.width,
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
                margin: EdgeInsets.only(
                  top: IZIDimensions.ONE_UNIT_SIZE * 150,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'title_1'.tr.toUpperCase(),
                            style: GoogleFonts.mali(
                              fontWeight: FontWeight.w600,
                              color: ColorResources.WHITE,
                              fontSize: IZIDimensions.FONT_SIZE_H2,
                            ),
                          ),
                          TextSpan(
                            text: 'title_2'.tr,
                            style: TextStyle(
                              color: ColorResources.WHITE,
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IZIImage(
                ImagesPath.splash_ver_1,
                width: IZIDimensions.iziSize.width * .45,
              ),
            ],
          ),
        ),
      ),
      Container(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorResources.PRIMARY_APP,
              ColorResources.PRIMARY_APP,
              ColorResources.WHITE,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.ONE_UNIT_SIZE * 150,
                ),
                width: IZIDimensions.iziSize.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        color: ColorResources.WHITE.withOpacity(.3),
                        width: IZIDimensions.iziSize.width * .9,
                        height: IZIDimensions.iziSize.height * .2,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.ONE_UNIT_SIZE * 40,
                          vertical: IZIDimensions.ONE_UNIT_SIZE * 15,
                        ),
                        child: Center(
                          child: Text(
                            'title_3'.tr,
                            style: TextStyle(
                              color: ColorResources.WHITE,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  bottom: IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height * .55,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IZIImage(
                        ImagesPath.splash_ver_2_2,
                        width: IZIDimensions.iziSize.width * .75,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: -IZIDimensions.iziSize.width * .2,
                      child: IZIImage(
                        ImagesPath.splash_ver_2_1,
                        width: IZIDimensions.iziSize.width * .8,
                      ),
                    ),
                    Positioned(
                      top: IZIDimensions.ONE_UNIT_SIZE * 180,
                      right: IZIDimensions.iziSize.width * .12,
                      child: Text(
                        'title_4'.tr,
                        style: TextStyle(
                          color: ColorResources.BLACK.withOpacity(.7),
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorResources.PRIMARY_APP,
              ColorResources.PRIMARY_APP,
              ColorResources.WHITE,
            ],
          ),
        ),
        padding: EdgeInsets.only(bottom: IZIDimensions.ONE_UNIT_SIZE * 80),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IZIImage(
                        ImagesPath.splash_ver_3_1,
                        width: IZIDimensions.iziSize.width * .78,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 320,
                left: 0,
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    children: [
                      IZIImage(
                        ImagesPath.splash_ver_3_2,
                        width: IZIDimensions.iziSize.width * .8,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: IZIDimensions.ONE_UNIT_SIZE * 30,
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IZIImage(
                        ImagesPath.splash_ver_3_3,
                        width: IZIDimensions.iziSize.width * .68,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: IZIDimensions.ONE_UNIT_SIZE * 75,
                top: IZIDimensions.iziSize.height * .4,
                child: Text(
                  'title_5'.tr,
                  style: TextStyle(
                    color: ColorResources.WHITE,
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ),
              Positioned(
                right: IZIDimensions.ONE_UNIT_SIZE * 95,
                top: IZIDimensions.ONE_UNIT_SIZE * 90,
                child: Text(
                  'title_6'.tr,
                  style: TextStyle(
                    color: ColorResources.BLACK.withOpacity(.7),
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorResources.PRIMARY_APP,
              Color.fromARGB(255, 45, 125, 230),
              Color.fromARGB(255, 77, 146, 235),
              ColorResources.WHITE,
            ],
          ),
        ),
        padding: EdgeInsets.only(
          bottom: IZIDimensions.ONE_UNIT_SIZE * 100,
        ),
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IZIImage(
                        ImagesPath.splash_ver_4_1,
                        width: IZIDimensions.iziSize.width,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 330,
                left: IZIDimensions.ONE_UNIT_SIZE * 30,
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    children: [
                      IZIImage(
                        ImagesPath.splash_ver_4_2,
                        width: IZIDimensions.iziSize.width * .8,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: IZIDimensions.ONE_UNIT_SIZE * 30,
                child: SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IZIImage(
                        ImagesPath.splash_ver_4_3,
                        width: IZIDimensions.iziSize.width * .7,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: IZIDimensions.ONE_UNIT_SIZE * 120,
                top: IZIDimensions.iziSize.height * .43,
                child: Text(
                  'title_7'.tr,
                  style: TextStyle(
                    color: ColorResources.BLACK.withOpacity(.7),
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ),
              Positioned(
                right: IZIDimensions.ONE_UNIT_SIZE * 60,
                top: IZIDimensions.ONE_UNIT_SIZE * 155,
                child: Text(
                  'title_8'.tr,
                  style: TextStyle(
                    color: ColorResources.BLACK.withOpacity(.7),
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      Container(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorResources.PRIMARY_APP,
              Color.fromARGB(255, 45, 125, 230),
              Color.fromARGB(255, 77, 146, 235),
              ColorResources.WHITE,
            ],
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.ONE_UNIT_SIZE * 100,
        ),
      ),
    ];

    isLoading = false;
    update();
  }

  ///
  /// On change index page view.
  ///
  void onChangeIndex(int index) {
    currentIndex = index;
    update();

    /// If currentIndex == 4 then check condition below
    if (currentIndex == 4) {
      sl<SharedPreferenceHelper>().setSplash(status: true);
      final isLogin = sl<SharedPreferenceHelper>().getLogin;

      /// If not logger then go to [Dashboard page] with guest account.
      if (isLogin == false) {
        isLoading = false;
        Future.delayed(Duration.zero, () {
          Get.offAllNamed(HomeRoutes.DASHBOARD);
        });
      }
    }
  }
}
