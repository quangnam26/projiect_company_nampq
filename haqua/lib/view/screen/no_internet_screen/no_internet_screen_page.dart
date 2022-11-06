import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/no_internet_screen/no_internet_screen_controller.dart';

class NoInternetPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorResources.BLACK,
        body: GetBuilder(
          init: NoInternetController(),
          builder: (NoInternetController controller) {
            return SizedBox(
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off_outlined,
                    color: ColorResources.WHITE,
                    size: IZIDimensions.ONE_UNIT_SIZE * 250,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Text(
                      'You are disconnected from the internet.',
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.WHITE,
                      ),
                    ),
                  ),
                  IZIButton(
                    width: IZIDimensions.iziSize.width * .5,
                    label: "Thử lại",
                    onTap: () {
                      controller.checkInternet();
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_2X,
                      vertical: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    borderRadius: IZIDimensions.BORDER_RADIUS_2X,
                    colorBG: ColorResources.GREY,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
