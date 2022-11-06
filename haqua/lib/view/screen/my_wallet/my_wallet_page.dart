import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_smart_refresher.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/%20my_wallet/%20my_wallet_controller.dart';
import 'package:template/view/screen/%20my_wallet/component/custom_izi_cart.dart';

class MyWalletPage extends GetView<MyWalletController> {
  const MyWalletPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: IZIAppBar(
        title: 'vi_tien_cua_toi'.tr,
      ),
      body: GetBuilder(
        init: MyWalletController(),
        builder: (MyWalletController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  vertical: IZIDimensions.SPACE_SIZE_3X * 1.2,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                ),
                // color: Colors.amber,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_3X, vertical: IZIDimensions.SPACE_SIZE_3X),
                  child: Column(
                    children: [
                      // số dư
                      _surplus(controller),

                      Container(
                        margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
                        child: Divider(height: IZIDimensions.ONE_UNIT_SIZE * 7, color: ColorResources.GREY),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          /// Recharge money.
                          _customColum(
                            onTap: () {
                              controller.goToRechargePage();
                            },
                            title: 'nap_tien'.tr,
                            image1: IZIImage(ImagesPath.icon_nap_tien),
                          ),

                          /// Withdraw money.
                          _customColum(
                            onTap: () {
                              controller.goWithDrawMoney();
                            },
                            title: 'rut_tien'.tr,
                            image1: IZIImage(ImagesPath.icon_rut_tien),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_3X * 1.2,
                ),
                child: Text(
                  'lich_su_giao_dich'.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  ),
                ),
              ),
              Expanded(
                child: Obx(() => _rechargeHistory(
                      controller,
                      ontap: () {},
                    )),
              )
            ],
          );
        },
      ),
    );
  }

  ///
  /// History my wallet.
  ///
  Widget _rechargeHistory(MyWalletController controller, {required VoidCallback ontap}) {
    return SizedBox(
      height: IZIDimensions.iziSize.height,
      child: IZISmartRefresher(
        enablePullUp: true,
        enablePullDown: true,
        refreshController: controller.refreshController,
        onRefresh: controller.onRefresh,
        onLoading: controller.onLoading,
        child: SingleChildScrollView(
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.historyTransactionMap.length,
            itemBuilder: (context, index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_1X * 0.7, horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(IZIDimensions.BLUR_RADIUS_4X),
                      color: ColorResources.BUTTON_DEFAULT,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_2X,
                        vertical: IZIDimensions.ONE_UNIT_SIZE * 10,
                      ),
                      child: Text(
                        controller.historyTransactionMap.keys.toList()[index].toString(),
                        style: TextStyle(
                          color: ColorResources.WHITE,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        ),
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.historyTransactionMap.values.toList()[index].length,
                    itemBuilder: (context, j) {
                      return CustomIZICart(
                        onTap: () {
                          controller.goToDetailTransaction(
                            controller.historyTransactionMap.values.toList()[index][j].id.toString(),
                          );
                        },
                        marginCard: EdgeInsets.fromLTRB(
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          index == 0 ? IZIDimensions.SPACE_SIZE_1X : 0,
                          IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                          IZIDimensions.SPACE_SIZE_2X,
                        ),
                        row1Left: controller.historyTransactionMap.values.toList()[index][j].title.toString(),
                        row2Left: IZIPrice.currencyConverterVND(
                          IZINumber.parseDouble(controller.historyTransactionMap.values.toList()[index][j].money),
                        ).toString(),
                        row3Left: IZIDate.formatDate(
                          controller.historyTransactionMap.values.toList()[index][j].createdAt!.toLocal(),
                          format: "HH:mm dd/MM/yyyy",
                        ),
                        statusTransaction: controller.genStatusPayment(
                          controller.historyTransactionMap.values.toList()[index][j].statusTransaction.toString(),
                        ),
                        typeTransaction: controller.genStatusMoney(
                          controller.historyTransactionMap.values.toList()[index][j].typeTransaction.toString(),
                        ),
                        methodTransaction: controller.genMethodTransaction(
                          controller.historyTransactionMap.values.toList()[index][j].methodTransaction.toString(),
                        ),
                      );
                    },
                  )
                ],
              );
            },
          ),
        ),
      ),
      // ),
    );
    // );
  }

  ///
  /// Info surplus.
  ///
  Widget _surplus(MyWalletController controller) {
    return Row(
      children: [
        Text(
          'so_du'.tr,
          style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        Obx(() => Padding(
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
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_1X),
          // so du
          child: Align(
            alignment: Alignment.centerRight,
            child: Obx(() => Text(
                  controller.obscure.value == false ? "${IZIPrice.currencyConverterVND(double.parse(controller.accountBalance.value.toString()))} VNĐ" : controller.obscureCharacters.value,
                  style: TextStyle(
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ),
      ],
    );
  }

//
// custom vi tiền
//
  Widget _customColum({
    required String title,
    required Widget image1,
    required Function onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            // color: Colors.amber,
            height: IZIDimensions.ONE_UNIT_SIZE * 100,
            width: IZIDimensions.ONE_UNIT_SIZE * 100,
            child: image1,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            fontWeight: FontWeight.w600,
          ),
        )
      ],
    );
  }
}
