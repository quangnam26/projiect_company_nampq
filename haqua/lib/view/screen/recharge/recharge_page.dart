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
import 'package:template/utils/thousands_separator_input_formatter_currency.dart';
import 'package:template/view/screen/recharge/recharge_controller.dart';

class RechargePage extends GetView<RechargeController> {
  const RechargePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: IZIScreen(
          isSingleChildScrollView: false,
          background: const BackgroundApp(),
          appBar: IZIAppBar(
            title: "recharge".tr,
          ),
          body: GetBuilder(
            init: RechargeController(),
            builder: (RechargeController controller) {
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Surplus money.
                      _surplusMoney(controller),

                      /// Funds.
                      _titleFunds(),

                      /// Transfer money.
                      _bankTransfer(
                        context,
                        indexradio: 0,
                        radiotext: 1,
                        text1: 'bank_transfer'.tr,
                        text2: 'via_bank_account'.tr,
                        image1: SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 40,
                          width: IZIDimensions.ONE_UNIT_SIZE * 40,
                          child: Center(
                            child: IZIImage(
                              ImagesPath.icon_bank_transfer,
                            ),
                          ),
                        ),
                        controller: controller,
                      ),

                      /// Link Momo wallet.
                      _bankTransfer(
                        context,
                        indexradio: 1,
                        radiotext: 2,
                        text1: 'MoMo_wallet_link'.tr,
                        text2: 'Top_up_via_your_MoMo_account'.tr,
                        image1: SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 40,
                          width: IZIDimensions.ONE_UNIT_SIZE * 40,
                          child: Center(
                            child: IZIImage(
                              ImagesPath.icon_momo_transfer,
                            ),
                          ),
                        ),
                        controller: controller,
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          widgetBottomSheet: GetBuilder(
            init: RechargeController(),
            builder: (RechargeController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              return Obx(() => SizedBox(
                    width: IZIDimensions.iziSize.width,
                    height: IZIDimensions.iziSize.height * .08,
                    child: Column(
                      children: [
                        if (controller.isFocus.value == false)
                          IZIButton(
                            isEnabled: controller.genIsEnableButton(),
                            margin: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                            ),
                            label: "recharge".tr,
                            borderRadius: IZIDimensions.BLUR_RADIUS_5X,
                            onTap: () {
                              controller.goToBankTransfer();
                            },
                          ),
                        if (controller.isFocus.value == true)
                          Container(
                            margin: EdgeInsets.only(
                              top: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ...List.generate(
                                  controller.defaultAmountList.length,
                                  (index) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.setDefaultAmount(index);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          vertical: IZIDimensions.SPACE_SIZE_2X,
                                          horizontal: IZIDimensions.SPACE_SIZE_3X,
                                        ),
                                        decoration: BoxDecoration(
                                          color: ColorResources.PRIMARY_APP,
                                          borderRadius: BorderRadius.circular(
                                            IZIDimensions.BORDER_RADIUS_3X,
                                          ),
                                          // border: Border.all(
                                          //   color: ColorResources.PRIMARY_APP,
                                          //   width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                          // ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.defaultAmountList[index].toString())),
                                            style: TextStyle(
                                              color: ColorResources.WHITE,
                                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox()
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }

//
// nguồn tiền
//
  Container _titleFunds() {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.NEUTRALS_6,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.PADDING_HORIZONTAL_SCREEN),
        child: Text(
          'source_of_money'.tr,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

//
// số dư
//
  Widget _surplusMoney(RechargeController controller) {
    return Obx(() => Container(
          margin: EdgeInsets.symmetric(
            horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
            vertical: IZIDimensions.SPACE_SIZE_3X,
          ),
          decoration: BoxDecoration(
            color: ColorResources.WHITE,
            borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),

            // border: Border.all(color: ColorResources.GREY),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_2X,
              vertical: IZIDimensions.SPACE_SIZE_3X,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'surplus'.tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        // an so tien
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            controller.obscure.value == false ? "${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.value.toString()))} VNĐ" : controller.obscureCharacters.value,
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_1X),
                      child: GestureDetector(
                        onTap: () {
                          controller.onChangedIsVisible();
                        },
                        child: Icon(
                          controller.obscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          size: IZIDimensions.FONT_SIZE_H6 * 1.5,
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_3X),
                  child: Divider(
                    height: IZIDimensions.ONE_UNIT_SIZE * 7,
                    color: ColorResources.LIGHT_GREY,
                  ),
                ),
                Text(
                  'import_amount_money'.tr,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                TextField(
                  onChanged: (val) {
                    controller.onChangedValueAmount(val);
                  },
                  inputFormatters: [
                    ThousandsSeparatorInputFormatterCurrency(),
                  ],
                  focusNode: controller.focusNodeInput,
                  controller: controller.moneyRechargeController,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    suffix: Text(
                      'VNĐ',
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        fontWeight: FontWeight.w400,
                        color: ColorResources.BLACK,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: IZIDimensions.ONE_UNIT_SIZE * 7,
                  color: ColorResources.LIGHT_GREY,
                ),
                if (controller.isFirstValidateAmount.value == true && controller.isEnabledValidateAmount.value == true)
                  Container(
                    margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "validate_import_money_1".tr,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        color: ColorResources.RED,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }

//
// chuyển khoản ngân hàng
//
  Padding _bankTransfer(
    BuildContext context, {
    required String text1,
    required String text2,
    required Widget image1,
    required int indexradio,
    required int radiotext,
    required RechargeController controller,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: IZIDimensions.PADDING_HORIZONTAL_SCREEN, right: IZIDimensions.PADDING_HORIZONTAL_SCREEN, top: IZIDimensions.SPACE_SIZE_3X),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorResources.LIGHT_GREY,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                  child: image1,
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: Text(
                        text1,
                        style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      text2,
                      style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
                      ),
                    ),
                  ],
                ),
              ),
              _customRadio(indexradio, radiotext, controller)
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
            child: Divider(
              height: IZIDimensions.ONE_UNIT_SIZE * 7,
              color: ColorResources.LIGHT_GREY,
            ),
          )
        ],
      ),
    );
  }

//
// radio button
//
  Widget _customRadio(int index, int value, RechargeController controller) {
    return Obx(() => Radio(
          value: controller.radioIndex[index],
          groupValue: controller.select.value,
          onChanged: (Value) {
            controller.onClickRadioButton(index);
          },
          fillColor: MaterialStateProperty.all(
            ColorResources.PRIMARY_APP,
          ),
        ));
  }
}
