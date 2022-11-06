import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/shippingmethod/shipping_method_controller.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../base_widget/background/backround_appbar.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../base_widget/izi_text.dart';

class ShipperMethodPage extends GetView<ShipperMethodController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        widthIconBack: IZIDimensions.iziSize.width,
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Row(
            children: [
              const Icon(
                Icons.arrow_back_ios,
                color: ColorResources.NEUTRALS_3,
                size: 18,
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              IZIText(
                text: "Phương thức vận chuyển",
                style: TextStyle(
                    color: ColorResources.PRIMARY_2,
                    fontWeight: FontWeight.w700,
                    fontSize: IZIDimensions.FONT_SIZE_H6),
              )
            ],
          ),
        ),
        title: '',
      ),
      safeAreaBottom: false,
      body: GetBuilder(
        init: ShipperMethodController(),
        builder: (ShipperMethodController controller) {
          return Container(
            color: ColorResources.NEUTRALS_11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  height: 5,
                  color: ColorResources.ORDER_DANG_GIAO,
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_4X,
                          right: IZIDimensions.SPACE_SIZE_4X,
                          top: IZIDimensions.SPACE_SIZE_4X),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BLUR_RADIUS_2X,
                          ),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_4X,
                              vertical: IZIDimensions.SPACE_SIZE_3X,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "Giao hàng nhanh",
                                    style: textStyleH6.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: IZIDimensions.FONT_SIZE_H6),
                                  ),
                                ),
                                Text(
                                  "500.000 đ",
                                  style: textStyleH6.copyWith(
                                      fontSize:
                                          IZIDimensions.FONT_SIZE_H6 * 0.9,
                                      color: ColorResources.RED,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_4X,
                                bottom: IZIDimensions.SPACE_SIZE_3X),
                            child: Text(
                              "Nhận hàng vào 15/03 - 17/03\nCho phép thanh toán khi nhận hàng",
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                  fontWeight: FontWeight.w300,
                                  color: ColorResources.NEUTRALS_4,
                                  height: 1.5),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: IZIDimensions.SPACE_SIZE_4X,
                                left: IZIDimensions.SPACE_SIZE_4X,
                                bottom: IZIDimensions.SPACE_SIZE_4X),
                            child: const DottedLine(
                                dashLength: 5.0,
                                dashColor: ColorResources.WHITE3),
                          )
                        ],
                      ),
                    );
                  },
                ),

                const Spacer(),
                IZIButton(
                  margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X * 1.5,
                      vertical: IZIDimensions.SPACE_SIZE_4X * 1.5),
                  label: 'Hoàn thành',
                  onTap: () {
                    // Get.toNamed(PaymentmethodsRoutes.DOMESTIC_ATM_CARD);
                  },
                  colorBG: ColorResources.ORANGE,
                  borderRadius: IZIDimensions.BLUR_RADIUS_2X,
                )

                //  tỉnh/tp
              ],
            ),
          );
        },
      ),
    );
  }

  Widget customIZIInput({required String label, required String placeHolder}) {
    return Container(
      margin: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_3X,
          bottom: IZIDimensions.SPACE_SIZE_3X),
      child: Column(
        children: [
          IZIInput(
            type: IZIInputType.TEXT,
            label: label,
            placeHolder: placeHolder,
            fillColor: ColorResources.NEUTRALS_11,
          ),
          const Divider(
            height: 3,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
