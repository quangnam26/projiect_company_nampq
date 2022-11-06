import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/wallet/required_recharge.dart/required_recharge_controller.dart';

import '../../../../base_widget/izi_image.dart';

class RequiredRechargePage extends GetView<RequiredRechargeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      appBar: const IZIAppBar(
        title: "Chuyển khoản ngân hàng",
        colorTitle: ColorResources.WHITE,
      ),
      safeAreaBottom: false,
      body: GetBuilder(
        init: RequiredRechargeController(),
        builder: (RequiredRechargeController controller) {
          return controller.isLoading
              ? const IZILoaderOverLay(body: CircularProgressIndicator())
              : Container(
                  color: ColorResources.NEUTRALS_7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                          IZIDimensions.SPACE_SIZE_4X,
                        ),
                        color: ColorResources.WHITE,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Thông tin tài khoản",
                              style: textStyleH6.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorResources.NEUTRALS_2,
                              ),
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            content(
                              content: controller.settingResponse.bankName
                                  .toString(),
                              title: "Ngân hàng nhận",
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            content(
                                content: controller
                                    .settingResponse.bankAccountNumber
                                    .toString(),
                                title: "Số tài khoản",
                                icon: Icons.copy,
                                onTapIcon: () {
                                  controller.copyAccount(controller
                                      .settingResponse.bankAccountNumber
                                      .toString());
                                }),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            content(
                              content: controller
                                  .settingResponse.bankAccountName
                                  .toString(),
                              title: "Tên tài khoản",
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            content(
                              content: controller.money.toString(),
                              title: "Số tiền",
                              style: textStyleH6.copyWith(
                                color: ColorResources.PRIMARY_1,
                              ),
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
                          children: [
                            Text(
                              "Nội dung chuyển khoản (bắt buộc)",
                              style: textStyleH6.copyWith(
                                color: ColorResources.NEUTRALS_2,
                              ),
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.contentTransaction,
                                  style: textStyleH6.copyWith(
                                    color: ColorResources.NEUTRALS_2,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.copyAccount(
                                        controller.contentTransaction);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: IZIDimensions.SPACE_SIZE_1X,
                                    ),
                                    child: const Icon(
                                      Icons.copy,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            Text(
                              'Vui lòng điền đúng nội dung chuyển khoản, nếu có sai sót chúng tôi sẽ không chịu trách nhiệm',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: textStyleSpan.copyWith(
                                color: ColorResources.RED,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.ONE_UNIT_SIZE * 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Hình ảnh của bạn
                      Container(
                        width: IZIDimensions.iziSize.width,
                        child: Column(
                          children: [
                            Text(
                              'Hình ảnh giao dịch của bạn',
                              maxLines: 4,
                              textAlign: TextAlign.center,
                              style: textStyleH6.copyWith(
                                color: ColorResources.NEUTRALS_1,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            GestureDetector(
                              onTap: () => controller.pickImage(),
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
                                    maxWidth: IZIDimensions.ONE_UNIT_SIZE * 200,
                                    maxHeight:
                                        IZIDimensions.ONE_UNIT_SIZE * 200,
                                  ),
                                  child: controller.files.isEmpty
                                      ? IZIImage(ImagesPath.image_transaction)
                                      : Image.file(
                                          controller.files.first,
                                          fit: BoxFit.contain,
                                          height:
                                              IZIDimensions.ONE_UNIT_SIZE * 200,
                                          width:
                                              IZIDimensions.ONE_UNIT_SIZE * 200,
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            Container(
                              child: Text(
                                'Chụp màn hình giao dịch\nđể cập nhật thông tin nhanh hơn',
                                maxLines: 4,
                                textAlign: TextAlign.center,
                                style: textStyleH6.copyWith(
                                  color: ColorResources.RED,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_4X * 3,
                      ),
                      IZIButton(
                        onTap: () => controller.onSummit(),
                        label: 'Xác nhận',
                        margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_4X,
                        ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: textStyleH6.copyWith(
                fontWeight: FontWeight.w400,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
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
          ],
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
