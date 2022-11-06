import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_size.dart';
import 'package:template/routes/route_path/order_router.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/order/detail_order/detail_order_controller.dart';
import 'package:timelines/timelines.dart';

import '../../../../routes/route_path/order_router.dart';

class DetailOrderPage extends GetView<DetailOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
        background: const BackgroundAppBar(),
        appBar: IZIAppBar(
          title: 'Chi tiết đơn hàng',
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
          init: DetailOrderController(),
          builder: (DetailOrderController controller) => Column(
            children: [
              //  timeline
              timeLine(),
              //timeline

              Container(
                margin:
                    EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_4X),
                child: IZIListView(
                  label: "Sản phẩm",
                  itemCount: controller.order.items!.length,
                  builder: (id) => GestureDetector(
                    onTap: () {
                      Get.toNamed(OrderRoutes.REVIEWER_ORDER, arguments: {
                        "idOrder": controller.order.id,
                        "items": controller.order.items![id]
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
                      padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_1X),
                      decoration:
                          const BoxDecoration(color: ColorResources.WHITE),
                      child: IntrinsicHeight(
                          child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Checkbox(
                          //   value: false,
                          //   onChanged: (v) {},
                          //   side: const BorderSide(width: 1.4),
                          // ),
                          IZIImage(
                            controller.order.items![id].idProduct!.thumbnail!,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: IZIText(
                                      text: controller
                                          .order.items![id].idProduct!.name!,
                                      maxLine: 2,
                                      style: TextStyle(
                                          fontFamily: 'Roboto',
                                          color: ColorResources.PRIMARY_9,
                                          fontSize:
                                              IZIDimensions.FONT_SIZE_SPAN,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: IZIText(
                                          text:
                                              "${controller.order.items![id].idProduct!.price} đ",
                                          maxLine: 2,
                                          style: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: ColorResources.PRICE,
                                              fontSize:
                                                  IZIDimensions.FONT_SIZE_SPAN,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: IZIText(
                              text:
                                  "x${controller.order.items![id].quantityPrices!.quantity.toString()}",
                              textAlign: TextAlign.end,
                            ),
                          )
                        ],
                      )),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: IZIDimensions.SPACE_SIZE_4X,
                        right: IZIDimensions.SPACE_SIZE_4X,
                        top: IZIDimensions.SPACE_SIZE_5X),
                    child: IZIText(
                      text: "Thông tin vận chuyển",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        color: ColorResources.PRIMARY_9,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
                      color: ColorResources.WHITE,
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                        vertical: IZIDimensions.SPACE_SIZE_3X),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    child: Column(
                      children: [
                        boxField(
                            "Ngày giao hàng",
                            IZIDate.formatDate(
                                IZIDate.parse(controller.order.createdAt!)),
                            ColorResources.PRIMARY_8,
                            ColorResources.PRIMARY_9),
                        boxField("Giao hàng", "Giao hàng nhanh",
                            ColorResources.PRIMARY_8, ColorResources.PRIMARY_9),
                        boxField("Địa chỉ", controller.order.address,
                            ColorResources.PRIMARY_8, ColorResources.PRIMARY_9),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          left: IZIDimensions.SPACE_SIZE_4X,
                          right: IZIDimensions.SPACE_SIZE_4X,
                          top: IZIDimensions.SPACE_SIZE_5X),
                      child: IZIText(
                        text: "Chi tiết đơn hàng",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                          color: ColorResources.PRIMARY_9,
                        ),
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: IZIDimensions.SPACE_SIZE_4X,
                        vertical: IZIDimensions.SPACE_SIZE_3X),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(IZIDimensions.BORDER_RADIUS_4X),
                      color: ColorResources.WHITE,
                    ),
                    child: Column(
                      children: [
                        boxField(
                            "Sản phẩm ${controller.order.amount}",
                            "${controller.order.totalPrice}đ",
                            ColorResources.PRIMARY_8,
                            ColorResources.PRIMARY_9),
                        boxField(
                            "Giao hàng",
                            " ${controller.order.totalShipping} đ",
                            ColorResources.PRIMARY_8,
                            ColorResources.PRIMARY_9),
                        boxField(
                            "Giảm giá",
                            controller.order.totalShipping.toString(),
                            ColorResources.PRIMARY_8,
                            ColorResources.PRIMARY_9),
                        const DottedLine(
                          lineThickness: 1.5,
                          dashColor: Color(0xffEBF0FF),
                        ),
                        boxField(
                            "Tổng tiền",
                            " ${controller.order.totalPayment}đ",
                            ColorResources.PRIMARY_8,
                            ColorResources.PRICE),
                      ],
                    ),
                  ),
                ],
              ),
              if (controller.statusOrderIndex() == 3)
                const SizedBox()
              else
                IZIButton(
                  margin: EdgeInsets.zero,
                  width: IZISize.size.width / 2,
                  onTap: () {
                    if (controller.processIndex == 0 ||
                        controller.processIndex == 1) {
                      controller.cancelOrder();
                    }
                    // Get.toNamed(OrderRoutes.REVIEWER_ORDER);
                  },
                  type: IZIButtonType.OUTLINE,
                  label: "Hủy đơn",
                  colorText: ColorResources.RED_COLOR_2,
                  colorBG: ColorResources.RED_COLOR_2,
                )
            ],
          ),
        ));
  }

  Widget boxField(String? titleLeft, String? titleRight, Color? colorTitleLeft,
      Color? colorTitleRight) {
    return Padding(
      padding: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: IZIText(
              text: titleLeft!,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  color: colorTitleLeft),
            ),
          ),
          Flexible(
            child: IZIText(
              textAlign: TextAlign.right,
              text: titleRight!,
              maxLine: 3,
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  color: colorTitleRight),
            ),
          )
        ],
      ),
    );
  }

  ///
  /// Time line
  ///
  Widget timeLine() {
    return Container(
      margin: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
      decoration: const BoxDecoration(
        color: ColorResources.WHITE,
      ),
      width: IZIDimensions.iziSize.width,
      height: IZIDimensions.iziSize.width * .25,
      child: Timeline.tileBuilder(
        primary: true,
        shrinkWrap: true,
        theme: TimelineThemeData(
          nodePosition: 0.2,
          direction: Axis.horizontal,
          connectorTheme: const ConnectorThemeData(
            thickness: 2.0,
          ),
        ),
        padding: EdgeInsets.zero,
        physics: const ScrollPhysics(),
        builder: TimelineTileBuilder.connected(
          oppositeContentsBuilder: (context, index) {
            return Container();
          },
          itemCount: controller.statusOrder.length,
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
              IZIDimensions.iziSize.width /
              (controller.statusOrder.length + 0.3),
          contentsBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_4X),
              child: Column(
                children: [
                  Text(
                    controller.statusOrder[index]['title'].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                      color: ColorResources.PRIMARY_8,
                    ),
                  ),
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            return DotIndicator(
              color: ColorResources.ORANGE,
              child: DotIndicator(
                  size: IZIDimensions.ONE_UNIT_SIZE * 40,
                  color: index > controller.statusOrderIndex()
                      ? ColorResources.WHITE.withOpacity(.8)
                      : Colors.transparent,
                  child: Icon(
                    Icons.check,
                    size: IZIDimensions.ONE_UNIT_SIZE * 20,
                    color: ColorResources.WHITE,
                  )),
            );
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == controller.statusOrderIndex()) {
                return const DecoratedLineConnector(
                  decoration: BoxDecoration(
                    color: ColorResources.ORANGE,
                  ),
                );
              } else if (index < controller.statusOrderIndex()) {
                return const SolidLineConnector(
                  color: ColorResources.ORANGE,
                );
              } else {
                return const SizedBox(
                  child: SolidLineConnector(
                    color: ColorResources.NEUTRALS_6,
                  ),
                );
              }
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}
