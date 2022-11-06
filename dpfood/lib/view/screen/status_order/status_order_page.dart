import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_other.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/status_order/status_order_controller.dart';
import 'package:timelines/timelines.dart';
import '../../../base_widget/izi_image.dart';
import '../components/order_product_card.dart';

class StatusOrderPage extends GetView<StatusOrderController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
        isSingleChildScrollView: false,
        background: Container(
          color: ColorResources.WHITE,
        ),
        safeAreaBottom: false,
        body: GetBuilder(
            init: StatusOrderController(),
            builder: (StatusOrderController controller) {
              if (controller.isLoading.value) {
                return spinKitWave;
              }
              return Stack(
                children: [
                  Container(
                    color: ColorResources.NEUTRALS_7,
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      controller: controller.scrollController,
                      child: SizedBox(
                        child: Column(
                          children: [
                            Obx(
                              () {
                                return controller.isLoading.isTrue && controller.orderResponse!.status == '0'
                                    ? Container(
                                        color: ColorResources.WHITE,
                                        height: IZIDimensions.ONE_UNIT_SIZE * 900,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Gif(
                                                autostart: Autostart.loop,
                                                image: const AssetImage("assets/images/shipper.gif"),
                                              ),
                                              Text("Đang chờ tài xế nhận đơn", style: textStyleH6),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Column(
                                        children: [
                                          driver(controller),
                                          SizedBox(
                                            height: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                          statusOrder(controller),
                                          SizedBox(
                                            height: IZIDimensions.SPACE_SIZE_2X,
                                          ),
                                        ],
                                      );
                              },
                            ),
                            if (controller.isLoading.isFalse) productList(controller),
                            SizedBox(
                              height: IZIDimensions.ONE_UNIT_SIZE * 200 + IZIDimensions.SPACE_SIZE_4X,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 15,
                    child: GestureDetector(
                      onTap: () {
                        controller.onBack();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: ColorResources.NEUTRALS_4,
                      ),
                    ),
                  )
                ],
              );
            }),
        widgetBottomSheet: GetBuilder<StatusOrderController>(builder: (controller) {
          if (controller.isLoading.isTrue) {
            return spinKitWave;
          }
          return Container(
            height: IZIDimensions.ONE_UNIT_SIZE * 200,
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            color: ColorResources.WHITE,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text(
                //   "Thanh toán bằng",
                //   style: textStyleH5.copyWith(
                //     color: ColorResources.NEUTRALS_3,
                //   ),
                // ),
                // Text(
                //   controller.orderResponse!.typePayment == '0' ? "Ví DPPay" : 'Tiền mặt',
                //   style: textStyleH5.copyWith(
                //     color: ColorResources.PRIMARY_1,
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Thanh toán bằng",
                      style: textStyleH5.copyWith(
                        color: ColorResources.NEUTRALS_3,
                      ),
                    ),
                    Text(
                      controller.orderResponse!.typePayment == '0' ? "Ví DPPay" : 'Tiền mặt',
                      style: textStyleH5.copyWith(
                        color: ColorResources.PRIMARY_1,
                      ),
                    ),
                  ],
                ),
                if (controller.isFinish)
                  IZIButton(
                    onTap: () => Get.back(),
                    label: 'Quay về',
                  )
              ],
            ),
          );
        }));
  }

  ///
  /// statusOrder
  ///
  Widget statusOrder(StatusOrderController controller) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_4X,
        vertical: IZIDimensions.SPACE_SIZE_2X,
      ),
      width: IZIDimensions.iziSize.width,
      color: ColorResources.WHITE,
      child: Column(
        children: [
          ClipRRect(
            child: SizedBox(
              height: IZIDimensions.ONE_UNIT_SIZE * 200,
              width: IZIDimensions.ONE_UNIT_SIZE * 200,
              child: IZIImage(
                ImagesPath.shipper,
              ),
            ),
          ),
          //
          timeLine(controller),
        ],
      ),
    );
  }

  ///
  /// Time line
  ///
  Widget timeLine(StatusOrderController controller) {
    Color getColor(int index) {
      if (index == controller.processIndex.value) {
        return ColorResources.PRIMARY_1;
      } else if (index < controller.processIndex.value) {
        return ColorResources.PRIMARY_1;
      } else {
        return ColorResources.NEUTRALS_4;
      }
    }

    return SizedBox(
      height: IZIDimensions.ONE_UNIT_SIZE * 190,
      child: Timeline.tileBuilder(
        shrinkWrap: true,
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: ConnectorThemeData(
            space: IZIDimensions.SPACE_SIZE_2X,
            thickness: 5.0,
          ),
        ),
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        builder: TimelineTileBuilder.connected(
          itemCount: controller.statusOrder.length,
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) => IZIDimensions.iziSize.width / (controller.statusOrder.length + 0.3),
          oppositeContentsBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(
                  bottom: 15.0,
                ),
                child: index <= controller.processIndex.value
                    ? Text(
                        '$index:30',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: getColor(index),
                        ),
                      )
                    : const SizedBox());
          },
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                children: [
                  Text(
                    controller.statusOrder[index]['title'].toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: getColor(index),
                    ),
                  ),
                ],
              ),
            );
          },
          indicatorBuilder: (_, index) {
            return OutlinedDotIndicator(
              color: getColor(index),
              child: index > controller.processIndex.value
                  ? OutlinedDotIndicator(
                      color: getColor(index),
                    )
                  : Icon(
                      Icons.check,
                      size: IZIDimensions.ONE_UNIT_SIZE * 25,
                      color: ColorResources.PRIMARY_1,
                    ),
            );
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              print(index);
              if (index == controller.processIndex.value) {
                return const DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorResources.PRIMARY_1,
                        ColorResources.PRIMARY_1,
                      ],
                    ),
                  ),
                );
              } else if (index < controller.processIndex.value) {
                return const SolidLineConnector(
                  color: ColorResources.PRIMARY_1,
                );
              } else {
                return const SolidLineConnector(
                  color: ColorResources.NEUTRALS_6,
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

  ///
  /// address
  ///
  Widget driver(StatusOrderController controller) {
    return Container(
      padding: EdgeInsets.only(
        left: IZIDimensions.SPACE_SIZE_4X,
        right: IZIDimensions.SPACE_SIZE_4X,
        top: IZIDimensions.SPACE_SIZE_4X * 3,
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      color: ColorResources.WHITE,
      child: Column(
        children: [
          if (controller.statusSocket == 0)
            Text(
              "Đang tìm tài xế nhận đơn...",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          if (controller.statusSocket == 1)
            Text(
              "Tài xế xác nhận đơn hàng",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          if (controller.statusSocket == 2)
            Text(
              "Cửa hàng xác nhận đơn hàng",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          if (controller.statusSocket == 3)
            Text(
              "Tài xế nhận món hàng",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
          if (controller.statusSocket == 4)
            Text(
              "Tài xế đang đến vị trí giao hàng",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          if (controller.statusSocket == 5)
            Text(
              "Tài xế đã đến vị trí giao hàng",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          if (controller.statusSocket == 6)
            Text(
              "Giao hàng thành công",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          if (controller.statusSocket == 7)
            Text(
              "Đơn hàng đã bị huỷ",
              style: textStyleH4.copyWith(
                fontWeight: FontWeight.w600,
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X * 2,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                IZIDimensions.BORDER_RADIUS_4X,
              ),
              color: ColorResources.NEUTRALS_7,
            ),
            padding: EdgeInsets.all(
              IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  child: SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 120,
                    width: IZIDimensions.ONE_UNIT_SIZE * 120,
                    child: IZIImage(
                      ImagesPath.shipper,
                    ),
                  ),
                ),
                SizedBox(
                  width: IZIDimensions.SPACE_SIZE_1X,
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              IZIValidate.nullOrEmpty(controller.userResponseShipper.fullName) ? 'Đang chờ tài xế nhận đơn' : controller.userResponseShipper.fullName!,
                              maxLines: 2,
                              style: textStyleH5.copyWith(
                                fontWeight: FontWeight.w500,
                                color: ColorResources.NEUTRALS_1,
                              ),
                            ),
                            // Text(
                            //   "76C-948385",
                            //   maxLines: 2,
                            //   style: textStyleH6.copyWith(
                            //     fontWeight: FontWeight.w400,
                            //     color: ColorResources.NEUTRALS_4,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: IZIValidate.nullOrEmpty(controller.userResponseShipper.phone)
                            ? () {}
                            : () {
                                IZIOther.callPhone(phone: controller.userResponseShipper.phone!);
                              },
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorResources.WHITE,
                          ),
                          padding: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: const Icon(
                            Icons.phone_in_talk_sharp,
                            color: ColorResources.PRIMARY_1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: IZIDimensions.SPACE_SIZE_4X,
          ),
        ],
      ),
    );
  }

  ///
  /// danh sách sản phẩm
  ///
  Widget productList(StatusOrderController controller) {
    return Container(
      color: ColorResources.WHITE,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_4X,
              horizontal: IZIDimensions.SPACE_SIZE_4X,
            ),
            child: Text(
              controller.orderResponse!.idUserShop!.fullName ?? '',
              style: textStyleH3.copyWith(
                color: ColorResources.NEUTRALS_2,
              ),
            ),
          ),
          const Divider(
            color: ColorResources.PRIMARY_1,
          ),
          Obx(
            () {
              if (controller.isLoading.isTrue) {
                return Container();
              }
              final int countLengthProduct = IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts) ? 0 : controller.orderResponse!.idProducts!.length;
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_4X,
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.isExpan.isFalse
                      ? countLengthProduct > 3
                          ? 3
                          : countLengthProduct + 1
                      : countLengthProduct + 1,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    if (controller.isExpan.isFalse
                        ? countLengthProduct > 3
                            ? index == 2
                            : index == countLengthProduct
                        : index == countLengthProduct) {
                      return GestureDetector(
                        onTap: () {
                          controller.onExpaned(context);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                controller.isExpan.isFalse ? "Xem thêm" : "Thu gọn",
                                style: textStyleSpan.copyWith(
                                  color: ColorResources.PRIMARY_1,
                                ),
                              ),
                              Icon(
                                controller.isExpan.isFalse ? Icons.keyboard_double_arrow_down_rounded : Icons.keyboard_double_arrow_up_rounded,
                                color: ColorResources.PRIMARY_1,
                                size: IZIDimensions.ONE_UNIT_SIZE * 22,
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return ProductOrderCard(
                      isShowCart: false,
                      amount: IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts) ? 0 : controller.orderResponse!.idProducts![index].amount ?? 0,
                      name: IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts![index].idProduct)
                          ? ''
                          : IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts)
                              ? ''
                              : controller.orderResponse!.idProducts![index].idProduct!.name ?? '',
                      note: IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts![index].description)
                          ? ''
                          : IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts)
                              ? ''
                              : controller.orderResponse!.idProducts![index].description ?? '',
                      price: IZIValidate.nullOrEmpty(controller.orderResponse!.totalPrice)
                          ? ''
                          : IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts![index].idProduct)
                              ? ''
                              : IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.orderResponse!.idProducts![index].idProduct!.price! * controller.orderResponse!.idProducts![index].amount!)),
                      toppings: IZIValidate.nullOrEmpty(controller.orderResponse!.idProducts![index].optionsTopping) ? '' : controller.getToppings(orderProduct: controller.orderResponse!.idProducts![index]),
                      onChanged: (val) {},
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
