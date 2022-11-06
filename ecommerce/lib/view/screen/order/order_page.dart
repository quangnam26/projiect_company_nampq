import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_tabbar.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/order/order_controller.dart';

import '../../../routes/route_path/order_router.dart';

class OrderPage extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundAppBar(),
        appBar: IZIAppBar(
          title: 'Đơn hàng của tôi',
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
        body: GetBuilder<OrderController>(
          // init: OrderController(),
          builder: (controller) => Column(
            children: [
              IZITabBar<Map<dynamic, dynamic>>(
                currentIndex: controller.selectTitleOrder,
                items: controller.map,
                onTapChangedTabbar: (index) {
                  controller.onChangeTitleOrder(index);
                },
                isUnderLine: false,
                heightTabBar: IZIDimensions.iziSize.width * .20,
                colorText: ColorResources.ORANGE,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
                  padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_4X),
                  // color: ColorResources.YELLOW,
                  child: SmartRefresher(
                      controller: controller.refreshController,
                      onLoading: () {
                        controller.loadMore();
                        // controller.refreshController.loadNoData();
                        // controller.refreshController.loadComplete();
                      },
                      onRefresh: () {
                        controller.refresh2();
                        // controller.refreshController.resetNoData();
                        // controller.refreshController.refreshCompleted();
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
                      child: IZIListView(
                          marginLabel: EdgeInsets.zero,
                          itemCount: controller.orderList
                              .where((element) =>
                                  element.status ==
                                  langTitleStatusOrder(
                                      controller
                                          .map[controller.selectTitleOrder]
                                              ['text']
                                          .toString(),
                                      'en'))
                              .length,
                          builder: (id) {
                            return GestureDetector(
                              onTap: () {
                                controller.onGoToPage(OrderRoutes.DETAIL_ORDER,
                                    controller.orderList[id]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_4X),
                                padding:
                                    EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        IZIDimensions.BORDER_RADIUS_3X),
                                    color: ColorResources.WHITE),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          bottom: IZIDimensions.SPACE_SIZE_2X),
                                      child: IZIText(
                                        text: IZIDate.formatDate(IZIDate.parse(
                                                controller
                                                    .orderList[id].createdAt!))
                                            .toString(),
                                        style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w600,
                                            color: ColorResources.PRIMARY_9,
                                            fontSize:
                                                IZIDimensions.FONT_SIZE_SPAN),
                                      ),
                                    ),
                                    const DottedLine(
                                      lineThickness: 1.5,
                                      dashColor: Color(0xffEBF0FF),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical:
                                              IZIDimensions.SPACE_SIZE_2X),
                                      child: Column(
                                        children: [
                                          boxField(
                                              "Trạng thái đơn hàng",
                                              langTitleStatusOrder(
                                                  controller
                                                      .orderList[id].status!,
                                                  'vi'),
                                              ColorResources.PRIMARY_8
                                                  .withOpacity(.5),
                                              ColorResources.PRIMARY_8),
                                          boxField(
                                              "Sản phẩm",
                                              "${controller.orderList[id].amount} sản phẩm",
                                              ColorResources.PRIMARY_8
                                                  .withOpacity(.5),
                                              ColorResources.PRIMARY_8),
                                          boxField(
                                              "Giá tiền",
                                              controller
                                                  .orderList[id].totalPayment
                                                  .toString(),
                                              ColorResources.PRIMARY_8
                                                  .withOpacity(.5),
                                              ColorResources.PRICE),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })),
                ),
              ),
            ],
          ),
        ));
  }

  Widget boxField(String? titleLeft, String? titleRight, Color? colorTitleLeft,
      Color? colorTitleRight) {
    return Padding(
      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_4X),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IZIText(
            text: titleLeft!,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: colorTitleLeft),
          ),
          IZIText(
            text: titleRight!,
            style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w600,
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                color: colorTitleRight),
          )
        ],
      ),
    );
  }

  String langTitleStatusOrder(String title, String lang) {
    switch (lang) {
      case "vi":
        switch (title) {
          case " Wait for confirmation":
            return "Chờ xác nhận";
          case " get product":
            return "Chờ lấy hàng";
          case " delivering":
            return "Đang giao";
          // case "":
          case "delivered":
            return "Đã giao";
          default:
            return "Chờ xác nhận";
        }

      case "en":
        switch (title) {
          case "Chờ xác nhận":
            return "Wait for confirmation";
          case "Chờ lấy hàng":
            return "get product";
          case "Đang giao":
            return "delivering";
          case "Đã giao":
          case "Đánh giá":
            return "delivered";
          default:
            return "Wait for confirmation";
        }
      default:
        return '';
    }
  }
}
