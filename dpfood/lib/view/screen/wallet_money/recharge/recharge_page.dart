import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_dialog.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/wallet_money/recharge/recharge_controller.dart';

class ReChargePage extends GetView<ReChargeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
        isSingleChildScrollView: false,
        appBar: const IZIAppBar(
          title: "Rút tiền",
          colorTitle: ColorResources.WHITE,
        ),
        background: const BackgroundAppBar(),
        body: GetBuilder<ReChargeController>(
          builder: (reChargeCtrl) => SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  left: IZIDimensions.SPACE_SIZE_4X,
                  right: IZIDimensions.SPACE_SIZE_4X),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: IZIDimensions.SPACE_SIZE_2X),
                            padding:
                                EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    IZIDimensions.BORDER_RADIUS_4X),
                                color: ColorResources.WHITE),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IZIText(
                                        text: "Số dư:",
                                        style: TextStyle(
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_H6,
                                            fontWeight: FontWeight.w700,
                                            color: ColorResources.PRIMARY_2)),
                                    Row(
                                      children: [
                                        IZIText(
                                            text: "236,992đ",
                                            style: TextStyle(
                                                fontSize:
                                                    IZIDimensions.FONT_SIZE_H6,
                                                fontWeight: FontWeight.w700,
                                                color:
                                                ColorResources.ADDRESS_ORDER
                                                   
                                                    )),
                                        const Icon(Icons.visibility),
                                      ],
                                    )
                                  ],
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                reChargeCtrl.iziInput,
                                const Divider(
                                  thickness: 2,
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_3X),
                                  child: IZIListView(
                                      mainAxisExtent:
                                          IZIDimensions.ONE_UNIT_SIZE * 80,
                                      type: IZIListViewType.GRIDVIEW,
                                      crossAxisCount: 3,
                                      itemCount: reChargeCtrl.list.length,
                                      builder: (id) => IZIButton(
                                            type: IZIButtonType.OUTLINE,
                                            padding: EdgeInsets.zero,
                                            margin: EdgeInsets.only(
                                                bottom: IZIDimensions
                                                    .SPACE_SIZE_2X),
                                            onTap: () {
                                              print(reChargeCtrl.list[id]);
                                              reChargeCtrl.iziInput.iziState
                                                  .setValue(
                                                      reChargeCtrl.list[id]);
                                            },
                                            label: reChargeCtrl.list[id],
                                          )),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: IZIDimensions.SPACE_SIZE_3X),
                            child: IZIText(
                                text: "Thông tin người nhận",
                                style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    fontWeight: FontWeight.w700,
                                    color: ColorResources.PRIMARY_2)),
                          ),
                          Container(
                            padding:
                                EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                            decoration: const BoxDecoration(
                                color: ColorResources.WHITE),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      bottom: IZIDimensions.SPACE_SIZE_2X),
                                  child: IZIInput(
                                    suffixIcon: const Icon(Icons.person),
                                    isBorder: true,
                                    type: IZIInputType.TEXT,
                                    placeHolder: "Nhập tên tài khoản",
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: IZIDimensions.SPACE_SIZE_2X),
                                    child: IZIInput(
                                      isBorder: true,
                                      type: IZIInputType.TEXT,
                                      suffixIcon: const Icon(Icons.edit),
                                      placeHolder: "Nhập số tài khoản",
                                    )),
                                Container(
                                    margin: EdgeInsets.only(
                                        bottom: IZIDimensions.SPACE_SIZE_2X),
                                    child: IZIInput(
                                      suffixIcon: const Icon(Icons.edit),
                                      isBorder: true,
                                      type: IZIInputType.TEXT,
                                      placeHolder: "Nhập tên ngân hàng",
                                    )),
                                IZIButton(
                                  margin: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_3X,
                                      bottom: IZIDimensions.SPACE_SIZE_2X),
                                  onTap: () {
                                    IZIDialog.showDialog(
                                        description:
                                            "Bạn có chắc chắn rút tiền từ Ví tài khoản?",
                                        lable: "Xác nhận",
                                        onConfirm: () {
                                          Get.back();
                                          IZIDialog.showDialog(
                                              lable: "Rút tiền thành công ",
                                              onCancel: () {
                                                Get.back();
                                              },
                                              cancelLabel: "Thoát",
                                              description:
                                                  "Hệ thống đang kiểm duyệt,vui lòng chờ 1 - 2 ngày hoàn tất thủ tục");
                                        },
                                        onCancel: () {
                                          Get.back();
                                        });
                                  },
                                  label: "Rút tiền",
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
