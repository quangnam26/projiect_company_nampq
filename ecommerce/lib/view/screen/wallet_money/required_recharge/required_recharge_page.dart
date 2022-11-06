import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';

import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';

import 'package:template/helper/izi_text_style.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/wallet_money/required_recharge/required_recharge_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_button.dart';
import '../../../../base_widget/izi_text.dart';
import '../../../../utils/images_path.dart';

class RequiredRechargePage extends GetView<RequiredRechargeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      // isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Thông tin thanh toán',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),
      safeAreaBottom: false,
      body: GetBuilder(
        init: RequiredRechargeController(),
        builder: (RequiredRechargeController controller) {
          return Container(
            color: ColorResources.NEUTRALS_6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    left: IZIDimensions.SPACE_SIZE_4X,
                    right: IZIDimensions.SPACE_SIZE_4X,
                    top: IZIDimensions.SPACE_SIZE_3X,
                  ),
                  // color: ColorResources.WHITE,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_3X),
                        child:          IZIText(
                                     text:
                          "Quản lý tài khoản",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                        ),
                      ),
                      content(
                        content: controller.settingResponse.holder.toString(),
                        style: TextStyle(
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                        //  controller.settingResponse.bankName
                        //     .toString(),
                        title: "Ngân hàng nhận",
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      content(
                        content:
                            controller.settingResponse.accountNumber.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                        title: "Số tài khoản",
                        icon: Icons.copy,
                        onTapIcon: () {
                          print("asa");
                          controller.copyAccount(
                              controller.settingResponse.accountNumber ?? "");
                          // .settingResponse.bankAccountNumber
                          // .toString());,
                        },
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      content(
                        content: controller.settingResponse.name ?? "",
                        // content: controller
                        //     .settingResponse.bankAccountName
                        //     .toString(),
                        title: "Tên tài khoản",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_4X,
                      ),
                      content(
                        content: controller.money.toString(),
                        title: "Số tiền",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.ONE_UNIT_SIZE * 60,
                    vertical: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_2X,
                    vertical: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_3X),
                        child:          IZIText(
                                     text:
                          "Nội dung chuyển khoản (bắt buộc)",
                          style: textStyleH6.copyWith(
                              fontFamily: 'Roboto',
                              color: ColorResources.NEUTRALS_2,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                        ),
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                               IZIText(
                                     text:
                            '${controller.contentTransaction} - chuyển khoản',
                            style: textStyleH6.copyWith(
                                fontFamily: 'Roboto',
                                color: ColorResources.COLOR_BLACK_TEXT,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("ádsadas");
                              controller.copyAccount(
                                  controller.contentTransaction ?? "XXX");
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_1X,
                              ),
                              child: const Icon(Icons.copy,
                                  color: ColorResources.NEUTRALS_4),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.ONE_UNIT_SIZE * 50),
                        child:  IZIText(
                                     text:
                          'Chụp màn hình giao dịch để cập nhật thông tin nhanh hơn',
                          maxLine: 2,
                    
                          textAlign: TextAlign.center,
                          style: textStyleSpan.copyWith(
                              fontFamily: 'Roboto',
                              color: ColorResources.RED,
                              fontWeight: FontWeight.w400,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_4X),
                  child: Row(
                    children: [
                    IZIText(
                                     text:
                        'Tải hình ảnh hóa đơn giao dịch',
                        maxLine: 4,
                        textAlign: TextAlign.center,
                        style: textStyleH6.copyWith(
                            color: ColorResources.BLACK,
                            fontWeight: FontWeight.w700,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                      const Text(
                        " *",
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      )
                    ],
                  ),
                ),
                // Hình ảnh của bạn
                SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.pickImage();
                        },
                        child: Container(
                          padding: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_3X,
                          ),
                          decoration: BoxDecoration(
                            color: ColorResources.NEUTRALS_6,
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BLUR_RADIUS_4X,
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(
                              IZIDimensions.SPACE_SIZE_1X,
                            ),
                            constraints: BoxConstraints(
                              maxWidth: IZIDimensions.ONE_UNIT_SIZE * 600,
                              maxHeight: IZIDimensions.ONE_UNIT_SIZE * 200,
                            ),
                            child: controller.files.isEmpty
                                ? IZIImage(ImagesPath.image_transaction)
                                : Image.file(
                                    controller.files.first,
                                    fit: BoxFit.contain,
                                    height: IZIDimensions.ONE_UNIT_SIZE * 200,
                                    width: IZIDimensions.ONE_UNIT_SIZE * 600,
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X * 3,
                ),
                IZIButton(
                  colorBG: ColorResources.ORANGE,
                  onTap: () {
                    controller.onSummit();
                  },
                  label: 'Xác nhận',
                  margin: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X,
                      bottom: IZIDimensions.SPACE_SIZE_4X),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget content({
    required String title,
    required String content,
    TextStyle? style,
    IconData? icon,
    Function? onTapIcon,
  }) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textStyleH6.copyWith(
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                fontWeight: FontWeight.w400,
                fontFamily: 'Roboto',
                color: ColorResources.PRIMARY_8,
              ),
            ),
          ],
        ),
        const Spacer(),
        if (icon != null)
          GestureDetector(
            onTap: () {
              if (onTapIcon != null) {
                onTapIcon();
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                left: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Icon(icon),
            ),
          ),
        Text(
          content,
          style: style ??
              textStyleH6.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorResources.NEUTRALS_2,
              ),
        ),
      ],
    );
  }
}
