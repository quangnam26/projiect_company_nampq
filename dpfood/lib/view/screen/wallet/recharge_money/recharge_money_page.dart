import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/wallet/recharge_money/recharge_money_controller.dart';

import '../../../../helper/izi_other.dart';

class RechargeMoneyPage extends GetView<RechargeMoneyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      appBar: const IZIAppBar(
        title: "Nạp tiền",
        colorTitle: ColorResources.WHITE,
      ),
      safeAreaBottom: false,
      body: GetBuilder(
        init: RechargeMoneyController(),
        builder: (RechargeMoneyController controller) {
          return GestureDetector(
            onTap: () {
              IZIOther.primaryFocus();
            },
            child: SingleChildScrollView(
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
                            Text(
                              'Nhập số tiền cần nạp',
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
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_H6 * 1.2,
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

                    SizedBox(
                      width: IZIDimensions.iziSize.width,
                      child: SizedBox(
                        height: IZIDimensions.ONE_UNIT_SIZE * 180,
                        width: IZIDimensions.ONE_UNIT_SIZE * 100,
                        child: IZIImage(
                          ImagesPath.banner_recharge_wallet,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    _recipientInformation(),
                    SizedBox(
                      height: IZIDimensions.ONE_UNIT_SIZE * 20,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_2X,
                          vertical: IZIDimensions.SPACE_SIZE_4X,
                        ),
                        margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_3X,
                          vertical: IZIDimensions.SPACE_SIZE_3X,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_2X,
                          ),
                          color: ColorResources.NEUTRALS_6,
                        ),
                        width: IZIDimensions.iziSize.width,
                        child: Row(
                          children: [
                            const Icon(
                              Icons.account_balance,
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            Text(
                              "Chuyển khoản ngân hàng",
                              style: textStyleH6.copyWith(
                                color: ColorResources.NEUTRALS_2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // const Spacer(),

                    IZIButton(
                      margin: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.SPACE_SIZE_3X,
                          vertical: IZIDimensions.SPACE_SIZE_3X * 3),
                      label: 'Nạp tiền',
                      borderRadius: IZIDimensions.BLUR_RADIUS_3X,
                      onTap: () {
                        controller.onGoToRequiredRecharge();
                      },
                    )
                    // else
                    //   const SizedBox.shrink()
                    // thong tin người nhận
                  ],
                ),
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
          'Nguồn tiền',
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
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
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
