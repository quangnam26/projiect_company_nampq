import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/payment_for_people_answer_ques/payment_for_people_answer_ques_controller.dart';

import '../../../base_widget/izi_screen.dart';

class PaymentForPeopleAnswerQuesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(
        title: "payment".tr,
      ),
      body: GetBuilder(
        init: PaymentForPeopleAnswerQuesController(),
        builder: (PaymentForPeopleAnswerQuesController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return Container(
            color: ColorResources.BACKGROUND,
            width: IZIDimensions.iziSize.width,
            child: Column(
              children: [
                //Amount Account
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.ONE_UNIT_SIZE * 50,
                    IZIDimensions.SPACE_SIZE_5X,
                    IZIDimensions.ONE_UNIT_SIZE * 50,
                    IZIDimensions.SPACE_SIZE_5X,
                  ),
                  width: IZIDimensions.iziSize.width,
                  decoration: BoxDecoration(
                    color: ColorResources.AMOUNT_ACCOUNT,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BORDER_RADIUS_3X,
                    ),
                  ),
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: _amountAccount(controller),
                ),

                //Infor Account Payment
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.SPACE_SIZE_2X,
                    0,
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: _inforAccountPayment(controller),
                ),

                //Amount Transaction
                Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.SPACE_SIZE_2X,
                    0,
                    IZIDimensions.SPACE_SIZE_2X,
                    IZIDimensions.SPACE_SIZE_3X,
                  ),
                  child: _amountTransaction(controller),
                ),

                SizedBox(
                  height: SPACE_BOTTOM_SHEET,
                ),
              ],
            ),
          );
        },
      ),
      widgetBottomSheet: GetBuilder(
        init: PaymentForPeopleAnswerQuesController(),
        builder: (PaymentForPeopleAnswerQuesController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return IZIButton(
            margin: EdgeInsets.fromLTRB(
              IZIDimensions.SPACE_SIZE_2X,
              0,
              IZIDimensions.SPACE_SIZE_2X,
              IZIDimensions.SPACE_SIZE_2X,
            ),
            onTap: () {
              controller.onGoToRechargePage();
            },
            label: "payment".tr,
          );
        },
      ),
    );
  }

  ///
  ///Amount Account
  ///
  Row _amountAccount(PaymentForPeopleAnswerQuesController controller) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: IZIImage(
            ImagesPath.amount_account,
          ),
        ),
        Text(
          "surplus".tr,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            fontWeight: FontWeight.w600,
          ),
        ),

        //Amount Account
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                controller.isHide == true ? controller.amountAccountHide : controller.amountAccount,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Text(
          " VNĐ",
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            fontWeight: FontWeight.w600,
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.onChangeHideAmountAccount();
          },
          child: Container(
            margin: EdgeInsets.only(
              left: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Icon(
              controller.isHide == true ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            ),
          ),
        ),
      ],
    );
  }

  ///
  ///Infor Account Payment
  ///
  Column _inforAccountPayment(PaymentForPeopleAnswerQuesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: Text(
            "account_information".tr,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_3X,
          ),
          width: IZIDimensions.iziSize.width,
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(
              IZIDimensions.BORDER_RADIUS_2X,
            ),
            border: Border.all(
              width: IZIDimensions.ONE_UNIT_SIZE * 1,
              color: ColorResources.GREY,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        "account_name".tr,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        "phone_number".tr,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      "content_billing".tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: const Icon(
                      Icons.hdr_strong_outlined,
                      color: ColorResources.PRIMARY_APP,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: const Icon(
                      Icons.hdr_strong_outlined,
                      color: ColorResources.PRIMARY_APP,
                    ),
                  ),
                  const Icon(
                    Icons.hdr_strong_outlined,
                    color: ColorResources.PRIMARY_APP,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        controller.userResponse.fullName.toString(),
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        IZIOther().formatPhoneNumber(controller.userResponse.phone.toString()),
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Text(
                      "Thanh toán chi phí tạo câu hỏi",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  ///Amount Transaction
  ///
  Column _amountTransaction(PaymentForPeopleAnswerQuesController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_1X,
          ),
          child: Text(
            "transaction_amount".tr,
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
              color: ColorResources.BLACK,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(
            IZIDimensions.SPACE_SIZE_3X,
          ),
          width: IZIDimensions.iziSize.width,
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(
              IZIDimensions.BORDER_RADIUS_2X,
            ),
            border: Border.all(
              width: IZIDimensions.ONE_UNIT_SIZE * 1,
              color: ColorResources.GREY,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        "amount_of_money".tr,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Text(
                      "transaction_fee".tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    child: const Icon(
                      Icons.hdr_strong_outlined,
                      color: ColorResources.PRIMARY_APP,
                    ),
                  ),
                  const Icon(
                    Icons.hdr_strong_outlined,
                    color: ColorResources.PRIMARY_APP,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionRequest.moneyTo.toString()))}VNĐ",
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          color: ColorResources.BLACK,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Text(
                      "0 VNĐ",
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
