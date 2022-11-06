import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'history_order_controller.dart';

class HistoryOrderPage extends GetView<HistoryOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: const IZIAppBar(
        title: "Lịch sử đơn hàng",
        colorTitle: ColorResources.WHITE,
      ),
      background: const BackgroundAppBar(),
      isSingleChildScrollView: false,
      body: GetBuilder(
        builder: (HistoryOrderController controller) {
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Obx(() {
              if (controller.orderResponse.isEmpty) {
                return spinKitWave;
              }
              return SizedBox(
                child: SmartRefresher(
                  controller: controller.refreshController,
                  onRefresh: () => controller.onRefresh(),
                  onLoading: () => controller.onLoading(),
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
                  child: SingleChildScrollView(
                      child: IZIListView(
                    itemCount: controller.orderResponse.length,
                    builder: (id) {
                      return GestureDetector(
                        onTap: () {
                          controller.onGotoDetail(
                              order: controller.orderResponse[id]);
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
                          padding: EdgeInsets.symmetric(
                              horizontal: IZIDimensions.SPACE_SIZE_5X * 1.2,
                              vertical: IZIDimensions.SPACE_SIZE_2X),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  IZIDimensions.BORDER_RADIUS_6X),
                              color: ColorResources.WHITE),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              dateTimeIdOrderWidget(controller, id),
                              inforOrder(controller, id),
                              statusWidget(controller, id),
                              checkShowButtonWidget(controller, id)
                            ],
                          ),
                        ),
                      );
                    },
                  )),
                ),
              );
            }),
          );
        },
      ),
    );
  }

  ///
  /// Hiện thị Status
  ///

  Container statusWidget(HistoryOrderController controller, int id) {
    return Container(
      margin: EdgeInsets.only(
          top: IZIDimensions.SPACE_SIZE_4X,
          bottom: controller.orderResponse[id].status != "4"
              ? IZIDimensions.SPACE_SIZE_5X
              : 0),
      child: IZIText(
        text: IZIOther.getNameStatusOrder(controller.orderResponse[id].status!),
        textAlign: TextAlign.left,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: IZIDimensions.FONT_SIZE_SPAN,
          color: ColorResources.ADDRESS_ORDER,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  ///
  /// thông tin Order
  ///

  IntrinsicHeight inforOrder(HistoryOrderController controller, int id) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_1X),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                IZIDimensions.ONE_UNIT_SIZE * 10,
              ),
              child: SizedBox(
                width: IZIDimensions.ONE_UNIT_SIZE * 140,
                height: IZIDimensions.ONE_UNIT_SIZE * 140,
                child: Image.network(
                  IZIValidate.nullOrEmpty(
                          controller.orderResponse[id].idUserShop!.banner)
                      ? ''
                      : controller.orderResponse[id].idUserShop!.banner
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        IZIImage(
                          ImagesPath.bg_check,
                          width: IZIDimensions.FONT_SIZE_H6,
                        ),
                        Icon(
                          controller.orderResponse[id].status == "3"
                              ? Icons.check
                              : null,
                          color: ColorResources.WHITE,
                          size: IZIDimensions.FONT_SIZE_SPAN_SMALL,
                        )
                      ],
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X),
                        child: IZIText(
                          text: IZIValidate.nullOrEmpty(controller
                                  .orderResponse[id].idUserShop!.fullName)
                              ? ''
                              : controller
                                  .orderResponse[id].idUserShop!.fullName
                                  .toString(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              color: ColorResources.PRIMARY_2),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                  child: IZIText(
                    text: IZIValidate.nullOrEmpty(
                            controller.orderResponse[id].idUserShop!.address)
                        ? ''
                        : controller.orderResponse[id].idUserShop!.address
                            .toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        color: ColorResources.ADDRESS_ORDER),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: ColorResources.STAR_ICON_ORDER,
                      ),
                      IZIText(
                        text:
                            '${IZIValidate.nullOrEmpty(controller.orderResponse[id].idUserShop) ? '' : controller.orderResponse[id].idUserShop!.rankPoint ?? ''} (${IZIValidate.nullOrEmpty(controller.orderResponse[id].idUserShop) ? '' : IZIValidate.nullOrEmpty(controller.orderResponse[id].idUserShop!.statitisReviews) ? 0 : controller.orderResponse[id].idUserShop!.statitisReviews!.countRating}+)',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: IZIDimensions.FONT_SIZE_SPAN,
                            color: ColorResources.ADDRESS_ORDER),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    descriptionWidget(
                        '${IZIPrice.currencyConverterVND(controller.orderResponse[id].finalPrice!)}đ',
                        ColorResources.PRICE),
                    descriptionWidget(
                        controller.orderResponse[id].typePayment == '0'
                            ? ' (Ví)'
                            : ' (Tiền mặt)',
                        ColorResources.PRIMARY_2)
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// thông tin dateTime ,idOrder
  ///

  Padding dateTimeIdOrderWidget(HistoryOrderController controller, int id) {
    return Padding(
      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_1X),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IZIText(
            text: "#${controller.orderResponse[id].codeOrder}",
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: ColorResources.PRIMARY_2),
          ),
          IZIText(
            text: IZIDate.formatDate(
                IZIDate.parse(
                    controller.orderResponse[id].createdAt.toString()),
                format: 'HH:mm dd-MM-yyyy'),
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: ColorResources.PRIMARY_2),
          ),
        ],
      ),
    );
  }

  ///
  /// Hiển thị Button Đặt lại ,Đánh giá
  ///
  Widget checkShowButtonWidget(HistoryOrderController controller, int id) {
    if (controller.orderResponse[id].status !=
        TRANG_THAI_DON_HANG_XAC_NHAN_GIAO) {
      return const SizedBox();
    } else {
      return Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: IZIDimensions.ONE_UNIT_SIZE * 350,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!controller.orderResponse[id].isReview!)
                Expanded(
                  child: buttonWidget(
                    "Đánh giá",
                    () {
                      controller.onGoToRatingPage(
                          order: controller.orderResponse[id]);
                    },
                    type: IZIButtonType.OUTLINE,
                  ),
                ),
              if (controller.orderResponse[id].isReview!)
                Expanded(
                  child: buttonWidget("Đã đánh giá", () {},
                      type: IZIButtonType.OUTLINE, isReview: true),
                ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Expanded(
                child: buttonWidget(
                  "Đặt lại",
                  () => controller.onTapToStore(
                      store: controller.orderResponse[id].idUserShop!),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  ///
  /// buttonWidget
  ///
  Widget buttonWidget(String title, Function onTap,
      {IZIButtonType type = IZIButtonType.DEFAULT, bool isReview = false}) {
    return IZIButton(
      type: type,
      width: IZIDimensions.ONE_UNIT_SIZE * 150,
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
        vertical: IZIDimensions.SPACE_SIZE_1X,
      ),
      withBorder: IZIButtonType.OUTLINE == type ? 0.7 : null,
      onTap: onTap,
      label: title,
      colorText: isReview ? ColorResources.PRIMARY_2 : null,
      fontSizedLabel: IZIDimensions.FONT_SIZE_SPAN,
    );
  }

  ///
  /// descriptionWidget
  ///

  IZIText descriptionWidget(String value, Color color) {
    return IZIText(
      text: value,
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: IZIDimensions.FONT_SIZE_SPAN,
        color: color,
        decoration: TextDecoration.none,
      ),
    );
  }
}
