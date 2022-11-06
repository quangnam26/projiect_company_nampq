import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/background/backround_appbar.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/view/screen/trains/train_controller.dart';
import '../../../base_widget/izi_loading_list.dart';
import '../../../helper/izi_validate.dart';
import '../../../main.dart';
import '../../../utils/color_resources.dart';
import '../home/components/superTransportCard.dart';

class TrainPage extends GetView<TrainController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      appBar: IZIAppBar(
        title: "Danh sách chuyến xe",
        colorTitle: ColorResources.WHITE,
        iconBack: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: ColorResources.WHITE,
          ),
        ),
      ),
      background: const BackgroundAppBar(),
      body: Obx(
        () {
          return controller.buildObx(
            (val) {
              return SizedBox(
                height: IZIDimensions.iziSize.height,
                width: IZIDimensions.iziSize.width,
                child: Center(
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.transports.length,
                        itemBuilder: (context, index) {
                          // 0: Cần xe,  1: Đi chung, 2: Gửi đồ, 3: Cho gửi đồ
                          return GestureDetector(
                            onTap: () {
                              controller.onTapTransport(
                                transport: controller.transports[index],
                              );
                            },
                            child: SuperTransportCard(
                              name: IZIValidate.nullOrEmpty(controller.transports[index].idUser) ? 'Không rõ' : controller.transports[index].idUser!.fullName.toString(),
                              address: IZIValidate.nullOrEmpty(controller.transports[index]) ? '' : controller.startAddress(controller.transports[index]),
                              createDate: IZIDate.formatDate(DateTime.fromMillisecondsSinceEpoch(controller.transports[index].dateStart!)),
                              onTap: () {
                                controller.onTapTransport(
                                  transport: controller.transports[index],
                                );
                              },
                              transportType: IZIValidate.nullOrEmpty(controller.transports[index].transportType)
                                  ? TRANSPORTTYPE.CAN_XE
                                  : controller.getTransportType(
                                      controller.transports[index].transportType!,
                                    ),
                              value: controller
                                  .getTransportValue(
                                    transport: controller.transports[index],
                                  )
                                  .toString(),
                              image: IZIValidate.nullOrEmpty(controller.transports[index].idUser) ? '' : controller.transports[index].idUser!.avatar.toString(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
            onError: (error) {
              return const Center(
                child: Text("Đã xảy ra lỗi"),
              );
            },
            onLoading: IZILoadingList(),
            connectionStatus: connectionStatus.value,
          );
        },
      ),
    );
  }
}
