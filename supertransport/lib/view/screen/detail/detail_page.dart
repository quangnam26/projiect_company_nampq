import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/base_widget/izi_text.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/view/screen/detail/detail_controller.dart';
import 'package:timelines/timelines.dart';

class DetailGoCommonPage extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      appBar: const IZIAppBar(
        title: 'Chi tiết chuyến xe',
      ),
      body: GetBuilder<DetailController>(
        init: DetailController(),
        builder: (DetailController controller) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: IZIDimensions.SPACE_SIZE_4X,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_1X,
                  bottom: IZIDimensions.SPACE_SIZE_3X,
                ),
                padding: EdgeInsets.only(
                  top: IZIDimensions.SPACE_SIZE_4X,
                  left: IZIDimensions.SPACE_SIZE_2X,
                  right: IZIDimensions.SPACE_SIZE_2X,
                  bottom: IZIDimensions.SPACE_SIZE_4X,
                ),
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 4,
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_4X,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: IZIDimensions.ONE_UNIT_SIZE * 120,
                      width: IZIDimensions.ONE_UNIT_SIZE * 120,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.ONE_UNIT_SIZE * 100,
                        ),
                        child: IZIImage(
                          IZIValidate.nullOrEmpty(controller.transport!.idUser)
                              ? ''
                              : controller.transport!.idUser!.avatar ?? '',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IZIText(
                            text: IZIValidate.nullOrEmpty(controller.transport)
                                ? ''
                                : IZIValidate.nullOrEmpty(
                                        controller.transport!.idUser)
                                    ? ''
                                    : controller.transport!.idUser!.fullName ??
                                        '',
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6,
                              fontWeight: FontWeight.w500,
                              color: ColorResources.NEUTRALS_2,
                            ),
                          ),
                          IZIText(
                            text: IZIValidate.nullOrEmpty(controller.transport)
                                ? ''
                                : IZIValidate.nullOrEmpty(
                                        controller.transport!.idUser)
                                    ? ''
                                    : IZIValidate.nullOrEmpty(
                                        controller.transport!.idUser!.phone) ? '' : controller.transport!.idUser!.phone!.replaceRange(controller.transport!.idUser!.phone!.length -3, controller.transport!.idUser!.phone!.length, 'xxx'),
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w500,
                              color: ColorResources.NEUTRALS_4,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Time line
              timeLine(),

              // Thông tin Chuyến xe
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_1X,
                ),
                child: Column(
                  children: [
                    infoContent(
                      value: controller
                          .getLoaiHinh(controller.transport!.transportType!),
                      icon: Icons.grid_view_outlined,
                    ),
                    if (!IZIValidate.nullOrEmpty(
                        controller.transport!.idVehicle))
                      infoContent(
                        value: IZIValidate.nullOrEmpty(controller.transport)
                            ? ''
                            : IZIValidate.nullOrEmpty(
                                    controller.transport!.idVehicle)
                                ? ''
                                : controller.transport!.idVehicle!.name ?? '',
                        icon: controller.getVehicleIcon(controller.transport!),
                      ),
                    infoContent(
                      value: controller.getValueTransportType(
                          controller.transport!.transportType!),
                      icon: controller.getLoaiHinhIcon(
                          controller.transport!.transportType!),
                    ),
                    infoContent(
                      value: IZIValidate.nullOrEmpty(controller.transport)
                          ? ''
                          : IZIValidate.nullOrEmpty(
                                  controller.transport!.timeStart)
                              ? ''
                              : IZIDate.formatDate(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      controller.transport!.timeStart!),
                                  format: 'hh:mm a'),
                      icon: Icons.access_time_outlined,
                    ),
                    infoContent(
                      value: IZIValidate.nullOrEmpty(controller.transport)
                          ? ''
                          : IZIValidate.nullOrEmpty(
                                  controller.transport!.dateStart)
                              ? ''
                              : IZIDate.formatDate(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      controller.transport!.dateStart!)),
                      icon: Icons.date_range,
                    ),
                    if (!IZIValidate.nullOrEmpty(
                        controller.transport!.description))
                      infoContent(
                        value: IZIValidate.nullOrEmpty(controller.transport)
                            ? ''
                            : IZIValidate.nullOrEmpty(
                                    controller.transport!.description)
                                ? ''
                                : controller.transport!.description ?? '',
                        icon: Icons.menu_book,
                        alignment: CrossAxisAlignment.start,
                      ),
                  ],
                ),
              ),

              if(!IZIValidate.nullOrEmpty(controller.transport!.images))
              Container(
                height: IZIDimensions.ONE_UNIT_SIZE * 290,
                width: IZIDimensions.iziSize.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_4X,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_3X,
                  ),
                  child: IZIImage(
                    IZIValidate.nullOrEmpty(controller.transport!.images)
                        ? ''
                        : controller.transport!.images!.first.toString(),
                  ),
                ),
              ),
              SizedBox(
                height: IZIDimensions.SPACE_SIZE_4X,
              ),
              
              IZIButton(
                onTap: () {
                  controller.onClickButton(context);
                },
                colorBG: IZIValidate.nullOrEmpty(controller.transport!.idUser)
                    ? ColorResources.PRIMARY_1
                    : controller.transport!.idUser!.id == controller.idUser && controller.isFromHomePage == false
                        ? ColorResources.RED : ColorResources.PRIMARY_1

                //  ColorResources.NEUTRALS_4
                ,
                label: IZIValidate.nullOrEmpty(controller.transport!.idUser)
                    ? "Liên hệ ngay"
                    : controller.transport!.idUser!.id == controller.idUser && controller.isFromHomePage == false
                        ? "Tắt chuyến" : "Liên hệ ngay",
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget timeLine() {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      theme: TimelineThemeData(
        nodePosition: 0,
        color: ColorResources.NEUTRALS_5,
        connectorTheme: const ConnectorThemeData(
          thickness: 1.0,
        ),
      ),
      builder: TimelineTileBuilder.connected(
        indicatorBuilder: (context, index) {
          return DotIndicator(
            color: Colors.transparent,
            child: Container(
              alignment: Alignment.center,
              height: IZIDimensions.ONE_UNIT_SIZE * 70,
              width: IZIDimensions.ONE_UNIT_SIZE * 70,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorResources.ORANGE.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: ColorResources.ORANGE,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  controller.strlist[index]['icon'] as IconData,
                ),
              ),
            ),
          );
        },
        connectorBuilder: (_, index, connectorType) => const SolidLineConnector(
          indent: 2.0,
          endIndent: 2.0,
          color: ColorResources.NEUTRALS_4,
        ),
        contentsBuilder: (_, index) => Container(
          margin: EdgeInsets.only(
            left: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: Text(
            controller.strlist[index]['text'].toString(),
            style: TextStyle(
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              fontWeight: FontWeight.w500,
              color: ColorResources.NEUTRALS_3,
            ),
          ),
        ),
        itemExtentBuilder: (_, __) {
          return 70;
        },
        itemCount: controller.strlist.length,
      ),
    );
  }

  Widget infoContent(
      {required String value,
      required IconData icon,
      CrossAxisAlignment? alignment}) {
    return Container(
      margin: EdgeInsets.only(
        bottom: IZIDimensions.SPACE_SIZE_2X,
      ),
      child: Row(
        crossAxisAlignment: alignment ?? CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(
              right: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Icon(
              icon,
              color: ColorResources.NEUTRALS_4,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w500,
                color: ColorResources.NEUTRALS_4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
