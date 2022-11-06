import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/order/reviewer_order/reviewer_order_controller.dart';

class ReviewerOrderPage extends GetView<ReviewerOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
        background: const BackgroundAppBar(),
        appBar: IZIAppBar(
          title: 'Đánh giá sản phẩm ',
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
        body: GetBuilder(
            init: ReviewerOrderController(),
            builder: (ReviewerOrderController _) => GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_4X,
                            vertical: IZIDimensions.SPACE_SIZE_2X),
                        child: IZIText(
                            textAlign: TextAlign.center,
                            text:
                                "Thêm đánh giá sản phẩm mua hàng từ shop Để shop hoàn thiện hơn mỗi ngày. Cảm ơn bạn đã đồng hành cũng shop!",
                            maxLine: 3,
                            style: TextStyle(
                                fontFamily: 'Roboto',
                                color: ColorResources.ORANGE,
                                fontWeight: FontWeight.w400,
                                fontSize: IZIDimensions.FONT_SIZE_SPAN)),
                      ),
                      Container(
                        margin:
                            EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
                        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                        decoration:
                            const BoxDecoration(color: ColorResources.WHITE),
                        child: IntrinsicHeight(
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IZIImage(
                                controller
                                    .itemsOptionResponse.idProduct!.thumbnail!,
                                width: IZIDimensions.ONE_UNIT_SIZE * 100,
                                height: IZIDimensions.ONE_UNIT_SIZE * 100,
                              ),
                              Expanded(
                                flex: 2,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      left: IZIDimensions.SPACE_SIZE_2X),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      IZIText(
                                        text: controller.itemsOptionResponse
                                            .idProduct!.name!,
                                        maxLine: 2,
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            color: ColorResources.PRIMARY_9,
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_SPAN,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          IZIText(
                                            text:
                                                "${controller.itemsOptionResponse.idProduct!.price} đ",
                                            maxLine: 2,
                                            style: TextStyle(
                                                fontFamily: 'Roboto',
                                                color: ColorResources.PRICE,
                                                fontSize: IZIDimensions
                                                    .FONT_SIZE_SPAN,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomCenter,
                                child: IZIText(
                                  text:
                                      "x${controller.itemsOptionResponse.quantityPrices!.quantity}",
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: IZIDimensions.SPACE_SIZE_4X),
                        child: RatingBar.builder(
                          ignoreGestures: controller.existsCheck || false,
                          maxRating: 5,
                          tapOnlyMode: true,
                          initialRating: controller.rateNumber,
                          itemSize: IZIDimensions.ONE_UNIT_SIZE * 60,
                          allowHalfRating: true,
                          itemPadding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          updateOnDrag: true,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: IZIDimensions.ONE_UNIT_SIZE * 40,
                          ),
                          onRatingUpdate: (rating) {
                            controller.onChangeRate(rating);
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_4X),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: IZIButton(
                                isEnabled: !controller.existsCheck && true,
                                icon: Icons.camera,
                                borderRadius: 0,
                                withBorder: 1,
                                colorBG: ColorResources.ORANGE,
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_2X),
                                onTap: () {
                                  controller.pickImage();
                                },
                                label: 'Thêm hình ảnh',
                                type: IZIButtonType.OUTLINE,
                              ),
                            ),
                            Flexible(
                              child: IZIButton(
                                isEnabled: !controller.existsCheck && true,
                                borderRadius: 0,
                                icon: Icons.videocam,
                                withBorder: 1,
                                colorBG: ColorResources.ORANGE,
                                color: Colors.transparent,
                                margin: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_2X),
                                onTap: () {
                                  controller.pickVideo();
                                },
                                label: 'Thêm video',
                                type: IZIButtonType.OUTLINE,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: IZIDimensions.SPACE_SIZE_4X,
                            right: IZIDimensions.SPACE_SIZE_4X,
                            bottom: IZIDimensions.SPACE_SIZE_5X),
                        child: IZIInput(
                          allowEdit: !controller.existsCheck && true,
                          type: IZIInputType.MILTIPLINE,
                          maxLine: 3,
                          onChanged: (v) {},
                          fillColor: ColorResources.WHITE,
                          placeHolder:
                              'Hãy chia sẻ những điểu bạn thích ở sản phẩm này nhé',
                        ),
                      ),
                      if (controller.existsCheck)
                        const SizedBox()
                      else
                        IZIButton(
                          margin: EdgeInsets.only(
                            left: IZIDimensions.SPACE_SIZE_4X,
                            right: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          borderRadius: IZIDimensions.BORDER_RADIUS_3X,
                          colorBG: ColorResources.ORANGE,
                          onTap: () {
                            controller.addReview();
                          },
                          label: 'Đánh giá',
                        )
                    ],
                  ),
                )));
  }
}
