import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/view/screen/news/detailednews/detailed_news_controller.dart';
import '../../../../base_widget/background/backround_appbar.dart';
import '../../../../base_widget/izi_app_bar.dart';
import '../../../../base_widget/izi_image.dart';
import '../../../../utils/color_resources.dart';

class DetailedNewPage extends GetView<DetailedNewController> {
  // ignore: avoid_returning_null_for_void
  void get style => null;

  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      background: const BackgroundAppBar(),
      appBar: IZIAppBar(
        title: 'Chi tiết tin tức ',
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
        init: DetailedNewController(),
        builder: (DetailedNewController controller) {
          if (controller.isloading) {
            return SizedBox(
              height: IZIDimensions.iziSize.height * 0.8,
              child: const Center(
                child: CircularProgressIndicator(
                  color: ColorResources.ORANGE,
                ),
              ),
            );
          }
          return Container(
            // margin: EdgeInsets.only(left: 30),
            height: IZIDimensions.iziSize.height,
            color: ColorResources.NEUTRALS_11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IZIImage(
                  controller.newsResponse.image.toString(),
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.ONE_UNIT_SIZE * 270,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_3X,
                      right: IZIDimensions.SPACE_SIZE_3X,
                      bottom: IZIDimensions.SPACE_SIZE_3X),
                  child: Row(
                    children: [
                      const Spacer(),
                      const Icon(
                        Icons.visibility_outlined,
                        color: ColorResources.NEUTRALS_17,
                      ),
                      SizedBox(
                        width: IZIDimensions.ONE_UNIT_SIZE * 5,
                      ),
                      Text(
                        controller.newsResponse.numberView.toString(),
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: ColorResources.NEUTRALS_17,
                          fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: IZIDimensions.SPACE_SIZE_3X,
                      ),
                      Row(
                        children: [
                          const Icon(
                            CupertinoIcons.calendar,
                            color: ColorResources.GREY,
                            size: 22,
                          ),
                          SizedBox(
                            width: IZIDimensions.ONE_UNIT_SIZE * 4,
                          ),
                          Text(
                            IZIDate.dateFormatUtc(
                                controller.newsResponse.createdAt!),
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              color: ColorResources.NEUTRALS_17,
                              fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_5X),
                  child: Text(
                    controller.newsResponse.title.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_H6,
                        color: ColorResources.PRIMARY_9),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: IZIDimensions.SPACE_SIZE_1X,
                      left: IZIDimensions.SPACE_SIZE_5X,
                      right: IZIDimensions.SPACE_SIZE_4X),
                  child: Text(
                    controller.newsResponse.description.toString(),
                    style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        fontSize: IZIDimensions.FONT_SIZE_H6 * 0.9,
                        height: 1.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
