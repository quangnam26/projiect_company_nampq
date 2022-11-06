import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_app_bar.dart';

import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/wallet/wallet_money_controller.dart';

import '../../../../base_widget/izi_image.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_text_style.dart';
import '../components/transaction_card.dart';

class V2WalletMoneyPage extends GetView<V2WalletMoneyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: const IZIAppBar(
        title: "Ví tiền của tôi",
        colorTitle: ColorResources.WHITE,
      ),
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      safeAreaBottom: false,
      body: GetBuilder<V2WalletMoneyController>(
        builder: (walletCtrl) {
          return Container(
            color: ColorResources.NEUTRALS_7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_4X,
                  ),
                  margin: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.BLUR_RADIUS_2X,
                    ),
                    color: ColorResources.WHITE,
                    boxShadow: IZIOther().boxShadow,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Số dư',
                        style: textStyleH6,
                      ),
                      Obx(() {
                        return Row(
                          children: [
                            Text(
                              walletCtrl.visiable.isTrue ? walletCtrl.defaultAccount : '**********',
                              style: textStyleH6,
                            ),
                            SizedBox(
                              width: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.onChange();
                              },
                              child: Icon(
                                controller.visiable.isTrue
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: ColorResources.NEUTRALS_4,
                              ),
                            ),
                          ],
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_1X,
                ),
                SizedBox(
                  width: IZIDimensions.iziSize.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      recharge(
                        image: ImagesPath.NAP_TIEN_VAO_VI,
                        onTap: () {
                          controller.onGoReCharge();
                        },
                        title: "NẠP TIỀN",
                      ),
                      SizedBox(
                        width: IZIDimensions.ONE_UNIT_SIZE * 90,
                      ),
                      recharge(
                        image: ImagesPath.RECHARGE,
                        onTap: () {
                          controller.onGoWithDraw();
                        },
                        title: "RÚT TIỀN",
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(
                    IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: Text(
                    'Lịch sử giao dịch',
                    style: textStyleH5.copyWith(
                      color: ColorResources.NEUTRALS_2,
                      fontWeight: FontWeight.w600,
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
                    child: ListView.builder(
                      itemCount: walletCtrl.lichSuViTien.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            dateTitle(IZIDate.formatDate(IZIDate.parse(walletCtrl.lichSuViTien[index][0].createdAt!))),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: walletCtrl.lichSuViTien[index].length,
                              itemBuilder: (context, indexM) {
                                return TransactionCard(
                                    marginCard: EdgeInsets.fromLTRB(
                                      IZIDimensions.SPACE_SIZE_1X,
                                      indexM == 0 ? IZIDimensions.SPACE_SIZE_1X : 0,
                                      IZIDimensions.SPACE_SIZE_1X,
                                      0,
                                    ),
                                    colorBG: indexM % 2 == 0 ? ColorResources.WHITE : ColorResources.GREY.withOpacity(0.1),
                                    row1Left: walletCtrl.lichSuViTien[index][indexM].title,
                                    row2Left: IZIPrice.currencyConverterVND(double.parse(walletCtrl.lichSuViTien[index][indexM].money.toString())),
                                    row3Left: IZIDate.formatDate(IZIDate.parse(walletCtrl.lichSuViTien[index][indexM].createdAt!)),
                                    // Yêu cầu nạp tiền, Trạng thái thanh toán thất bại,  Yêu cầu rút tiền
                                    statusTypePayment: IZITYPEPAYMENT.NAP_VAO_RUT,
                                    status: walletCtrl.lichSuViTien[index][indexM].statusTransaction == 'failed'
                                        ? IZIStatus.FAIL
                                        : walletCtrl.lichSuViTien[index][indexM].statusTransaction == 'success'
                                            ? IZIStatus.SUCCESS
                                            : IZIStatus.NONE,
                                    statusMoney: walletCtrl.lichSuViTien[index][indexM].typeTransaction == 'withdraw' ? IZIStatusMoney.DRAW : IZIStatusMoney.RECHARGE,
                                    statusPayment: checkStatusPayment(status: walletCtrl.lichSuViTien[index][indexM].statusTransaction!));
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// recharge
  ///
  Widget recharge(
      {required String title, required Function onTap, required String image}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: SizedBox(
        // width: IZIDimensions.iziSize.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: IZIDimensions.ONE_UNIT_SIZE * 80,
              width: IZIDimensions.ONE_UNIT_SIZE * 80,
              child: IZIImage(
                image,
              ),
            ),
            SizedBox(
              height: IZIDimensions.SPACE_SIZE_1X,
            ),
            Text(
              title,
              style: textStyleSpan.copyWith(
                color: ColorResources.NEUTRALS_4,
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget dateTitle(String title) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
        vertical: IZIDimensions.ONE_UNIT_SIZE * 2,
      ),
      margin: EdgeInsets.only(
        right: IZIDimensions.SPACE_SIZE_2X,
        top: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 100,
        ),
        color: ColorResources.GREEN,
      ),
      child: Text(
        title, //historyTransactionMap.keys.toList()[index].toString(),
        style: TextStyle(
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          fontWeight: FontWeight.w500,
          color: ColorResources.WHITE,
        ),
      ),
    );
  }

  ///
  ///check status money
  ///
  checkStatusMoney(int index) {
    if (index == 0) {
      return IZIStatusMoney.DRAW;
    }
    return IZIStatusMoney.PLUS;
  }

  ///
  /// check status payment
  ///
  IZIStatusPayment checkStatusPayment({required String status}) {
    if (status == 'waiting') {
      return IZIStatusPayment.AWAIT;
    } else if (status == 'success') {
      return IZIStatusPayment.DONE;
    }
    return IZIStatusPayment.FAIL;
  }
}
