import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/main.dart';
import 'package:template/utils/color_resources.dart';
import '../../../base_widget/background/background_home.dart';
import '../../../base_widget/izi_image.dart';
import '../../../base_widget/izi_input.dart';
import '../../../helper/izi_validate.dart';
import 'components/superTransportCard.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundHome(),
      body: GetBuilder(
        builder: (HomeController controller) {
          return SizedBox(
            height: IZIDimensions.iziSize.height,
            width: IZIDimensions.iziSize.width,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: IZIDimensions.SPACE_SIZE_4X,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_4X,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: IZIDimensions.ONE_UNIT_SIZE * 40,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: IZIImage(
                                  IZIValidate.nullOrEmpty(controller.userRequest) ? '' : controller.userRequest.value.avatar ?? '',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: IZIDimensions.ONE_UNIT_SIZE * 30,
                            ),
                            Obx(() {
                              return Text(
                                "Xin chào, ${IZIValidate.nullOrEmpty(controller.userRequest) ? '' : controller.userRequest.value.fullName ?? ''}",
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: IZIDimensions.FONT_SIZE_H5,
                                  color: ColorResources.WHITE,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 10,
                        ),
                        SizedBox(
                          width: IZIDimensions.iziSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Khi bạn cần",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6,
                                  color: ColorResources.WHITE,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              Text(
                                "Chúng tôi luôn sẵn sàng",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H5,
                                  color: ColorResources.WHITE,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Form
                        SizedBox(
                          height: IZIDimensions.ONE_UNIT_SIZE * 20,
                        ),
                        searchInput(
                          context,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(IZIDimensions.ONE_UNIT_SIZE * 30),
                          topRight: Radius.circular(IZIDimensions.ONE_UNIT_SIZE * 30),
                        ),
                        color: ColorResources.WHITE,
                      ),
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
                        child: Obx(
                          () {
                            return controller.buildObx(
                              (state) {
                                return ListView.builder(
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
                                );
                              },
                              connectionStatus: connectionStatus.value,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget searchInput(BuildContext context) {
    return IZIInput(
      type: IZIInputType.TEXT,
      placeHolder: 'Nhập tài xế ...',
      disbleError: true,
      prefixIcon: Icon(
        Icons.search,
        size: IZIDimensions.ONE_UNIT_SIZE * 45,
      ),
      suffixIcon: GestureDetector(
        onTap: () {
          controller.onShowFilter(context);
        },
        child: Icon(
          Icons.filter_alt,
          color: ColorResources.PRIMARY_2,
          size: IZIDimensions.ONE_UNIT_SIZE * 45,
        ),
      ),
      isResfreshForm: IZIValidate.nullOrEmpty(controller.searchTerm),
      fillColor: ColorResources.WHITE.withOpacity(0.25),
      borderRadius: 5,
      onTap: (){
        controller.onShowFilter(context);
      },
      // onChanged: (val){
      //   controller.searchTerm = val;
      //   controller.onSearch();
      // },
    );
  }

}
