import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/routes/route_path/payment_methods_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/paymentmethods/domesticatmcard/domestic_atm_card_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../helper/izi_dimensions.dart';

class DomestiAtmCardPage extends GetView<DomestiAtmCardController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // safeAreaTop: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Thẻ ATM Nội địa ',
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

      // safeAreaBottom: false,
      body: GetBuilder(
        init: DomestiAtmCardController(),
        builder: (DomestiAtmCardController controller) {
          return Container(
            color: ColorResources.NEUTRALS_11,
            height: IZIDimensions.iziSize.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: IZIDimensions.SPACE_SIZE_4X,
                                top: IZIDimensions.SPACE_SIZE_3X,
                                right: IZIDimensions.SPACE_SIZE_4X,
                                bottom: IZIDimensions.SPACE_SIZE_1X),
                            decoration: BoxDecoration(
                                border: Border.all(color: ColorResources.GREY)),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                              child:
                                  IZIImage('assets/icons/ic_vietcombank 3.png'),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                "Vietcombank - Ngân hàng ngoại thương",
                                maxLines: 2,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8),
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),

                IZIButton(
                  margin: EdgeInsets.symmetric(
                    horizontal: IZIDimensions.SPACE_SIZE_4X * 1.5,
                    vertical: IZIDimensions.SPACE_SIZE_4X * 1.5,
                  ),
                  label: 'Hoàn thành',
                  onTap: () {
                    Get.toNamed(PaymentmethodsRoutes.ADD_CREDIT_CARD);
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
}
