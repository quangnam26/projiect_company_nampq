import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/%20my_wallet/%20transactiondetails/%20transaction_details_controller.dart';
import 'package:template/view/screen/%20my_wallet/%20transactiondetails/custom_background.dart';

class TransactionDetailsPage extends GetView<TransactionDetailsController> {
  const TransactionDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const CustomBackGround(),
      appBar: IZIAppBar(
        title: 'Transaction_details'.tr,
      ),
      body: GetBuilder(
        init: TransactionDetailsController(),
        builder: (TransactionDetailsController controller) {
          return Container(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            color: ColorResources.PRIMARY_APP,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    IZIDimensions.BLUR_RADIUS_5X,
                  ),
                  topRight: Radius.circular(
                    IZIDimensions.BLUR_RADIUS_5X,
                  ),
                ),
                color: ColorResources.WHITE,
              ),
              child: controller.isLoading
                  ? Center(
                      child: IZILoading().isLoadingKit,
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_5X * 1.4,
                              vertical: IZIDimensions.SPACE_SIZE_5X,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: IZIDimensions.iziSize.width,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_2X),
                                        height: IZIDimensions.ONE_UNIT_SIZE * 70,
                                        width: IZIDimensions.ONE_UNIT_SIZE * 70,
                                        child: IZIImage(
                                          controller.genImageTypeTransaction(),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              controller.transactionResponse.title.toString(),
                                              style: TextStyle(
                                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_1X),
                                              child: controller.genTextAmount(),
                                            ),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Trading_code'.tr,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w300,
                                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                ),
                                                children: [
                                                  WidgetSpan(
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        top: IZIDimensions.SPACE_SIZE_1X,
                                                      ),
                                                      child: Text(
                                                        controller.transactionResponse.id.toString(),
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w600,
                                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // giao dịch
                          _transaction(controller, context)
                        ],
                      ),
                    ),
            ),
          );
        },
      ),
      //
    );
  }

  Widget _transaction(TransactionDetailsController controller, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X * 1.4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: IZIDimensions.iziSize.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BLUR_RADIUS_3X,
              ),
              color: ColorResources.CARD_CAPITAL_CONTRIBUTION.withOpacity(.8),
            ),
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
              horizontal: IZIDimensions.SPACE_SIZE_3X,
            ),
            child: controller.getStatusTransaction(
              controller.transactionResponse.statusTransaction.toString(),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Payment_time'.tr,
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    ),
                  ),
                ),
                Text(
                  IZIDate.formatDate(
                    controller.transactionResponse.createdAt!.toLocal(),
                    format: "HH:mm dd/MM/yyyy",
                  ),
                  style: TextStyle(
                    color: ColorResources.COLOR_BLACK_TEXT,
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Funds'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    ),
                  ),
                ),
                controller.genMoneySource(),
              ],
            ),
          ),
          if (!IZIValidate.nullOrEmpty(controller.transactionResponse.content))
            Padding(
              padding: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: SizedBox(
                width: IZIDimensions.iziSize.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Content'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      controller.transactionResponse.content.toString(),
                      style: TextStyle(
                        color: ColorResources.COLOR_BLACK_TEXT,
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (!IZIValidate.nullOrEmpty(controller.transactionResponse.transactionImage))
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Text(
                      'Transaction_pictures'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.goToPreviewImage(imageUrl: controller.transactionResponse.transactionImage.toString());
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_3X,
                      ),
                      child: IZIImage(
                        controller.transactionResponse.transactionImage.toString(),
                        width: IZIDimensions.iziSize.width,
                        height: IZIDimensions.iziSize.width / 9 * 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          IZIDimensions.BLUR_RADIUS_2X,
                        ),
                        topRight: Radius.circular(
                          IZIDimensions.BLUR_RADIUS_2X,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_2X,
                            bottom: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          child: Container(
                            height: IZIDimensions.ONE_UNIT_SIZE * 5,
                            width: IZIDimensions.ONE_UNIT_SIZE * 100,
                            decoration: BoxDecoration(
                              color: ColorResources.BLACK,
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.BLUR_RADIUS_5X,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Contact_support'.tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: const Divider(
                            height: 5,
                            color: ColorResources.GREY,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'contact_tilte_1'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: IZIDimensions.SPACE_SIZE_2X,
                                  bottom: IZIDimensions.SPACE_SIZE_2X,
                                ),
                                child: Text(
                                  'contact_tilte_2'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                  ),
                                ),
                              ),
                              Text(
                                'XXXX-XXXX-XXXX',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                ),
                              )
                            ],
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_4X,
                            vertical: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          child: IZIButton(
                            onTap: () {
                              controller.callHotLine(
                                '123456789',
                              );
                            },
                            label: 'Contact_support'.tr,
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(IZIDimensions.ONE_UNIT_SIZE * 50),
                color: ColorResources.LIGHT_YELLOW,
              ),
              child: Padding(
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_3X,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: IZIDimensions.ONE_UNIT_SIZE * 10,
                      ),
                      child: IZIImage(
                        'assets/images/contact.png',
                      ),
                    ),
                    Text(
                      'Contact_support'.tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.LABEL_ORDER_DANG_GIAO,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
