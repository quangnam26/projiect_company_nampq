import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: MediaQuery.of(context).viewInsets.bottom > 150 ? null : FloatingActionButton(
              child: Icon(
                Icons.add,
                color: ColorResources.PRIMARY_1,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
              onPressed: () {
                controller.onTapFloatActionButton();
              },
            ),
          ),
        );
      },
    );
  }

  Widget onSelected(BuildContext context, {required String title, required IconData icon, required int index}) {
    return Material(
      child: GestureDetector(
        onTap: () => controller.onChangedPage(index),
        child: SizedBox(
          width: IZIDimensions.iziSize.width / controller.pages.length,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder(
                builder: (DashBoardController controller) {
                  return Icon(
                    icon,
                    color: controller.currentIndex.value == index ? ColorResources.PRIMARY_1 : ColorResources.NEUTRALS_5,
                  );
                },
              ),
              Obx(
                () => Text(
                  title,
                  style: TextStyle(
                    color: controller.currentIndex.value == index ? ColorResources.PRIMARY_1 : ColorResources.NEUTRALS_5,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigator(BuildContext context) {
    return BottomAppBar(
      clipBehavior: Clip.hardEdge,
      color: ColorResources.BACKGROUND_NAV,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: 60,
        width: IZIDimensions.iziSize.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ...List.generate(
              controller.pages.length,
              (index) {
                return Container(
                  color: Colors.transparent,
                  child: onSelected(
                    context,
                    title: controller.pages[index]['label'].toString(),
                    icon: controller.pages[index]['icon'] as IconData,
                    index: index,
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


// ignore: must_be_immutable
class MyBorderShape extends ShapeBorder {
  MyBorderShape();

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  double holeSize = 70;


  @override
  ShapeBorder scale(double t) => this;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path.combine(
      PathOperation.difference,
      Path()
        ..addRRect(
            RRect.fromRectAndRadius(rect, Radius.circular(rect.height / 2)))
        ..close(),
      Path()
        ..addOval(Rect.fromCenter(
            center: rect.center.translate(0, -rect.height / 2),
            height: holeSize,
            width: holeSize))
        ..close(),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }
}