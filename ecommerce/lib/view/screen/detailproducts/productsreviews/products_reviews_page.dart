import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/data/model/rate/rate_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/detailproducts/productsreviews/products_reviews_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../utils/color_resources.dart';
import 'package:html/parser.dart' show parse;

class ProductsReviewPage extends GetView<ProductsReviewsController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductsReviewsController>(builder: (pcontroller) {
      return IZIScreen(
          safeAreaBottom: false,
          isSingleChildScrollView: false,
          // background: const BackgroundAppBar(),s
          appBar: IZIAppBar(
            title: "${controller.sumRate} đánh giá",
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
          body: Container(
            color: ColorResources.WHITE,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectTitleTopCategoryWidget(pcontroller),
                // if (listRateBasedOnCategoryTitle(pcontroller
                //         .listAll[pcontroller.indexTitle]['title']
                //         .toString())
                //     .isNotEmpty)
                selectRateNumberWidget(pcontroller),
                if (listRateBasedOnCategoryTitle(pcontroller
                        .listAll[pcontroller.indexTitle]['title']
                        .toString())
                    .isNotEmpty)
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: SmartRefresher(
                        controller: controller.refreshController,
                        onLoading: () {
                          controller.loadMore();
                        },
                        onRefresh: () {
                          controller.refresh2();
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
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount:
                                // controller.rateResponseListNew.length
                                listRateBasedOnCategoryTitle(pcontroller
                                        .listAll[pcontroller.indexTitle]
                                            ['title']
                                        .toString())
                                    .length,
                            itemBuilder: (context, index) {
                              print("index:$index");
                              return itemRateInfoWidget(pcontroller, index);
                            })),
                  ))
              ],
            ),
          ));
    });
  }

  ///
  /// Lựa chọn 1,2,3,4,5 sao
  ///

  SizedBox selectRateNumberWidget(ProductsReviewsController pcontroller) {
    return SizedBox(
        height: IZIDimensions.ONE_UNIT_SIZE * 90,
        width: IZIDimensions.iziSize.width,
        child: ListView.builder(
            reverse: true,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.onChangeSelectRate(index);
                },
                child: Container(
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                        color: pcontroller.ratingNumber == index + 1
                            ? ColorResources.YELLOW2
                            : ColorResources.WHITE,
                        border: Border.all(
                            color: pcontroller.ratingNumber == index + 1
                                ? Colors.transparent
                                : ColorResources.WHITE3)),
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        ratingBarWidget(index),
                        quantityBasedOnTitle(pcontroller, index)
                      ],
                    )),
              );
            }));
  }

  ///
  /// Lựa chọn Tất cả, có bình chọn ,có hình ảnh/video
  ///
  Padding selectTitleTopCategoryWidget(ProductsReviewsController pcontroller) {
    return Padding(
      padding: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_3X,
          top: IZIDimensions.SPACE_SIZE_3X,
          bottom: IZIDimensions.SPACE_SIZE_4X),
      child: SizedBox(
        height: IZIDimensions.ONE_UNIT_SIZE * 120,
        width: IZIDimensions.iziSize.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: pcontroller.listAll.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                pcontroller.onTapTitle(index);
              },
              child: Container(
                margin: EdgeInsets.only(right: IZIDimensions.SPACE_SIZE_2X),
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(IZIDimensions.BLUR_RADIUS_2X),
                    color: pcontroller.indexTitle == index
                        ? ColorResources.YELLOW2
                        : ColorResources.WHITE,
                    border: Border.all(
                        color: pcontroller.indexTitle == index
                            ? Colors.transparent
                            : ColorResources.WHITE3)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_5X,
                      vertical: IZIDimensions.SPACE_SIZE_4X),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pcontroller.listAll[index]['title'].toString(),
                        style: TextStyle(
                            color: pcontroller.indexTitle == index
                                ? ColorResources.ORANGE
                                : ColorResources.PRIMARY_8,
                            fontWeight: pcontroller.indexTitle == index
                                ? FontWeight.w600
                                : FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                      Text(
                        "(${quantitySumATabbar(pcontroller.listAll[index]['title'].toString())})",
                        style: const TextStyle(
                          color: ColorResources.LIGHT_GREY,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// Thông tin đánh giá
  ///
  Container itemRateInfoWidget(
      ProductsReviewsController pcontroller, int index) {
    return Container(
      margin: EdgeInsets.only(
          left: IZIDimensions.SPACE_SIZE_2X,
          right: IZIDimensions.SPACE_SIZE_2X,
          bottom: IZIDimensions.SPACE_SIZE_4X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: IZIValidate.nullOrEmpty(listRateBasedOnCategoryTitle(
                            pcontroller.listAll[pcontroller.indexTitle]['title']
                                .toString())[index]
                        .user!
                        .avatar)
                    ? const Icon(CupertinoIcons.person)
                    : IZIImage(
                        listRateBasedOnCategoryTitle(pcontroller
                                .listAll[pcontroller.indexTitle]['title']
                                .toString())[index]
                            .user!
                            .avatar!,
                        height: IZIDimensions.ONE_UNIT_SIZE * 60,
                        width: IZIDimensions.ONE_UNIT_SIZE * 60,
                      ),
              ),
              SizedBox(
                width: IZIDimensions.SPACE_SIZE_2X,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      listRateBasedOnCategoryTitle(pcontroller
                                  .listAll[pcontroller.indexTitle]['title']
                                  .toString())[index]
                              .user!
                              .fullName ??
                          "Unknown",
                      style: TextStyle(
                          fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_1X,
                          top: IZIDimensions.SPACE_SIZE_1X),
                      child: RatingBarIndicator(
                        itemPadding: EdgeInsets.symmetric(
                            horizontal: IZIDimensions.ONE_UNIT_SIZE * 0),
                        rating: double.parse(listRateBasedOnCategoryTitle(
                                pcontroller.listAll[pcontroller.indexTitle]
                                        ['title']
                                    .toString())[index]
                            .point
                            .toString()),
                        itemBuilder: (context, index) => const Icon(Icons.star,
                            color: ColorResources.YELLOW_PRIMARY2),
                        itemSize: IZIDimensions.ONE_UNIT_SIZE * 30,
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                      child: Text(
                        "Đánh giá chất lượng sản phẩm",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9),
                      ),
                    ),
                    // IZIListView(
                    //     itemCount: listRateBasedOnCategoryTitle(controller
                    //             .listAll[controller.indexTitle]['title']
                    //             .toString())
                    //         .length,
                    //     builder: (indexRate) =>
                    Container(
                        margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X),
                        height: IZIDimensions.ONE_UNIT_SIZE * 120,
                        width: IZIDimensions.iziSize.width,
                        child: listMediaWidget(index)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: IZIDimensions.SPACE_SIZE_2X),
                      child: Text(
                        IZIDate.formatDate(IZIDate.parse(
                            // controller
                            //   .rateResponseListNew
                            listRateBasedOnCategoryTitle(pcontroller
                                    .listAll[pcontroller.indexTitle]['title']
                                    .toString())[index]
                                .createdAt!)),
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: ColorResources.NEUTRALS_5,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                        ),
                      ),
                    ),
                    if (!IZIValidate.nullOrEmpty(listRateBasedOnCategoryTitle(
                            pcontroller.listAll[pcontroller.indexTitle]['title']
                                .toString())[index]
                        .shopReply))
                      Container(
                        color: ColorResources.NEUTRALS_6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Phản hồi của người bán:",
                                style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                    color: ColorResources.RED_COLOR_2),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: IZIDimensions.SPACE_SIZE_2X,
                                  right: IZIDimensions.SPACE_SIZE_4X * 5,
                                  bottom: IZIDimensions.SPACE_SIZE_2X),
                              child: Text(
                                parse(listRateBasedOnCategoryTitle(pcontroller
                                            .listAll[pcontroller.indexTitle]
                                                ['title']
                                            .toString())[index]
                                        .shopReply)
                                    .documentElement!
                                    .text,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: IZIDimensions.SPACE_SIZE_3X,
                left: IZIDimensions.SPACE_SIZE_3X,
                right: IZIDimensions.SPACE_SIZE_3X),
            child: const Divider(
              height: 5,
              color: ColorResources.GREY,
            ),
          )
        ],
      ),
    );
  }

  ListView listMediaWidget(int index) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: [
          ...listRateBasedOnCategoryTitle(controller
                  .listAll[controller.indexTitle]['title']
                  .toString())[index]
              .image!,
          ...listRateBasedOnCategoryTitle(controller
                  .listAll[controller.indexTitle]['title']
                  .toString())[index]
              .video!,
        ].length,
        itemBuilder: (cxt, indexMedia) {
          return Container(
              // width: IZIDimensions.iziSize.width * .25,
              // height: IZIDimensions.iziSize.width * .05,
              child: [
            ...listRateBasedOnCategoryTitle(controller
                    .listAll[controller.indexTitle]['title']
                    .toString())[index]
                .image!,
            ...listRateBasedOnCategoryTitle(controller
                    .listAll[controller.indexTitle]['title']
                    .toString())[index]
                .video!,
          ][indexMedia]
                      .contains(".mp4")
                  ? (controller.futureList.isEmpty ||
                          index > controller.futureList.length)
                      ? const SizedBox()
                      : Padding(
                          padding:
                              EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),

                          // height: IZIDimensions.ONE_UNIT_SIZE * 100,
                          child: FutureBuilder<void>(
                              future: controller.futureList[index],
                              builder: (context, snapshot) {
                                print("snap:${snapshot.connectionState}");
                                if (snapshot.connectionState ==
                                        ConnectionState.done &&
                                    controller
                                        .videoList[index].value.isInitialized) {
                                  return AspectRatio(
                                      aspectRatio: 16 / 12,
                                      child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal:
                                                  IZIDimensions.SPACE_SIZE_2X),
                                          child: IZIValidate.nullOrEmpty(
                                                  controller.videoList[index])
                                              ? const SizedBox()
                                              : Stack(
                                                  children: [
                                                    VideoPlayer(controller
                                                        .videoList[index]),
                                                    IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .buttonOnOffVideo(
                                                                controller
                                                                        .videoList[
                                                                    index]);
                                                      },
                                                      icon: Icon(
                                                        controller
                                                                .videoList[
                                                                    index]
                                                                .value
                                                                .isPlaying
                                                            ? Icons.pause
                                                            : Icons.play_arrow,
                                                        color:
                                                            ColorResources.RED,
                                                      ),
                                                    )
                                                  ],
                                                )));
                                } else {
                                  return SizedBox(
                                      width: IZIDimensions.iziSize.width * .15,
                                      height: IZIDimensions.iziSize.width * .15,
                                      child: const Center(
                                          child: CircularProgressIndicator()));
                                }
                              }))
                  : IZIImage(
                      [
                        ...listRateBasedOnCategoryTitle(controller
                                .listAll[controller.indexTitle]['title']
                                .toString())[index]
                            .image!,
                        ...listRateBasedOnCategoryTitle(controller
                                .listAll[controller.indexTitle]['title']
                                .toString())[index]
                            .image!,
                      ][indexMedia]
                          .toString(),
                      width: 60,
                      height: 60,
                    ));

          //   (controller.futureList.isEmpty ||
          //   index > controller.futureList.length)
          //  SizedBox();

          //  SizedBox(
          //     height: IZIDimensions.ONE_UNIT_SIZE * 100,
          //     child: FutureBuilder<void>(
          //         future: controller.futureList[index],
          //         builder: (context, snapshot) {
          //           print("snap:${snapshot.connectionState}");
          //           if (snapshot.connectionState ==
          //                   ConnectionState.done &&
          //               controller
          //                   .videoList[index].value.isInitialized) {
          //             return AspectRatio(
          //                 aspectRatio: 16 / 12,
          //                 child: Padding(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal:
          //                             IZIDimensions.SPACE_SIZE_2X),
          //                     child: Stack(
          //                       children: [
          //                         VideoPlayer(
          //                             controller.videoList[index]),
          //                         IconButton(
          //                           onPressed: () {
          //                             controller.buttonOnOffVideo(
          //                                 controller
          //                                     .videoList[index]);
          //                           },
          //                           icon: Icon(
          //                             controller.videoList[index]
          //                                     .value.isPlaying
          //                                 ? Icons.pause
          //                                 : Icons.play_arrow,
          //                             color: ColorResources.RED,
          //                           ),
          //                         )
          //                       ],
          //                     )));
          //           } else {
          //             return SizedBox(
          //                 width: IZIDimensions.iziSize.width * .15,
          //                 height: IZIDimensions.iziSize.width * .15,
          //                 child: const Center(
          //                     child: CircularProgressIndicator()));
          //           }
          //         }))
          // :
          // IZIImage(
          //                     controller.rateResponseList.first
          //                         .image![index]
          //                         .toString(),
          //                     width: 60,
          //                     height: 60,
          //                   )

          //  );
        });
  }

  ///
  /// Tổng số lượng đang có tho từng tên mục( tất cả,có bình luận,có hình ảnh/video)
  ///
  Text quantityBasedOnTitle(ProductsReviewsController pcontroller, int index) {
    return Text(
        "(${pcontroller.rateOriginResponseList.where((element) => pcontroller.indexTitle == 0 ? element.point == index + 1 : pcontroller.indexTitle == 1 ? !IZIValidate.nullOrEmpty(element.shopReply) && element.point == index + 1 : (!IZIValidate.nullOrEmpty(element.image) || !IZIValidate.nullOrEmpty(element.video)) && element.point == index + 1).length})");
  }

  ///
  /// rating bar
  ///
  RatingBarIndicator ratingBarWidget(int index) {
    return RatingBarIndicator(
      itemCount: index + 1,
      rating: IZINumber.parseDouble(index + 1),
      itemBuilder: (context, i) => const Icon(
        Icons.star,
        color: ColorResources.YELLOW_PRIMARY2,
      ),
      itemSize: IZIDimensions.ONE_UNIT_SIZE * 30,
      unratedColor: ColorResources.YELLOW_PRIMARY2,
    );
  }

  ///
  /// Hiện số lượng theo title
  ///
  String quantitySumATabbar(String title) {
    switch (title) {
      case "Tất cả":
        return controller.rateOriginResponseList.length.toString();
      case "Có bình luận":
        return controller.rateOriginResponseList
            .where((element) => !IZIValidate.nullOrEmpty(element.shopReply))
            .length
            .toString();
      case "Có hình ảnh/video":
        return controller.rateOriginResponseList
            .where((element) =>
                !IZIValidate.nullOrEmpty(element.video) ||
                !IZIValidate.nullOrEmpty(element.image))
            .length
            .toString();
      default:
        return controller.rateOriginResponseList.length.toString();
    }
  }

  ///
  /// listWidget
  ///
  List<RateResponse> listRateBasedOnCategoryTitle(String title) {
    switch (title) {
      case "Tất cả":
        if (!IZIValidate.nullOrEmpty(controller.ratingNumber)) {
          controller.rateResponseListNew = controller.rateOriginResponseList
              .where((element) => element.point == controller.ratingNumber)
              .toList();
        } else {
          controller.rateResponseListNew = controller.rateOriginResponseList;
        }
        break;
      case "Có bình luận":
        if (!IZIValidate.nullOrEmpty(controller.ratingNumber)) {
          controller.rateResponseListNew = controller.rateOriginResponseList
              .where((element) =>
                  !IZIValidate.nullOrEmpty(element.shopReply) &&
                  element.point == controller.ratingNumber)
              .toList();
        } else {
          controller.rateResponseListNew = controller.rateOriginResponseList
              .where((element) => !IZIValidate.nullOrEmpty(element.shopReply))
              .toList();
        }

        break;
      case "Có hình ảnh/video":
        if (!IZIValidate.nullOrEmpty(controller.ratingNumber)) {
          controller.rateResponseListNew = controller.rateOriginResponseList
              .where((element) =>
                  !IZIValidate.nullOrEmpty(element.video) ||
                  !IZIValidate.nullOrEmpty(element.image) &&
                      element.point == controller.ratingNumber)
              .toList();
        } else {
          controller.rateResponseListNew = controller.rateOriginResponseList
              .where((element) =>
                  !IZIValidate.nullOrEmpty(element.video) ||
                  !IZIValidate.nullOrEmpty(element.image))
              .toList();
        }
        break;
      default:
        controller.rateResponseListNew = controller.rateOriginResponseList;
        break;
    }
    return controller.rateResponseListNew;
  }
}
