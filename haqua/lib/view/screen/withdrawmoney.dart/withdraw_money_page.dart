import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/thousands_separator_input_formatter_currency.dart';
import 'package:template/view/screen/withdrawmoney.dart/withdraw_money_controller.dart';

class WithDrawMoneyPage extends GetView<WithDrawMoneyController> {
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
            title: "rut_tien".tr,
          ),
          body: GetBuilder(
            init: WithDrawMoneyController(),
            builder: (WithDrawMoneyController controller) {
              if (controller.isLoading) {
                return SizedBox(
                  height: IZIDimensions.iziSize.height / 1.3,
                  child: Center(
                    child: IZILoading().isLoadingKit,
                  ),
                );
              }
              return SizedBox(
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN, vertical: IZIDimensions.SPACE_SIZE_3X),
                        decoration: BoxDecoration(
                          color: ColorResources.WHITE,
                          borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X, vertical: IZIDimensions.SPACE_SIZE_3X),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'so_du'.tr,
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_1X),
                                      //so du
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          controller.obscure == false ? "${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.toString()))} VNĐ" : controller.obscureCharacters,
                                          style: TextStyle(
                                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                            fontWeight: FontWeight.w700,
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
                                        controller.obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
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
                                'nhap_so tien_cap_nap'.tr,
                                style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_SPAN, fontWeight: FontWeight.w300),
                              ),
                              TextField(
                                controller: controller.moneyRechargeController,
                                onChanged: (val) {
                                  controller.onChangedValueAmount(val);
                                },
                                inputFormatters: [
                                  ThousandsSeparatorInputFormatterCurrency(),
                                ],
                                focusNode: controller.focusNodeInput,
                                style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6 * 2, fontWeight: FontWeight.w600),
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
                              if (controller.isEnabledValidateAmount == true)
                                Container(
                                  margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "so_tien_khong_hop_le".tr,
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
                      ),

                      _recipientInformation(),

                      // nhập tên tài khoản (bắt buộc)
                      Padding(
                        padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X, right: IZIDimensions.PADDING_HORIZONTAL_SCREEN, left: IZIDimensions.PADDING_HORIZONTAL_SCREEN, bottom: IZIDimensions.SPACE_SIZE_3X),
                        child: IZIInput(
                          placeHolder: "nhap_ten_tai_khoan_bat_buoc".tr,
                          type: IZIInputType.TEXT,
                          isBorder: true,
                          colorBorder: ColorResources.GREY,
                          disbleError: true,
                          errorText: controller.errorTextNameAccount,
                          validate: (val) {
                            controller.onValidateNameAccount(val);
                            return null;
                          },
                          onChanged: (val) {
                            controller.onChangeValueNameAccount(val);
                          },
                          suffixIcon: Icon(
                            Icons.person_add,
                            color: ColorResources.GREY,
                            size: IZIDimensions.FONT_SIZE_H6,
                          ),
                          textInputAction: TextInputAction.next,
                          initValue: controller.initValueNameAccount,
                          focusNode: controller.focusNodeInputAccountName,
                        ),
                      ),

                      //nhập số tài khoản nhận (bắt buộc)
                      Padding(
                        padding: EdgeInsets.only(
                          right: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          left: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          bottom: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        child: IZIInput(
                          placeHolder: "nhap_so_tai_khoan_nhan".tr,
                          type: IZIInputType.TEXT,
                          isBorder: true,
                          colorBorder: ColorResources.GREY,
                          disbleError: true,
                          suffixIcon: Icon(
                            Icons.mode_edit_outline_rounded,
                            color: ColorResources.GREY,
                            size: IZIDimensions.FONT_SIZE_H6,
                          ),
                          errorText: controller.errorTextBankNumberAccount,
                          validate: (val) {
                            controller.onValidateBankNumberAccount(val);
                            return null;
                          },
                          onChanged: (val) {
                            controller.onChangeValueBankNumberAccount(val);
                          },
                          textInputAction: TextInputAction.next,
                          initValue: controller.initValueNumberAccount,
                          focusNode: controller.focusNodeInputAccountNumber,
                        ),
                      ),

                      // nhập tên ngân hàng (bắt buộc)
                      Padding(
                        padding: EdgeInsets.only(
                          right: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          left: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        ),
                        child: IZIInput(
                          placeHolder: "nhap_ten_ngan_hang".tr,
                          type: IZIInputType.TEXT,
                          isBorder: true,
                          colorBorder: ColorResources.GREY,
                          disbleError: true,
                          suffixIcon: Icon(
                            Icons.mode_edit_outline_rounded,
                            color: ColorResources.GREY,
                            size: IZIDimensions.FONT_SIZE_H6,
                          ),
                          errorText: controller.errorTextNameBank,
                          validate: (val) {
                            controller.onValidateBankName(val);
                            return null;
                          },
                          onChanged: (val) {
                            controller.onChangeValueBankName(val);
                          },
                          textInputAction: TextInputAction.done,
                          initValue: controller.initValueNameBank,
                          focusNode: controller.focusNodeInputBankName,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          widgetBottomSheet: GetBuilder(
            init: WithDrawMoneyController(),
            builder: (WithDrawMoneyController controller) {
              if (controller.isLoading) {
                return Center(
                  child: IZILoading().isLoadingKit,
                );
              }
              if (controller.isFocusAccountName == true || controller.isFocusAccountNumber == true || controller.isFocusBankName == true) {
                return const SizedBox();
              }
              return SizedBox(
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height * .08,
                child: Column(
                  children: [
                    if (controller.isFocus == false && controller.isFocusAccountName == false && controller.isFocusAccountNumber == false && controller.isFocusBankName == false)
                      IZIButton(
                        isEnabled: controller.genIsEnableButton(),
                        margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                        ),
                        label: 'rut_tien'.tr,
                        borderRadius: IZIDimensions.BLUR_RADIUS_5X,
                        onTap: () {
                          controller.goToWithdrawal();
                        },
                      ),
                    if (controller.isFocus == true)
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
              );
            },
          ),
        ),
      ),
    );
  }

  ///
  ///_recipientInformation
  ///
  Container _recipientInformation() {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.NEUTRALS_6,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.PADDING_HORIZONTAL_SCREEN),
        child: Text(
          'thong_tin_nguoi_nhan'.tr,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
