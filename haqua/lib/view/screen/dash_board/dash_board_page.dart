import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/dash_board/dash_board_controller.dart';

class DashBoardPage extends GetView<DashBoardController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (DashBoardController value) {
        return WillPopScope(
          onWillPop: () => value.onDoubleBack(),
          child: Scaffold(
            backgroundColor: ColorResources.BACKGROUND_NAV,
            body: Obx(() => controller.pages[controller.currentIndex.value]['page'] as Widget),
            bottomNavigationBar: bottomNavigator(context),
          ),
        );
      },
    );
  }

  ///
  /// Item bottom navigator bar.
  ///
  Widget onSelected(
    BuildContext context, {
    required String title,
    required String icon,
    required int index,
  }) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        onTap: () => controller.onChangedPage(index),
        child: Container(
          color: ColorResources.BLACK,
          width: IZIDimensions.iziSize.width / controller.pages.length,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder(
                builder: (DashBoardController controller) {
                  return IZIImage(
                    icon,
                    width: index == 2
                        ? IZIDimensions.ONE_UNIT_SIZE * 60
                        : index == 4
                            ? IZIDimensions.ONE_UNIT_SIZE * 33
                            : index == 0
                                ? IZIDimensions.ONE_UNIT_SIZE * 40
                                : IZIDimensions.ONE_UNIT_SIZE * 35,
                    height: index == 4 ? IZIDimensions.ONE_UNIT_SIZE * 38 : IZIDimensions.ONE_UNIT_SIZE * 35,
                    color: controller.currentIndex.value == index ? ColorResources.WHITE : ColorResources.GREY,
                  );
                },
              ),
              Obx(
                () => Text(
                  title,
                  style: TextStyle(
                    color: controller.currentIndex.value == index ? ColorResources.WHITE : ColorResources.GREY,
                    fontWeight: controller.currentIndex.value == index ? FontWeight.w300 : FontWeight.normal,
                    fontSize: controller.currentIndex.value == index ? IZIDimensions.FONT_SIZE_SPAN : IZIDimensions.FONT_SIZE_SPAN * .9,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Bottom Navigator Bar
  ///
  Widget bottomNavigator(BuildContext context) {
    return BottomAppBar(
      color: Colors.transparent,
      child: Container(
        height: IZIDimensions.ONE_UNIT_SIZE * 75,
        width: IZIDimensions.iziSize.width,
        decoration: const BoxDecoration(
          color: ColorResources.BLACK,
        ),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                controller.pages.length,
                (index) {
                  return onSelected(
                    context,
                    title: index == 0
                        ? "home".tr
                        : index == 1
                            ? "explore".tr
                            : index == 2
                                ? ''
                                : index == 3
                                    ? "dating".tr
                                    : index == 4
                                        ? "account".tr
                                        : '',
                    icon: controller.currentIndex.value == index ? controller.pages[index]['icon'] as String : controller.pages[index]['icon_unselected'] as String,
                    index: index,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
