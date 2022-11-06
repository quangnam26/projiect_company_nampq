import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_list_view.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/cart/address_delivery/address_delivery_controller.dart';
import '../../../../data/model/address/address_response.dart';

class AddressDeliveryPage extends GetView<AddressDeliveryController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: 'Địa chỉ nhận hàng',
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
      body: GetBuilder<AddressDeliveryController>(
        init: AddressDeliveryController(),
        builder: (_) => SmartRefresher(
          controller: controller.refreshController,
          onRefresh: () {
            controller.onRefresh();
          },
          onLoading: () {
            controller.onLoading();
          },
          enablePullUp: true,
          header: const ClassicHeader(
            idleText: "kéo xuống để làm mới dữ liệu",
            releaseText: "thả ra để làm mới dữ liệu",
            completeText: "làm mới dữ liệu thành công",
            refreshingText: "đang làm mới dữ liệu",
            failedText: "làm mới dữ liệu bị lỗi",
            canTwoLevelText: "thả ra để làm mới dữ liệu",
          ),
          footer: const ClassicFooter(
            loadingText: "đang tải",
            noDataText: "không có thêm dữ liệu",
            canLoadingText: "kéo lên để tải thêm dữ liệu",
            failedText: "tải thêm dữ liệu bị lỗi",
            idleText: "kéo lên để tải thêm dữ liệu",
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ValueListenableBuilder<List<AddressResponse>>(
                  valueListenable: controller.addresses,
                  builder: (_, value, __) {
                    return IZIListView(
                      itemCount: value.length,
                      builder: (index) => GestureDetector(
                        onTap: () {
                          controller.updateDefaultAddress(address: value[index]);
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            top: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          padding: EdgeInsets.all(
                            IZIDimensions.SPACE_SIZE_4X,
                          ),
                          decoration: const BoxDecoration(
                            color: ColorResources.WHITE,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: IZIDimensions.SPACE_SIZE_2X),
                                child: Row(
                                  children: [
                                    IZIText(
                                      text: value[index].fullName ?? '',
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                        fontWeight: FontWeight.w600,
                                        color: ColorResources.NEUTRALS_1,
                                      ),
                                    ),
                                    const Spacer(),
                                    if (value[index].isDefault == true)
                                      IZIText(
                                        text: "[Mặc định]",
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_SPAN,
                                          fontWeight: FontWeight.w400,
                                          color: ColorResources.ORANGE,
                                        ),
                                      )
                                    else
                                      const SizedBox(),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    child: IZIText(
                                      maxLine: 6,
                                      text: "${value[index].phone} \n${controller.fullAddress(address: value[index])}",
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                        fontWeight: FontWeight.w400,
                                        color: ColorResources.NEUTRALS_3,
                                        // letterSpacing: 5,
                                        // wordSpacing: 10,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  Column(
                                    children: [
                                      PopupMenuButton<PopupMenuItemAddress>(
                                        onSelected: (PopupMenuItemAddress val) {
                                          controller.onHandlePopupMenuSelected(
                                            value: val,
                                            address: value[index],
                                          );
                                        },
                                        itemBuilder: (context) {
                                          return PopupMenuItemAddress.values
                                              .where((element) => element != PopupMenuItemAddress.create)
                                              .map(
                                            (e) {
                                              return PopupMenuItem<PopupMenuItemAddress>(
                                                value: e,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      PopupMenuItemAddress.update == e ? Icons.edit : Icons.delete,
                                                      color: PopupMenuItemAddress.update == e
                                                          ? ColorResources.GREEN
                                                          : ColorResources.RED,
                                                    ),
                                                    SizedBox(
                                                      width: IZIDimensions.SPACE_SIZE_2X,
                                                    ),
                                                    Text(
                                                      PopupMenuItemAddress.update == e ? "Cập nhật" : "Xoá",
                                                      style: TextStyle(
                                                        fontFamily: 'Roboto',
                                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                                        fontWeight: FontWeight.w400,
                                                        color: ColorResources.NEUTRALS_4,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ).toList();
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Container(
                  padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                  margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_2X),
                  decoration: const BoxDecoration(
                    color: ColorResources.WHITE,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IZIText(
                          text: "Thêm địa chỉ mới",
                          style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w400,
                              color: ColorResources.PRIMARY_9)),
                      GestureDetector(
                        onTap: () {
                          controller.onHandlePopupMenuSelected(
                              value: PopupMenuItemAddress.create, address: AddressResponse());
                        },
                        child: const Icon(
                          Icons.add,
                          color: ColorResources.ORANGE,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
