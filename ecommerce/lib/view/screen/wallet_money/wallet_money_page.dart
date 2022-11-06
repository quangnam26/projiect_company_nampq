import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/wallet_money/wallet_money_controller.dart';
import '../components/tracsaction_card.dart';

class WalletMoneyPage extends GetView<WalletMoneyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      safeAreaTop: false,
      body: GetBuilder<WalletMoneyController>(
        builder: (walletCtrl) => Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  height: IZIDimensions.ONE_UNIT_SIZE * 180,
                  color: ColorResources.ORANGE,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_2X,
                      top: IZIDimensions.SPACE_SIZE_3X * 3,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorResources.GREY.withOpacity(0.4),
                        ),
                        width: IZIDimensions.ONE_UNIT_SIZE * 50,
                        height: IZIDimensions.ONE_UNIT_SIZE * 50,
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorResources.WHITE,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.ONE_UNIT_SIZE * 90,
                ),
                Align(
                  child: SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 100,
                    width: IZIDimensions.ONE_UNIT_SIZE * 100,
                    child: IZIImage(
                      ImagesPath.artboard19,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.onGoReCharge();
                    // Get.toNamed(AccountRoutes.RECHARGE);
                  },
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_2X,
                          bottom: IZIDimensions.SPACE_SIZE_4X),
                      width: IZIDimensions.ONE_UNIT_SIZE * 280,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BLUR_RADIUS_2X,
                          ),
                          color: ColorResources.ORANGE),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: IZIDimensions.SPACE_SIZE_2X,
                          bottom: IZIDimensions.SPACE_SIZE_2X,
                        ),
                        child: Center(
                          child: IZIText(
                            text: "Nạp tiền",
                            style: textStyleH5.copyWith(
                              color: ColorResources.WHITE,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SmartRefresher(
                    controller: walletCtrl.refreshController,
                    onRefresh: () => walletCtrl.onRefresh(),
                    onLoading: () => walletCtrl.onLoading(),
                    enablePullUp: true,
                    header: const ClassicHeader(
                      idleText: "Kéo xuống để làm mới dữ liệu",
                      releaseText: "Thả ra để làm mới dữ liệu",
                      completeText: "Làm mới dữ liệu thành công",
                      refreshingText: "Đang làm mới dữ liệu",
                      failedText: "Làm mới dữ liệu bị lỗi",
                      canTwoLevelText: "Thả ra để làm mới dữ liệu",
                    ),
                    footer: const ClassicFooter(
                      loadingText: "Đang tải...",
                      noDataText: "Không có thêm dữ liệu",
                      canLoadingText: "Kéo lên để tải thêm dữ liệu",
                      failedText: "Tải thêm dữ liệu bị lỗi",
                      idleText: "Kéo lên để tải thêm dữ liệu",
                    ),
                    child: controller.lichSuViTien.isEmpty
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: IZIDimensions.SPACE_SIZE_4X,
                                        top: IZIDimensions.SPACE_SIZE_2X),
                                    child: IZIText(
                                      text:
                                          "Lịch sử giao dịch ", //historyTransactionMap.keys.toList()[index].toString(),
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              ColorResources.COLOR_BLACK_TEXT),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: IZIDimensions.iziSize.height * 0.3,
                                child: Center(
                                  child: IZIText(
                                    text: 'Không có dữ liệu',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      color: ColorResources.NEUTRALS_5,
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: walletCtrl.lichSuViTien.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // ignore: prefer_if_elements_to_conditional_expressions
                                  dateTitle(
                                    IZIDate.formatDate(
                                      IZIDate.parse(
                                        walletCtrl
                                            .lichSuViTien[index][0].createdAt!,
                                      ),
                                    ),
                                    'Lịch sử giao dịch ',
                                    index = index,
                                  ),
                                  // dateTitle(,),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        walletCtrl.lichSuViTien[index].length,
                                    itemBuilder: (context, indexM) {
                                      return TransactionCard(
                                          marginCard: EdgeInsets.fromLTRB(
                                            IZIDimensions.SPACE_SIZE_1X,
                                            indexM == 0
                                                ? IZIDimensions.SPACE_SIZE_1X
                                                : 0,
                                            IZIDimensions.SPACE_SIZE_1X,
                                            0,
                                          ),
                                          colorBG: indexM % 2 == 0
                                              ? ColorResources.WHITE
                                              : ColorResources.GREY
                                                  .withOpacity(0.1),
                                          row1Left: walletCtrl
                                              .lichSuViTien[index][indexM]
                                              .title,
                                          row2Left: IZIPrice.currencyConverterVND(
                                              double.parse(walletCtrl
                                                  .lichSuViTien[index][indexM]
                                                  .money
                                                  .toString())),
                                          row3Left: IZIDate.formatDate(IZIDate.parse(walletCtrl.lichSuViTien[index][indexM].createdAt.toString()).toLocal(),
                                              format: 'HH:mm - dd-mm-yyyy'),
                                          statusTypePayment:
                                              IZITYPEPAYMENT.NAP_VAO_RUT,
                                          status: walletCtrl.lichSuViTien[index][indexM].statusTransaction ==
                                                  'failed'
                                              ? IZIStatus.FAIL
                                              : walletCtrl.lichSuViTien[index][indexM].statusTransaction ==
                                                      'success'
                                                  ? IZIStatus.SUCCESS
                                                  : IZIStatus.NONE,
                                          statusMoney: walletCtrl.lichSuViTien[index][indexM].typeTransaction == 'withdraw'
                                              ? IZIStatusMoney.DRAW
                                              : IZIStatusMoney.RECHARGE,
                                          statusPayment: checkStatusPayment(status: walletCtrl.lichSuViTien[index][indexM].statusTransaction!));
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                  ),
                )
              ],
            ),
            Positioned.fill(
              top: IZIDimensions.ONE_UNIT_SIZE * 120,
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X * 2),
                  height: IZIDimensions.ONE_UNIT_SIZE * 130,
                  width: IZIDimensions.iziSize.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_2X,
                      ),
                      color: ColorResources.WHITE),
                  child: Align(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: IZIDimensions.SPACE_SIZE_4X,
                              left: IZIDimensions.SPACE_SIZE_2X,
                              bottom: IZIDimensions.SPACE_SIZE_2X),
                          child: IZIText(
                            text: "Số tiền trong ví",
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: ColorResources.COLOR_BLACK_TEXT2,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.onChangedIsVisible();
                                },
                                child: Icon(
                                  controller.obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: IZIDimensions.FONT_SIZE_H6 * 1.8,
                                ),
                              ),
                              SizedBox(
                                width: IZIDimensions.SPACE_SIZE_2X,
                              ),
                              IZIText(
                                text: controller.obscure == false
                                    ? "đ ${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.toString()))}"
                                    : controller.obscureCharacters,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: IZIDimensions.FONT_SIZE_H5),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dateTitle(String title, String title2, int index) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_2X),
            // ignore: unrelated_type_equality_checks
            child: index == 0
                ? IZIText(
                    text: title2,
                    style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  )
                : const SizedBox(),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_2X,
            vertical: IZIDimensions.ONE_UNIT_SIZE * 2,
          ),
          margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_2X,
            top: IZIDimensions.SPACE_SIZE_2X,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: ColorResources.PRIMARY_10,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: IZIText(
              text:
                  title, //historyTransactionMap.keys.toList()[index].toString(),
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                fontWeight: FontWeight.w500,
                color: ColorResources.WHITE,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///
///check status money
///
IZIStatusMoney checkStatusMoney(
  int index,
) {
  if (index == 0) {
    return IZIStatusMoney.DRAW;
  }
  return IZIStatusMoney.PLUS;
}

///
/// check status payment
///
IZIStatusPayment checkStatusPayment({required String status}) {
  if (status == 'WAITING') {
    return IZIStatusPayment.AWAIT;
  } else if (status == 'SUCCESS') {
    return IZIStatusPayment.DONE;
  }
  return IZIStatusPayment.FAIL;
}
