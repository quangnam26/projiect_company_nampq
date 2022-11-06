import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/wallet_money/wallet_money_controller.dart';
import 'package:template/helper/izi_dimensions.dart';

class WalletMoneyPage extends GetView<WalletMoneyController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: const IZIAppBar(
        title: "Ví tiền của tôi",
        colorTitle: ColorResources.WHITE,
      ),
      background: const BackgroundAppBar(),
      body: GetBuilder<WalletMoneyController>(
        builder: (walletCtrl) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_3X, left: IZIDimensions.SPACE_SIZE_3X, right: IZIDimensions.SPACE_SIZE_3X, bottom: IZIDimensions.SPACE_SIZE_5X * 1.5),
              padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X, vertical: IZIDimensions.SPACE_SIZE_3X),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X), color: ColorResources.WHITE, boxShadow: const [BoxShadow(blurRadius: 4)]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const IZIText(text: "Số dư:"),
                  Row(
                    children: const [
                      IZIText(text: "236,992đ"),
                      Icon(Icons.visibility),
                    ],
                  )
                ],
              ),
            ),
            Align(
              child: SizedBox(
                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                width: IZIDimensions.ONE_UNIT_SIZE * 90,
                child: IZIImage(
                  ImagesPath.artboard17,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            IZIButton(
              color: Colors.transparent,
              colorBG: Colors.transparent,
              colorText: ColorResources.BLACK,
              margin: EdgeInsets.zero,
              onTap: () {
                walletCtrl.onGotozReCharge();
              },
              label: "Rút tiền",
            ),
            Padding(
              padding: EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_5X),
              child: IZIText(
                text: "Lịch sử giao dịch",
                style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w700, color: ColorResources.PRIMARY_2),
              ),
            ),
            IZIListView(
              itemCount: walletCtrl.list.length,
              builder: (id) => Column(
                children: [
                  Align(alignment: Alignment.topRight, child: Container(decoration: BoxDecoration(color: ColorResources.GREEN, borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_7X)), padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X), margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X), child: IZIText(text: walletCtrl.list[id]['date'].toString(), style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_SPAN, fontWeight: FontWeight.w700, color: ColorResources.WHITE)))),
                  Container(
                    margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_2X),
                    child: IZIListView(
                      itemCount: (walletCtrl.list[id]['order'] as List).length,
                      builder: (id2) => Container(
                        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                        decoration: BoxDecoration(
                            border: Border(
                              top: const BorderSide(
                                width: 0.6,
                                color: ColorResources.NEUTRALS_5,
                              ),
                              bottom: id2 == (walletCtrl.list[id]['order'] as List).length - 1 ? const BorderSide(
                                width: 0.6,
                                color: ColorResources.NEUTRALS_5,
                              ) : BorderSide.none
                            ),
                            color: id2 % 2 == 0 ? ColorResources.WHITE : Colors.transparent),
                        child: IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    SizedBox(
                                      child: IZIImage(
                                        ImagesPath.artboard18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: IZIDimensions.ONE_UNIT_SIZE * 40,
                                      height: IZIDimensions.ONE_UNIT_SIZE * 40,
                                      child: IZIImage(
                                        walletCtrl.list[id]['order'][id2]['icon_status'].toString(),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                      child: IZIText(
                                        text: walletCtrl.list[id]['order'][id2]["title"].toString(),
                                        style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_H6, fontWeight: FontWeight.w700, color: ColorResources.PRIMARY_2),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                                      child: IZIText(
                                        text: walletCtrl.list[id]['order'][id2]["dateTime"].toString(),
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                          fontWeight: FontWeight.w400,
                                          color: ColorResources.ADDRESS_ORDER,
                                        ),
                                      ),
                                    ),
                                    IZIText(text: walletCtrl.list[id]['order'][id2]["status"].toString(), style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_SPAN, fontWeight: FontWeight.w400, color: walletCtrl.list[id]['order'][id2]["color_price"] as Color))
                                  ],
                                ),
                              ),
                              Container(
                                alignment: AlignmentDirectional.bottomEnd,
                                child: IZIText(
                                  text: walletCtrl.list[id]['order'][id2]["price"].toString(),
                                  style: TextStyle(fontSize: IZIDimensions.FONT_SIZE_SPAN * 1.5, fontWeight: FontWeight.w400, color: walletCtrl.list[id]['order'][id2]["color_price"] as Color),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
