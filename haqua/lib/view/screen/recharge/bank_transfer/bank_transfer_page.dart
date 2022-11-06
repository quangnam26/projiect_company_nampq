import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/recharge/bank_transfer/bank_transfer_controller.dart';

import '../../../../utils/app_constants.dart';

class BankTransferPage extends GetView<BankTransferPageController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundApp(),
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: "bank_transfer".tr,
      ),
      body: GetBuilder(
        init: BankTransferPageController(),
        builder: (BankTransferPageController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    ),
                    child: Column(
                      children: [
                        if (controller.transferType == TRANSFERS) _imageBank(),

                        // thông tin giao dịch
                        Container(
                          margin: EdgeInsets.only(
                            top: controller.transferType != TRANSFERS ? IZIDimensions.SPACE_SIZE_3X : 0,
                          ),
                          child: _informationTransaction(controller),
                        ),

                        // nội dung chuyển khoản
                        _transferContent(),

                        Container(
                          margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_4X),
                          child: Center(
                            child: Text(
                              'validate_bank_transfer_1'.tr,
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.7, color: ColorResources.RED),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  // text giao dịch
                  _titel(),

                  Container(
                    margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_4X, horizontal: IZIDimensions.SPACE_SIZE_4X),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.pickImage();
                            },
                            child: Container(
                              // padding: EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.center,
                              child: controller.fileTranslation != null
                                  ? Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                                          child: SizedBox(
                                            height: IZIDimensions.iziSize.width / 9 * 16,
                                            width: IZIDimensions.iziSize.width,
                                            child: Image.file(
                                              controller.fileTranslation!,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: SizedBox(
                                            height: IZIDimensions.ONE_UNIT_SIZE * 150,
                                            width: IZIDimensions.ONE_UNIT_SIZE * 170,
                                            child: Image.asset(
                                              "assets/images/Artboard 15.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_3X),
                                          child: Text(
                                            "Click_here_to_upload".tr,
                                            textAlign: TextAlign.center,
                                          ),
                                        )
                                      ],
                                    ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'validate_bank_transfer_2'.tr,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.7, color: ColorResources.RED),
                  ),
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  IZIButton(
                    isEnabled: controller.genIsEnableButton(),
                    margin: EdgeInsets.symmetric(
                      vertical: IZIDimensions.SPACE_SIZE_4X,
                      horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    ),
                    label: 'cofirm'.tr,
                    borderRadius: IZIDimensions.BLUR_RADIUS_5X,
                    onTap: () {
                      controller.rechargeMoney(context);
                      // controller.showDialogLogin(context);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

//
//text giao dịch
//
  Container _titel() {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.NEUTRALS_6,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.PADDING_HORIZONTAL_SCREEN),
        child: Text(
          'Pictures_of_successful'.tr,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
          ),
        ),
      ),
    );
  }

//
// thông tin giao dịch
//
  Widget _imageBank() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_3X),
      child: IZIImage(ImagesPath.icon_the_ngan_hang),
    );
  }

//
// nội dung chuyển khoản
//
  Widget _transferContent() {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
      decoration: BoxDecoration(
        color: ColorResources.WHITE,
        borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN, vertical: IZIDimensions.SPACE_SIZE_3X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_3X),
              child: RichText(
                text: TextSpan(
                  text: 'Transfer_Contents'.tr,
                  style: const TextStyle(color: ColorResources.BLACK, fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(
                      text: '(${'Unmarked'.tr})',
                      style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.w200, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${controller.userResponse.fullName} - ${controller.depositAmount}',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: IZIDimensions.FONT_SIZE_H6),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.onBtnCopy(
                      content: '${controller.userResponse.fullName} - ${controller.depositAmount}',
                    );
                  },
                  child: Icon(Icons.copy, size: IZIDimensions.SPACE_SIZE_3X * 1.5, color: ColorResources.GREEN),
                ),
                Text(
                  'coppy'.tr,
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
              child: Divider(
                height: IZIDimensions.ONE_UNIT_SIZE * 7,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _informationTransaction(BankTransferPageController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_3X,
          vertical: IZIDimensions.SPACE_SIZE_3X,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'transaction_information'.tr,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'cardholders_name_username'.tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    controller.settingResponse.bankAccountName.toString(),
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Divider(
              height: IZIDimensions.ONE_UNIT_SIZE * 7,
              color: ColorResources.GREY,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Account_number'.tr,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onBtnCopy(content: controller.settingResponse.bankAccountNumber.toString());
                    },
                    child: Icon(Icons.copy, size: IZIDimensions.SPACE_SIZE_3X * 1.5, color: ColorResources.GREEN),
                  ),
                  Text(
                    'coppy'.tr,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            controller.settingResponse.bankAccountNumber.toString(),
                            textAlign: TextAlign.end,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: IZIDimensions.ONE_UNIT_SIZE * 7,
              color: ColorResources.GREY,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
              child: controller.transferType == TRANSFERS
                  ? Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'bank'.tr,
                              style: TextStyle(fontWeight: FontWeight.w500, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                              child: Text(
                                controller.settingResponse.bankName.toString(),
                                style: TextStyle(fontWeight: FontWeight.w400, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.7, color: ColorResources.YELLOW_PRIMARY),
                              ),
                            )
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IZIImage(
                          ImagesPath.icon_momo_transfer,
                          width: IZIDimensions.ONE_UNIT_SIZE * 60,
                          height: IZIDimensions.ONE_UNIT_SIZE * 60,
                        ),
                        IZIButton(
                          padding: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_1X,
                            horizontal: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          label: 'Chuyển ngay',
                          iconRight: Icons.arrow_forward_ios,
                          width: IZIDimensions.iziSize.width * .4,
                          colorBG: ColorResources.MOMO_TRANSACTION,
                          onTap: () {
                            controller.onBtnOpenLink();
                          },
                        ),
                      ],
                    ),
            ),
            Divider(
              height: IZIDimensions.ONE_UNIT_SIZE * 7,
              color: ColorResources.GREY,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
                  child: Text(
                    'Amount_to_transfer'.tr,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                  ),
                ),
                const Spacer(),
                Text(
                  "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.depositAmount))}VNĐ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: IZIDimensions.FONT_SIZE_H6 * .9, color: ColorResources.GREEN),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
