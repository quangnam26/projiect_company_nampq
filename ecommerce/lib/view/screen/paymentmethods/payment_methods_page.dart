import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/routes/route_path/payment_methods_routes.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_controller.dart';
import '../../../base_widget/background/backround_appbar.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../helper/izi_dimensions.dart';

class PaymentMethodsPage extends GetView<PaymentMethodsController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      // safeAreaTop: false,
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Phương thức thanh toán',
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
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: controller.menusPay.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: controller.menusPay[index]['onTap'] as Function(),
                      child: Container(
                        margin:
                            EdgeInsets.only(left: IZIDimensions.SPACE_SIZE_4X),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: IZIDimensions.SPACE_SIZE_2X),
                                  child: IZIImage(
                                    '${controller.menusPay[index]['image']}',
                                  ),
                                ),
                                SizedBox(
                                  width: IZIDimensions.SPACE_SIZE_4X,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: IZIDimensions.SPACE_SIZE_1X),
                                      child: Text(
                                        '${controller.menusPay[index]['title']}',
                                        style: TextStyle(
                                          fontSize:
                                              IZIDimensions.FONT_SIZE_H6 * 0.9,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: IZIDimensions.SPACE_SIZE_2X,
                                    ),
                                    if (controller.menusPay[index]['title1'] !=
                                            '' &&
                                        controller.menusPay[index]['image2'] ==
                                            '')
                                      Text(
                                        '${controller.menusPay[index]['title1']}',
                                        style: TextStyle(
                                          fontSize:
                                              IZIDimensions.FONT_SIZE_H6 * 0.9,
                                          color: ColorResources.NEUTRALS_4,
                                        ),
                                      )
                                    else if (controller.menusPay[index]
                                                ['title1'] ==
                                            '' &&
                                        controller.menusPay[index]['image2'] !=
                                            '')
                                      // else if (controller.menusPay[index][''] != '')
                                      IZIImage(
                                          '${controller.menusPay[index]['image2']}')
                                    else
                                      const SizedBox.shrink()

                                    // IZIImage(
                                    //   '${controller.menusPay[index]['iamge2']}',
                                    // )
                                  ],
                                ),
                              ],
                            ),
                            if (index == 4)
                              Container()
                            else
                              Container(
                                margin: EdgeInsets.only(
                                    top: IZIDimensions.SPACE_SIZE_4X),
                                child: const Divider(
                                  height: 3,
                                  color: ColorResources.NEUTRALS_5,
                                ),
                              )
                          ],
                        ),
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
                    Get.toNamed(PaymentmethodsRoutes.DOMESTIC_ATM_CARD);
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
