import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/wallet_money/recharge/recharge_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../helper/izi_price.dart';

class ReChargePage extends GetView<ReChargeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
          title: 'Nạp tiền',
          iconBack: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: ColorResources.NEUTRALS_3,
            ),
          )),

      // background: const BackgroundAppBar(),
      body: GetBuilder<ReChargeController>(
        builder: (controller) => SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                left: IZIDimensions.SPACE_SIZE_4X,
                right: IZIDimensions.SPACE_SIZE_4X),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: IZIDimensions.SPACE_SIZE_2X),
                              child: IZIText(
                                  text: "Số dư tài khoản:",
                                  style: TextStyle(
                                    fontFamily: 'Roboto',
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                    fontWeight: FontWeight.w400,
                                  )),
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.onChangedIsVisible();
                                  },
                                  child: Icon(
                                    controller.obscure
                                        ? Icons.visibility_off_outlined
                                        : Icons.visibility_outlined,
                                  ),
                                ),
                                SizedBox(
                                  width: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                IZIText(
                                  text: controller.obscure == false
                                      ? "${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.toString()))} đ"
                                      : controller.obscureCharacters,
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_3X,
                              vertical: IZIDimensions.SPACE_SIZE_3X),
                          decoration: BoxDecoration(
                            color: ColorResources.WHITE,
                            borderRadius: BorderRadius.circular(
                                IZIDimensions.BLUR_RADIUS_2X),
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
                                IZIText(
                                  text: 'Nhập số tiền cần nạp',
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_H6 * 0.9,
                                      fontWeight: FontWeight.w600,
                                      color: ColorResources.COLOR_BLACK_TEXT),
                                ),

                                TextField(
                                  controller:
                                      controller.moneyRechargeController,
                                  onChanged: (val) {
                                    controller.onChangedValueAmount(val);
                                  },
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 2,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  keyboardType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                  decoration: InputDecoration(
                                    hintText: 'Số tiền (vnđ)',
                                    hintStyle: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_H6 * 0.9,
                                        color: ColorResources.NEUTRALS_17,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Roboto'),
                                    errorText:
                                        controller.erroTextAmountToDeposit,
                                    border: InputBorder.none,
                                    suffix: Text(
                                      'VNĐ',
                                      style: TextStyle(
                                        fontSize:
                                            IZIDimensions.FONT_SIZE_H6 * 1.2,
                                        fontWeight: FontWeight.w400,
                                        color: ColorResources.BLACK,
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: IZIDimensions.ONE_UNIT_SIZE * 10,
                                  color: ColorResources.GREY,
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: IZIDimensions.SPACE_SIZE_3X),
                          child: IZIText(
                              text: "Nguồn tiền",
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  fontWeight: FontWeight.w700,
                                  color: ColorResources.PRIMARY_2)),
                        ),
                        Container(
                          padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BLUR_RADIUS_2X),
                              color: ColorResources.WHITE),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IZIImage('assets/icons/ic_banks.png'),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: IZIDimensions.SPACE_SIZE_2X),
                                child: IZIText(
                                  text: "Chuyển khoản ngân hàng",
                                  style: TextStyle(
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      fontSize: IZIDimensions.FONT_SIZE_H6),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      widgetBottomSheet: IZIButton(
        margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_4X,
            left: IZIDimensions.SPACE_SIZE_3X,
            right: IZIDimensions.SPACE_SIZE_3X),
        onTap: () {
          controller.onGoToRequiredRecharge();
        },
        label: "Tiếp tục",
        colorBG: ColorResources.ORANGE,
      ),
    );
  }

  Widget _btnAddMoney() {
    return Container(
      padding: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 175,
          mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 70,
          mainAxisSpacing: IZIDimensions.SPACE_SIZE_2X,
        ),
        itemCount: controller.list.length,
        itemBuilder: (BuildContext ctx, index) {
          return GestureDetector(
            onTap: () {
              // controller.ontap(index);
              controller.setDefaultAmount(index);
              controller.inputMoney = controller.list[index].toString();
              print(
                  "obbb ${controller.inputMoney = controller.list[index].toString()}");
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BORDER_RADIUS_2X,
                ),
                border: Border.all(
                  color: Colors.orange,
                ),
              ),
              child: Center(
                child: IZIText(
                  text: controller.list[index].toString(),
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                    fontWeight: FontWeight.w400,
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
