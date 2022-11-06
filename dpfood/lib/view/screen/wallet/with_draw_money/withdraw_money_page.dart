import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/wallet/with_draw_money/withdraw_money_controller.dart';

class WithDrawMoneyPage extends GetView<WithDrawMoneyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      appBar: const IZIAppBar(
        title: "Rút tiền",
        colorTitle: ColorResources.WHITE,
      ),
      safeAreaBottom: false,
      body: GetBuilder(
        init: WithDrawMoneyController(),
        builder: (WithDrawMoneyController controller) {
          if (controller.isLoading) {
            return SizedBox(
              height: IZIDimensions.iziSize.height / 1.3,
              child: Center(
                child: spinKitWave,
              ),
            );
          }
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              color: ColorResources.WHITE,
              height: IZIDimensions.iziSize.height,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_3X,
                        vertical: IZIDimensions.SPACE_SIZE_3X),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 1),
                            blurRadius: 1,
                            spreadRadius: 0.1)
                      ],
                      // border: Border.all(color: ColorResources.GREY),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                          vertical: IZIDimensions.SPACE_SIZE_3X),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Số dư',
                                style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w600),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: IZIDimensions.SPACE_SIZE_1X),
                                  //so du
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      controller.obscure == false
                                          ? "${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.toString()))}đ"
                                          : controller.obscureCharacters,
                                      style: TextStyle(
                                          fontSize:
                                              IZIDimensions.FONT_SIZE_H6 * 1.3,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_1X),
                                child: GestureDetector(
                                  onTap: () {
                                    controller.onChangedIsVisible();
                                  },
                                  child: Icon(
                                    controller.obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                    size: IZIDimensions.FONT_SIZE_H6 * 1.5,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: IZIDimensions.SPACE_SIZE_3X),
                            child: Divider(
                              height: IZIDimensions.ONE_UNIT_SIZE * 7,
                              color: ColorResources.LIGHT_GREY,
                            ),
                          ),
                          Text(
                            'Nhập số dư cần rút',
                            style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                fontWeight: FontWeight.w300),
                          ),

                          TextField(
                            controller: controller.moneyRechargeController,
                            onChanged: (val) {
                              controller.onChangedValueAmount(val);
                            },
                            style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 2,
                                fontWeight: FontWeight.w600),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              errorText: controller.erroTextAmountToDeposit,
                              border: InputBorder.none,
                              suffix: Text(
                                'đ',
                                style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 1.2,
                                    fontWeight: FontWeight.w400,
                                    color: ColorResources.BLACK),
                              ),
                            ),
                          ),
                          Divider(
                            height: IZIDimensions.ONE_UNIT_SIZE * 7,
                            color: ColorResources.LIGHT_GREY,
                          ),
                          if (controller.isFirstValidateAmount == true &&
                              controller.isEnabledValidateAmount == true)
                            Container(
                              margin: EdgeInsets.only(
                                  top: IZIDimensions.SPACE_SIZE_1X),
                              alignment: Alignment.topLeft,
                              child: const Text(
                                'Số tiền không hợp lệ',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: ColorResources.RED,
                                ),
                              ),
                            ),

                          _btnAddMoney(),

                          // _btnAddMoney(),
                        ],
                      ),
                    ),
                  ),

                  _recipientInformation(),

                  // nhập tên tài khoản (bắt buộc)
                  Padding(
                    padding: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_3X,
                        right: IZIDimensions.SPACE_SIZE_3X,
                        left: IZIDimensions.SPACE_SIZE_3X,
                        bottom: IZIDimensions.SPACE_SIZE_3X),
                    child: IZIInput(
                      placeHolder: 'Nhập tên tài khoản bắt buộc (bắt buộc)',
                      type: IZIInputType.TEXT,
                      isBorder: true,
                      colorBorder: ColorResources.GREY,
                      disbleError: true,
                      initValue: controller.userRequest.bankAccountName,
                      onChanged: (val) {
                        controller.userRequest.bankAccountName = val;
                      },
                      suffixIcon: Icon(
                        Icons.person_add,
                        color: ColorResources.GREY,
                        size: IZIDimensions.FONT_SIZE_H6,
                      ),
                    ),
                  ),

                  //nhập số tài khoản nhận (bắt buộc)
                  Padding(
                    padding: EdgeInsets.only(
                        right: IZIDimensions.SPACE_SIZE_3X,
                        left: IZIDimensions.SPACE_SIZE_3X,
                        bottom: IZIDimensions.SPACE_SIZE_3X),
                    child: IZIInput(
                      onTap: () {},
                      placeHolder: 'Nhập số tài khoản cần nhận (bắt buộc)',
                      type: IZIInputType.PHONE,
                      isBorder: true,
                      colorBorder: ColorResources.GREY,
                      disbleError: true,
                      suffixIcon: Icon(
                        Icons.mode_edit_outline_rounded,
                        color: ColorResources.GREY,
                        size: IZIDimensions.FONT_SIZE_H6,
                      ),
                      initValue:
                          controller.userRequest.bankAccountNumber.toString(),
                      onChanged: (val) {
                        controller.userRequest.bankAccountNumber =
                            IZINumber.parseInt(val);
                      },
                    ),
                  ),

                  // nhập tên ngân hàng (bắt buộc)

                  Padding(
                    padding: EdgeInsets.only(
                      right: IZIDimensions.SPACE_SIZE_3X,
                      left: IZIDimensions.SPACE_SIZE_3X,
                    ),
                    child: IZIInput(
                      onTap: () {},
                      placeHolder: "Nhập tên ngân hàng (bắt buộc)",
                      type: IZIInputType.TEXT,
                      isBorder: true,
                      colorBorder: ColorResources.GREY,
                      disbleError: true,
                      suffixIcon: Icon(
                        Icons.mode_edit_outline_rounded,
                        color: ColorResources.GREY,
                        size: IZIDimensions.FONT_SIZE_H6,
                      ),
                      initValue: controller.userRequest.bankName,
                      onChanged: (val) {
                        controller.userRequest.bankName = val;
                      },
                    ),
                  ),

                  IZIButton(
                    // isEnabled: controller.isEnabledValidateAmount,
                    // colorBG: controller.isEnabledValidateAmount
                    //     ? ColorResources.YELLOW_PRIMARY
                    //     : ColorResources.GREY,
                    margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_3X,
                        vertical: IZIDimensions.SPACE_SIZE_3X * 3),
                    label: 'Rút tiền',
                    borderRadius: IZIDimensions.BLUR_RADIUS_3X,
                    onTap: () {
                      controller.goToWithdrawal(context);
                      // print()
                    },
                  )
                  // else
                  //   const SizedBox.shrink()
                  // thong tin người nhận
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container _recipientInformation() {
    return Container(
      width: IZIDimensions.iziSize.width,
      color: ColorResources.NEUTRALS_6,
      child: Padding(
        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
        child: Text(
          'Thông tin người nhận',
          style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_H6 * 1.3,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _btnAddMoney() {
    return Container(
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
        left: IZIDimensions.SPACE_SIZE_2X,
        right: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 175,
          mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 75,
          mainAxisSpacing: IZIDimensions.SPACE_SIZE_2X,
        ),
        itemCount: controller.defaultAmountList.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              controller.ontap(index);
              controller.setDefaultAmount(index);
              controller.inputMoney =
                  controller.defaultAmountList[index].toString();
            },
            child: Container(
              decoration: BoxDecoration(
                color: controller.selected == index
                    ? ColorResources.PRIMARY_1
                    : Colors.white,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_2X,
                ),
                border: Border.all(
                  color:
                      controller.selected == index ? Colors.white : Colors.grey,
                ),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Center(
                child: Text(
                  controller.defaultAmountList[index].toString(),
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6,
                    fontWeight: FontWeight.bold,
                    color: controller.selected == index
                        ? Colors.white
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
