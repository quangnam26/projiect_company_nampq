import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/reviewer/reviewer_controller.dart';

import '../../../base_widget/izi_loader_overlay.dart';
import '../../../helper/izi_other.dart';

class ReviewerPage extends GetView<ReviewerController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: const IZIAppBar(
        title: "Đánh giá",
        colorTitle: ColorResources.WHITE,
      ),
      isSingleChildScrollView: false,
      body: GetBuilder(
        builder: (ReviewerController controller) {
          return Obx(() {
            if (IZIValidate.nullOrEmpty(controller.orderResponse)) {
              return spinKitWave;
            }
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: GestureDetector(
                onTap: () {
                  IZIOther.primaryFocus();
                },
                child: Column(
                  children: [
                    itemOrders(controller),
                    Container(
                      padding: EdgeInsets.all(
                        IZIDimensions.SPACE_SIZE_4X,
                      ),
                      margin: EdgeInsets.only(
                        top: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      decoration: const BoxDecoration(
                        color: ColorResources.WHITE,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ratingIndex(controller),
                          ratingBarIndicatorWidget(controller),
                          whatYouLike(controller),
                          SizedBox(height: IZIDimensions.SPACE_SIZE_2X),
                          ask(controller),
                          sharePlusInput(controller),
                          uploadMultiImage(controller),
                          divider(),
                          shareFeeling(),
                          divider(),
                          sendButtonWidget(controller),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }

  ///
  /// Nơi đặt mua
  ///
  Widget itemOrders(ReviewerController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: IZIDimensions.SPACE_SIZE_5X * 2,
        right: IZIDimensions.SPACE_SIZE_5X,
      ),
      margin: EdgeInsets.only(
        right: IZIDimensions.SPACE_SIZE_2X,
      ),
      decoration: const BoxDecoration(color: ColorResources.WHITE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_1X,
                bottom: IZIDimensions.SPACE_SIZE_2X),
            child: IZIText(
              text: "Nơi mua hàng",
              style: TextStyle(
                  color: ColorResources.PRIMARY_2,
                  fontWeight: FontWeight.w700,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_5X),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.ONE_UNIT_SIZE * 10,
                  ),
                  child: SizedBox(
                    width: IZIDimensions.ONE_UNIT_SIZE * 140,
                    height: IZIDimensions.ONE_UNIT_SIZE * 140,
                    child: Image.network(
                      IZIValidate.nullOrEmpty(
                              controller.orderResponse.value.idUserShop!.banner)
                          ? ''
                          : controller.orderResponse.value.idUserShop!.banner
                              .toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                      child: IZIText(
                        text: IZIValidate.nullOrEmpty(controller
                                .orderResponse.value.idUserShop!.fullName)
                            ? ''
                            : controller
                                .orderResponse.value.idUserShop!.fullName
                                .toString(),
                        style: TextStyle(
                          color: ColorResources.PRIMARY_2,
                          fontWeight: FontWeight.w700,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: IZIText(
                        maxLine: 2,
                        text: IZIValidate.nullOrEmpty(controller
                                .orderResponse.value.idUserShop!.address)
                            ? ''
                            : controller.orderResponse.value.idUserShop!.address
                                .toString(),
                        style: TextStyle(
                          color: ColorResources.ADDRESS_ORDER,
                          fontWeight: FontWeight.w700,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        ),
                      ),
                    ),
                    IZIText(
                      text:
                          "${IZIValidate.nullOrEmpty(controller.orderResponse.value.idUserShop!.statitisReviews!.totalRating) ? '0' : controller.orderResponse.value.idUserShop!.statitisReviews!.totalRating} đánh giá",
                      style: TextStyle(
                        color: ColorResources.ADDRESS_ORDER,
                        fontWeight: FontWeight.w400,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  /// chỉ số rating bình chọn
  ///
  Widget ratingIndex(ReviewerController controller) {
    return Align(
      child: IZIText(
        text: "${controller.ratePoint.toString()}/5.0",
        style: TextStyle(
          color: ColorResources.NEUTRALS_1,
          fontWeight: FontWeight.w600,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
        ),
      ),
    );
  }

  ///
  /// select star rating
  ///
  Widget ratingBarIndicatorWidget(ReviewerController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
      alignment: Alignment.center,
      child: RatingBar.builder(
        initialRating: 5,
        itemPadding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_1X * 0.5,
        ),
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: (rating) {
          print(rating);
          controller.onChangeRatePoint(rating);
        },
      ),
    );
  }

  ///
  ///Điều gì làm bạn thích nhất
  ///
  Widget whatYouLike(ReviewerController controller) {
    return IZIListView(
      label: "Điều gì làm bạn thích nhất",
      labelStyle: TextStyle(
        fontSize: IZIDimensions.FONT_SIZE_SPAN,
        fontWeight: FontWeight.w600,
      ),
      type: IZIListViewType.GRIDVIEW,
      margin: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
      crossAxisCount: 3,
      mainAxisExtent: IZIDimensions.ONE_UNIT_SIZE * 120,
      itemCount: controller.list.length,
      mainAxisSpacing: 5,
      builder: (id) {
        final icon = controller.list[id]['image'];
        final bool isActive = controller.list[id]['isActive'] as bool;
        return GestureDetector(
          onTap: () => controller.onChangeReviewShop(id),
          child: Container(
            decoration: BoxDecoration(
              color: isActive
                  ? ColorResources.CIRCLE_COLOR_BG2
                  : ColorResources.WHITE,
              borderRadius: isActive
                  ? BorderRadius.circular(
                      IZIDimensions.ONE_UNIT_SIZE * 15,
                    )
                  : BorderRadius.zero,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_2X,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: IZIDimensions.SPACE_SIZE_2X,
                  ),
                  child: icon is IconData
                      ? Icon(
                          icon,
                          size: IZIDimensions.ONE_UNIT_SIZE * 52,
                          color: ColorResources.YELLOW,
                        )
                      : IZIImage(
                          controller.list[id]['image'].toString(),
                          height: IZIDimensions.ONE_UNIT_SIZE * 50,
                        ),
                ),
                IZIText(
                  text: controller.list[id]['title'].toString(),
                  style: TextStyle(
                    color: isActive
                        ? ColorResources.PRIMARY_2
                        : ColorResources.ADDRESS_ORDER,
                    fontWeight: FontWeight.w600,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget ask(ReviewerController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_4X,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Tài xế có đem đến trải nghiệm thú vị cho bạn không?",
            style: textStyleSpan,
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_2X,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  controller.onChangeReviewShipper();
                },
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.hand_thumbsup_fill,
                      color: controller.isSatisfied
                          ? ColorResources.PRIMARY_3
                          : ColorResources.NEUTRALS_4,
                      size: IZIDimensions.ONE_UNIT_SIZE * 60,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Hài lòng',
                      style: textStyleSpan,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.onChangeReviewShipper();
                },
                child: Column(
                  children: [
                    Icon(
                      CupertinoIcons.hand_thumbsdown_fill,
                      color: !controller.isSatisfied
                          ? ColorResources.PRIMARY_3
                          : ColorResources.NEUTRALS_4,
                      size: IZIDimensions.ONE_UNIT_SIZE * 60,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Không hài lòng',
                      style: textStyleSpan,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///
  ///chia sẻ thêm
  ///
  Container sharePlusInput(ReviewerController controller) {
    return Container(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_2X,
        bottom: IZIDimensions.SPACE_SIZE_3X,
      ),
      child: IZIInput(
        controller: controller.contentController,
        borderRadius: IZIDimensions.BORDER_RADIUS_4X,
        fillColor: ColorResources.ICON_RIGHT_ITEM_ACCOUNT,
        type: IZIInputType.TEXT,
        placeHolder: "Nhấn vào đây để chia sẻ thêm.......",
        onChanged: (val) {
          controller.contentController.text = val;
        },
      ),
    );
  }

  ///
  ///upload nhiều ảnh
  ///
  Container uploadMultiImage(ReviewerController controller) {
    return Container(
      margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_4X),
      child: controller.files.isEmpty
          ? GestureDetector(
              onTap: () => controller.pickMultiImage(),
              child: Container(
                margin: EdgeInsets.only(
                  right: IZIDimensions.SPACE_SIZE_4X,
                ),
                width: IZIDimensions.ONE_UNIT_SIZE * 150,
                height: IZIDimensions.ONE_UNIT_SIZE * 150,
                decoration: BoxDecoration(
                    color: ColorResources.NEUTRALS_7,
                    borderRadius: BorderRadius.circular(
                      IZIDimensions.ONE_UNIT_SIZE * 15,
                    )),
                child: Icon(
                  Icons.add_photo_alternate_outlined,
                  size: IZIDimensions.ONE_UNIT_SIZE * 55,
                ),
              ),
            )
          : IZIListView(
              physics: const ScrollPhysics(),
              scrollDirection: Axis.horizontal,
              height: IZIDimensions.ONE_UNIT_SIZE * 150,
              itemCount: controller.files.length,
              builder: (index) {
                return Row(
                  children: [
                    if (index == 0)
                      GestureDetector(
                        onTap: () => controller.pickMultiImage(),
                        child: Container(
                          margin: EdgeInsets.only(
                            right: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          width: IZIDimensions.ONE_UNIT_SIZE * 150,
                          height: IZIDimensions.ONE_UNIT_SIZE * 150,
                          decoration: BoxDecoration(
                              color: ColorResources.NEUTRALS_7,
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.ONE_UNIT_SIZE * 15,
                              )),
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: IZIDimensions.ONE_UNIT_SIZE * 55,
                          ),
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                      child: SizedBox(
                        width: IZIDimensions.ONE_UNIT_SIZE * 150,
                        height: IZIDimensions.ONE_UNIT_SIZE * 150,
                        child: Image.file(
                          controller.files[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
    );
  }

  ///
  ///divider
  ///
  Divider divider() {
    return const Divider(
      thickness: 2,
    );
  }

  ///
  ///chia sẻ cảm nhận
  ///
  Text shareFeeling() {
    return Text(
      'Chia sẻ cảm nhận, đánh giá để cửa hàng chúng tôi ngày càng hoàn thiện hơn. Rất cảm ơn quý khách hàng đã lựa chọn cửa hàng chúng tôi trong hàng ngàn cửa hàng ngoài kia',
      style: TextStyle(
        color: ColorResources.NEUTRALS_4,
        fontWeight: FontWeight.w500,
        fontSize: IZIDimensions.FONT_SIZE_SPAN,
      ),
    );
  }

  ///
  ///Nút gửi
  ///
  IZIButton sendButtonWidget(ReviewerController controller) {
    return IZIButton(
      margin: EdgeInsets.only(
        top: IZIDimensions.SPACE_SIZE_5X,
      ),
      onTap: () => controller.onSummit(),
      label: "Gửi",
    );
  }
}
