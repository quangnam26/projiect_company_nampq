import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/onboarding/onboarding_controller.dart';

import '../../../base_widget/izi_button.dart';

class OnboardingPage extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      safeAreaBottom: false,
      safeAreaTop: false,
      isSingleChildScrollView: false,
      body: GetBuilder(
        init: OnboardingController(),
        builder: (OnboardingController controller) {
          return Center(
            child: SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        flex: 7,
                        child: PageView.builder(
                          controller: controller.pageController,
                          onPageChanged: (val) {
                            controller.onPageChanged(val);
                          },
                          itemCount: controller.splashs.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                              child: IZIImage(
                                controller.splashs[index]['image'].toString(),
                                fit: BoxFit.contain,
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: IZIDimensions.iziSize.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                            ),
                            gradient: ColorResources.linearGradientPrimary,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_5X,
                              ),
                              Text(
                                controller.splashs[controller.currentIndex]['title'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_H3,
                                  color: ColorResources.WHITE,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              Text(
                                controller.splashs[controller.currentIndex]['description'].toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.WHITE,
                                ),
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_5X,
                              ),
                              IZIButton(
                                label: controller.currentIndex == controller.splashs.length - 1 ? 'Bắt đầu' : "Tiếp tục",
                                onTap: () {
                                  controller.onNext();
                                },
                                width: IZIDimensions.ONE_UNIT_SIZE * 250,
                                borderRadius: 5,
                                colorBG: ColorResources.WHITE,
                                colorText: ColorResources.PRIMARY_1,
                              ),
                              const Expanded(
                                child: SizedBox(),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...List.generate(
                                    controller.splashs.length,
                                    (val) => Container(
                                      width: controller.currentIndex == val ? IZIDimensions.ONE_UNIT_SIZE * 50 : IZIDimensions.ONE_UNIT_SIZE * 15,
                                      height: controller.currentIndex == val ? IZIDimensions.ONE_UNIT_SIZE * 15 : IZIDimensions.ONE_UNIT_SIZE * 15,
                                      margin: EdgeInsets.symmetric(
                                        horizontal: IZIDimensions.SPACE_SIZE_1X,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: controller.currentIndex == val ? BoxShape.rectangle : BoxShape.circle,
                                        borderRadius: controller.currentIndex == val ? BorderRadius.circular(10) : null,
                                        color: controller.currentIndex == val ? ColorResources.WHITE : ColorResources.NEUTRALS_4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: IZIDimensions.SPACE_SIZE_5X,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 10 + MediaQuery.of(context).viewPadding.top,
                    right: IZIDimensions.SPACE_SIZE_2X,
                    child: GestureDetector(
                      onTap: () {
                        controller.onSkip();
                      },
                      child: const Text(
                        'SKIP',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
