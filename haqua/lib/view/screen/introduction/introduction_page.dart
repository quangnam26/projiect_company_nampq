import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/introduction/introduction_controller.dart';

class IntroductionPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<IntroductionController>(
      init: IntroductionController(),
      builder: (IntroductionController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return Container(
          color: ColorResources.PRIMARY_APP,
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: Stack(
            children: [

              /// Page View.
              _pageView(controller),

              /// Dot page view.
              Positioned(
                bottom: IZIDimensions.ONE_UNIT_SIZE * 55,
                left: 0,
                child: _dotPage(controller),
              ),
            ],
          ),
        );
      },
    );
  }

  ///
  /// Page View.
  ///
  PageView _pageView(IntroductionController controller) {
    return PageView(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: controller.pageController,
      onPageChanged: (index) {
        controller.onChangeIndex(index);
      },
      children: [
        ...List.generate(
          controller.widgetIntroduction.length,
          (index) {
            return controller.widgetIntroduction[index];
          },
        )
      ],
    );
  }

  ///
  /// Dot on change page view.
  ///
  SizedBox _dotPage(IntroductionController controller) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            controller.widgetIntroduction.length - 1,
            (index) {
              return Container(
                margin: EdgeInsets.only(
                  left: index == 0 ? 0 : IZIDimensions.SPACE_SIZE_1X,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(IZIDimensions.ONE_UNIT_SIZE * 50),
                  child: Container(
                    color: controller.currentIndex == index ? ColorResources.PRIMARY_APP : ColorResources.WHITE,
                    width: controller.currentIndex == index ? IZIDimensions.ONE_UNIT_SIZE * 40 : IZIDimensions.ONE_UNIT_SIZE * 17,
                    height: IZIDimensions.ONE_UNIT_SIZE * 17,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
