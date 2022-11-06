import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:template/base_widget/izi_drop_down_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/view/screen/your_abilities/your_abilities_controller.dart';
import '../../../base_widget/background/background_premium.dart';
import '../../../base_widget/izi_app_bar.dart';
import '../../../base_widget/izi_loading.dart';
import '../../../base_widget/izi_screen.dart';
import '../../../base_widget/izi_smart_refresher.dart';
import '../../../data/model/subspecialize/subspecialize_response.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../helper/izi_validate.dart';
import '../../../utils/color_resources.dart';

class YourAbilitiesPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return IZIScreen(
      isSingleChildScrollView: false,
      background: const BackgroundApp(),
      appBar: const IZIAppBar(
        title: "Năng lực của bạn",
      ),
      body: GetBuilder(
        init: YourAbilitiesController(),
        builder: (YourAbilitiesController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }
          return SizedBox(
            width: IZIDimensions.iziSize.width,
            height: IZIDimensions.iziSize.height,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    0,
                  ),
                  child:

                      /// Search abilities.
                      _searchDropDow(controller),
                ),

                /// Divider.
                _divider(),

                ///  Load Abilities card.
                Expanded(
                  child: _abilitiesCard(controller),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// Search abilities.
  ///
  Obx _searchDropDow(YourAbilitiesController controller) {
    return Obx(
      () => DropDownButton<SubSpecializeResponse>(
        data: controller.subSpecializeResponseList,
        value: !IZIValidate.nullOrEmpty(controller.subSpecializeResponse.value) ? controller.subSpecializeResponse.value : null,
        isRequired: false,
        label: 'Tìm kiếm lĩnh vực',
        hint: 'Tìm kiếm lĩnh vực',
        onChanged: (val) {
          controller.onChangeSubSpecializeResponse(val!);
        },
        isSort: false,
      ),
    );
  }

  ///
  /// Divider.
  ///
  Container _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: IZIDimensions.SPACE_SIZE_3X),
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: IZIDimensions.ONE_UNIT_SIZE * .5,
              color: ColorResources.GREY,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Icon(
              Icons.star,
              size: IZIDimensions.ONE_UNIT_SIZE * 25,
              color: ColorResources.STAR_COLOR,
            ),
          ),
          Icon(
            Icons.star,
            size: IZIDimensions.ONE_UNIT_SIZE * 25,
            color: ColorResources.STAR_COLOR,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: IZIDimensions.SPACE_SIZE_1X,
            ),
            child: Icon(
              Icons.star,
              size: IZIDimensions.ONE_UNIT_SIZE * 25,
              color: ColorResources.STAR_COLOR,
            ),
          ),
          Expanded(
            child: Container(
              height: IZIDimensions.ONE_UNIT_SIZE * .5,
              color: ColorResources.GREY,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Load Abilities card.
  ///
  Obx _abilitiesCard(YourAbilitiesController controller) {
    return Obx(
      () {
        if (controller.isLoadingPaginate.value) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return IZISmartRefresher(
          refreshController: controller.refreshController,
          onLoading: controller.onLoadingData,
          onRefresh: controller.onRefreshData,
          enablePullDown: true,
          enablePullUp: true,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: controller.certificateResponseList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  controller.goToDetailAbilityPage(id: controller.certificateResponseList[index].id.toString());
                },
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    0,
                    IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                    IZIDimensions.SPACE_SIZE_4X,
                  ),
                  width: IZIDimensions.iziSize.width,
                  height: IZIDimensions.iziSize.width / 16 * 9,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                        child: IZIImage(
                          controller.certificateResponseList[index].thumbnail.toString(),
                          width: IZIDimensions.iziSize.width,
                          height: IZIDimensions.iziSize.width / 16 * 9,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_3X),
                        width: IZIDimensions.iziSize.width,
                        height: IZIDimensions.iziSize.width / 16 * 9,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.certificateResponseList[index].title.toString(),
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H5,
                                color: ColorResources.WHITE,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RatingBar.builder(
                                  glowColor: ColorResources.STAR_COLOR,
                                  unratedColor: Colors.black.withOpacity(.4),
                                  ignoreGestures: true,
                                  initialRating: controller.certificateResponseList[index].level!,
                                  minRating: 1,
                                  itemSize: IZIDimensions.ONE_UNIT_SIZE * 60,
                                  allowHalfRating: true,
                                  itemPadding: EdgeInsets.symmetric(
                                    horizontal: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  itemBuilder: (context, _) => Icon(
                                    Icons.star,
                                    color: ColorResources.STAR_COLOR,
                                    size: IZIDimensions.ONE_UNIT_SIZE * 60,
                                  ),
                                  onRatingUpdate: (rataing) {},
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: IZIDimensions.SPACE_SIZE_1X,
                                    horizontal: IZIDimensions.SPACE_SIZE_3X,
                                  ),
                                  child: Text(
                                    '${controller.certificateResponseList[index].percent!.toStringAsFixed(0)} / 100%',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6,
                                      color: ColorResources.WHITE,
                                    ),
                                  ),
                                ).asGlass(
                                  clipBorderRadius: BorderRadius.circular(
                                    IZIDimensions.ONE_UNIT_SIZE * 50,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
