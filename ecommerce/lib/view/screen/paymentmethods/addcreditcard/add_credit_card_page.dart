import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../helper/izi_dimensions.dart';

class AddCreditCardPage extends GetView<PaymentMethodsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // safeAreaTop: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Thêm thẻ tín dụng/ghi nợ',
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.NEUTRALS_3,
          ),
        ),
      ),
      safeAreaBottom: false,
      body: GetBuilder(
        init: PaymentMethodsController(),
        builder: (PaymentMethodsController controller) {
          return Container(
            color: ColorResources.NEUTRALS_11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Divider(
                //   height: 5,
                //   color: ColorResources.ORDER_DANG_GIAO,
                // ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_3X,
                      vertical: IZIDimensions.SPACE_SIZE_3X),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Thêm thông tin thẻ",
                          style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      IZIImage('assets/icons/ic_visacard.png')
                    ],
                  ),
                ),
                customIZIInput(
                    label: 'Số thẻ', placeHolder: 'NHẬP SỐ IN TRÊN THẺ'),

                customIZIInput(
                    label: 'Tên chủ thẻ', placeHolder: 'NHẬP TÊN IN TRÊN THẺ'),
                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: customIZIInput(
                          label: 'Ngày hết hạn',
                          placeHolder: 'NHẬP NGÀY HẾT HẠN'),
                    ),
                    Expanded(
                        flex: 4,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_2X),
                          child: customIZIInput(
                              label: 'CVV', placeHolder: 'NHẬP MÃ CVV'),
                        )),
                  ],
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: IZIDimensions.SPACE_SIZE_4X,
                      right: IZIDimensions.SPACE_SIZE_4X),
                  child: Text(
                    "Thông tin thẻ của bạn được lưu bởi CyberSoucre, công ty  quản lý thanh toán lớn nhất thể giới (thuộctổ chức VISA)",
                    style: TextStyle(
                      height: 1.5,
                      fontSize: IZIDimensions.FONT_SIZE_H6,
                      fontWeight: FontWeight.w400,
                      color: ColorResources.NEUTRALS_5,
                    ),
                  ),
                ),

                const Spacer(),
                IZIButton(
                  margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X * 1.5,
                      vertical: IZIDimensions.SPACE_SIZE_4X * 1.5),
                  label: 'Đăng Nhập ',
                  onTap: () {},
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
