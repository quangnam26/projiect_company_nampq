import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/onboarding/onboarding_controller.dart';

import '../../../base_widget/background/background_onboarding.dart';

class OnboardingPage extends GetView<OnboardingController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      safeAreaBottom: false,
      safeAreaTop: false,
      isSingleChildScrollView: false,
      background: const BackgroundOnBoarding(),
      body: GetBuilder(
        init: OnboardingController(),
        builder: (OnboardingController controller) {
          return Center(
            child: SizedBox(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).viewPadding.top,
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "WELCOME \nTO D&P FOOD",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_H3,
                          color: ColorResources.NEUTRALS_3,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
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
                    child: SizedBox(
                      width: IZIDimensions.iziSize.width,
                      child: Column(
                        children: [
                          Text(
                            controller.splashs[controller.currentIndex]['title'].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H4 * 0.96,
                              color: ColorResources.NEUTRALS_3,
                            ),
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          descriptionHighlight(
                            data: controller.splashs[controller.currentIndex]['description'] as List<Map<String, dynamic>>,
                          ),
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          const Expanded(
                            child: SizedBox(),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.onSkip();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                                  ),
                                  child: Text(
                                    'Bỏ qua',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.PRIMARY_1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const Spacer(),
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
                                    color: controller.currentIndex == val ? ColorResources.PRIMARY_3 : ColorResources.NEUTRALS_4,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  controller.onNext();
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_4X,
                                  ),
                                  child: Text(
                                    controller.currentIndex == controller.splashs.length - 1 ? 'Bắt đầu' : "Tiếp tục",
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.PRIMARY_1,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
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
            ),
          );
        },
      ),
    );
  }

  /// highlight
  Widget descriptionHighlight({required List<Map<String, dynamic>> data}) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            ...List.generate(
              data.length,
              (index) {
                return TextSpan(
                  text: data[index]['text'].toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    color: data[index]['highlight'].toString() == '1' ? ColorResources.PRIMARY_3 : ColorResources.NEUTRALS_3,
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
