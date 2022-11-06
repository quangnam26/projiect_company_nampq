import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/change_password/change_password_controller.dart';

class ChangePassWordPage extends GetView<ChangePassWordController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: const IZIAppBar(
        title: "Đổi mật khẩu",
        colorTitle: ColorResources.WHITE,
      ),
      body: GetBuilder(
        builder: (ChangePassWordController controller) => Container(
          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: IZIDimensions.SPACE_SIZE_5X * 2,
                        horizontal: IZIDimensions.BLUR_RADIUS_2X),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_5X),
                    ),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X),
                          child: IZIInput(
                              borderRadius: IZIDimensions.BORDER_RADIUS_3X,
                              isBorder: true,
                              label: "Mật khẩu cũ",
                              placeHolder: "Nhập mật khẩu cũ",
                              controller: controller.oldPassword,
                              onChanged: (value) {
                                controller.oldPassword.text = value;
                              },
                              type: IZIInputType.TEXT),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X),
                          child: IZIInput(
                              borderRadius: IZIDimensions.BORDER_RADIUS_3X,
                              isBorder: true,
                              label: "Mật khẩu mới",
                              placeHolder: "Nhập mật khẩu mới",
                              controller: controller.newPassword,
                              onChanged: (value) {
                                controller.newPassword.text = value;
                              },
                              type: IZIInputType.TEXT),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              bottom: IZIDimensions.SPACE_SIZE_3X),
                          child: IZIInput(
                              borderRadius: IZIDimensions.BORDER_RADIUS_3X,
                              isBorder: true,
                              label: "Nhập lại mật khẩu mới",
                              placeHolder: "Nhập lại mật khẩu mới",
                              controller: controller.rePassword,
                              onChanged: (value) {
                                controller.rePassword.text = value;
                              },
                              type: IZIInputType.TEXT),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              IZIButton(
                onTap: () => controller.onSummit(),
                label: "Đổi mật khẩu",
              )
            ],
          ),
        ),
      ),
    );
  }
}
