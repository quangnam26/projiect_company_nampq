import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/rating_store.dart/rating_controller.dart';
import '../components/rating_card.dart';

class RatingStorePage extends GetView<RatingStoreController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      safeAreaBottom: false,
      appBar: const IZIAppBar(
        title: "Đánh giá về cửa hàng",
        colorBG: ColorResources.PRIMARY_1,
        colorTitle: ColorResources.WHITE,
      ),
      body: Container(
        color: ColorResources.NEUTRALS_7,
        child: SmartRefresher(
          controller: controller.refreshController,
          onLoading: () {
            controller.onLoading();
          },
          onRefresh: () {
            controller.onRefresh();
          },
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
            idleText: "",
            idleIcon: null,
          ),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            controller: controller.scrollController,
            child: Column(
              children: [
                FadeTransition(
                  opacity: controller.hideFabAnimController!,
                  child: Column(
                    children: [
                      SizedBox(
                        height: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      rating(),
                    ],
                  ),
                ),
                SizedBox(
                  height: IZIDimensions.SPACE_SIZE_4X,
                ),
                ratingList(),
                SizedBox(
                  height: MediaQuery.of(context).viewPadding.bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
  /// Rating
  ///
  Widget rating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Icon(
              Icons.star,
              size: IZIDimensions.ONE_UNIT_SIZE * 60,
              color: ColorResources.PRIMARY_3,
            ),
            Text(
              IZIValidate.nullOrEmpty(controller.store) ? '' : controller.store!.rankPoint!.toStringAsFixed(1),
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              IZIValidate.nullOrEmpty(controller.store)
                  ? '-'
                  : IZIValidate.nullOrEmpty(controller.store!.statitisReviews)
                      ? '-'
                      : controller.store!.statitisReviews!.countRating! > 100
                          ? '100+'
                          : controller.store!.statitisReviews!.countRating!.toStringAsFixed(0),
              style: textStyleSpan.copyWith(
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        SizedBox(
          width: IZIDimensions.ONE_UNIT_SIZE * 60,
        ),
        Obx(() {
          return Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(controller.isExpan.value ? controller.ratings.length : 3, (index) {
                    return boxRate(
                      icon: controller.ratings[index]['icon'] as IconData,
                      value: (controller.ratings[index]['value'] ?? 0) as int,
                      title: controller.ratings[index]['title'].toString(),
                      iconColor: controller.ratings[index]['iconColor'] as Color,
                    );
                  })
                ],
              ),
              GestureDetector(
                onTap: () {
                  controller.onExpaned();
                },
                child: Icon(
                  controller.isExpan.value ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                  color: ColorResources.NEUTRALS_4,
                  size: IZIDimensions.ONE_UNIT_SIZE * 50,
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  ///
  /// ĐÁNH GIÁ ĐỘ HÀI LÒNG
  ///
  Widget boxRate({
    required String title,
    required int value,
    required IconData icon,
    Color? iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          IZIDimensions.ONE_UNIT_SIZE * 50,
        ),
        color: Colors.transparent,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_1X,
        vertical: IZIDimensions.ONE_UNIT_SIZE * 4,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? ColorResources.PRIMARY_1,
            size: IZIDimensions.ONE_UNIT_SIZE * 40,
          ),
          SizedBox(
            width: IZIDimensions.SPACE_SIZE_1X,
          ),
          Text(
            title,
            style: TextStyle(
              color: ColorResources.NEUTRALS_3,
              fontWeight: FontWeight.w500,
              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
            ),
          ),
          if (value > 0)
            Text(
              value > 10 ? '(10+)' : '(${value.toString()})',
              style: TextStyle(
                color: ColorResources.NEUTRALS_4,
                fontWeight: FontWeight.w500,
                fontSize: IZIDimensions.FONT_SIZE_H6 * 0.8,
              ),
            )
        ],
      ),
    );
  }

  /// danh sách sản phẩm
  Widget ratingList() {
    return controller.buildObx(
      (state) {
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.reviews.length,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return RatingCard(
              userName: IZIValidate.nullOrEmpty(controller.reviews[index].idUser) ? '' : controller.reviews[index].idUser!.fullName ?? '',
              comment: IZIValidate.nullOrEmpty(controller.reviews[index]) ? '' : controller.reviews[index].content ?? '',
              rating: IZIValidate.nullOrEmpty(controller.reviews[index]) ? 0 : IZINumber.parseInt(controller.reviews[index].ratePoint),
              reactions: controller.reviews[index].shopReactions,
              images: IZIValidate.nullOrEmpty(controller.reviews[index]) ? [] : controller.reviews[index].images!,
              date: IZIValidate.nullOrEmpty(controller.reviews[index]) ? '' : IZIDate.formatDate(IZIDate.parse(controller.reviews[index].createdAt!), format: 'dd MMMM,hh:mm'),
            );
          },
        );
      },
    );
  }
}
