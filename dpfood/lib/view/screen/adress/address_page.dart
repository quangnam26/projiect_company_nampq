import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_text_style.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import '../../../base_widget/izi_button.dart';
import '../../../base_widget/izi_input.dart';
import 'address_controller.dart';

class AddressPage extends GetView<AddressController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: Container(
        color: ColorResources.PRIMARY_1,
      ),
      safeAreaBottom: false,
      appBar: const IZIAppBar(
        title: "Nhập địa chỉ",
        colorBG: ColorResources.PRIMARY_1,
        colorTitle: ColorResources.WHITE,
      ),
      body: Obx(() {
        return controller.isLoading.isTrue
            ? IZILoaderOverLay(
                loadingWidget: spinKitWanderingCubes,
                body: Builder(builder: (context) {
                  onShowLoaderOverlay();
                  return Container(
                    color: ColorResources.WHITE,
                  );
                }),
              )
            : Container(
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
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: IZIDimensions.SPACE_SIZE_4X,
                          ),
                          IZIInput(
                            type: IZIInputType.TEXT,
                            placeHolder: 'Địa điểm hiện tại của bạn ở đâu?',
                            prefixIcon: (val) {
                              return Icon(
                                Icons.search,
                                size: IZIDimensions.ONE_UNIT_SIZE * 40,
                              );
                            },
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Text(
                              "Địa điểm của tôi",
                              style: textStyleH6.copyWith(
                                color: ColorResources.PRIMARY_5,
                              ),
                            ),
                          ),
                          Container(
                            color: ColorResources.WHITE,
                            padding: EdgeInsets.all(
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Column(
                              children: [
                                Obx(() {
                                  return address(
                                    icon: Icons.home,
                                    title: "Nhà",
                                    onEdit: () {
                                      controller.onUpdateAddress("Sửa địa chỉ", address: controller.home.value, type: 0, isUpdate: true);
                                    },
                                    onChange: (val) {
                                      controller.onChangeAddress(val: val, address: controller.home.value);
                                    },
                                    address: IZIValidate.nullOrEmpty(controller.home.value.name) ? 'Thêm địa chỉ' : controller.home.value.name ?? 'Thêm địa chỉ',
                                    value: controller.home.value.id.toString(),
                                    groupValue: controller.groupValue.value,
                                  );
                                }),
                                Obx(() {
                                  return address(
                                    icon: Icons.work,
                                    title: "Công ty",
                                    onEdit: () {
                                      controller.onUpdateAddress("Sửa địa chỉ", address: controller.company.value, type: 1, isUpdate: true);
                                    },
                                    onChange: (val) {
                                      controller.onChangeAddress(val: val, address: controller.company.value);
                                    },
                                    address: IZIValidate.nullOrEmpty(controller.company.value.name) ? 'Thêm địa chỉ' : controller.company.value.name ?? 'Thêm địa chỉ',
                                    value: controller.company.value.id.toString(),
                                    groupValue: controller.groupValue.value,
                                  );
                                }),
                                Obx(() {
                                  return ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: controller.address.length,
                                    itemBuilder: (context, index) {
                                      return Obx(() {
                                        return address(
                                          icon: Icons.location_on,
                                          title: "Địa chỉ",
                                          onEdit: () {
                                            controller.onUpdateAddress("Sửa địa chỉ", address: controller.address[index], isUpdate: true);
                                          },
                                          onChange: (val) {
                                            controller.onChangeAddress(val: val, address: controller.address[index]);
                                          },
                                          address: IZIValidate.nullOrEmpty(controller.address[index]) ? 'Thêm địa chỉ' : controller.address[index].name ?? 'Thêm địa chỉ',
                                          value: controller.address[index].id.toString(),
                                          groupValue: controller.groupValue.value,
                                        );
                                      });
                                    },
                                  );
                                }),
                                GestureDetector(
                                  onTap: () {
                                    controller.onUpdateAddress("Thêm địa chỉ", isUpdate: false);
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.add, color: ColorResources.PRIMARY_1),
                                      Text(
                                        'Thêm địa chỉ',
                                        style: textStyleH6.copyWith(
                                          color: ColorResources.PRIMARY_1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).viewPadding.bottom + IZIDimensions.ONE_UNIT_SIZE * 200,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      }),
      widgetBottomSheet: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: IZIDimensions.SPACE_SIZE_4X,
        ),
        child: IZIButton(
          onTap: () {
            controller.onUpdateAddress("Thêm địa chỉ", isUpdate: false);
          },
          label: "Thêm địa chỉ mới",
        ),
      ),
    );
  }

  ///
  /// Address
  ///
  Widget address({
    required IconData icon,
    required String title,
    String? address,
    required Function onEdit,
    required String value,
    required String groupValue,
    required Function(String val) onChange,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: (val) {
                onChange(val!);
              },
              activeColor: ColorResources.PRIMARY_1,
            ),
            Icon(
              icon,
              color: ColorResources.PRIMARY_5,
            ),
            SizedBox(
              width: IZIDimensions.SPACE_SIZE_2X,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textStyleH6.copyWith(
                      color: ColorResources.NEUTRALS_2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          address ?? "Lưu địa chỉ",
                          maxLines: 3,
                          style: textStyleSpan.copyWith(
                            color: ColorResources.PRIMARY_1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          onEdit();
                        },
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: IZIDimensions.SPACE_SIZE_2X,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: ColorResources.NEUTRALS_4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const Divider(
          thickness: 0.2,
          color: ColorResources.PRIMARY_1,
        ),
      ],
    );
  }
}
