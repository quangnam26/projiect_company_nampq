import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/background/background_premium.dart';
import 'package:template/base_widget/izi_app_bar.dart';
import 'package:template/base_widget/izi_box_image.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/base_widget/izi_screen.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/detail_profile_people/detail_profile_people_controller.dart';

class DetailProfilePeoplePage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return true;
      },
      child: IZIScreen(
        isSingleChildScrollView: false,
        background: const BackgroundApp(),
        appBar: IZIAppBar(
          title: "title_app_bar_detail_2".tr,
        ),
        body: GetBuilder(
          init: DetailProfilePeopleController(),
          builder: (DetailProfilePeopleController controller) {
            if (controller.isLoading) {
              return Center(
                child: IZILoading().isLoadingKit,
              );
            }
            return Container(
              color: ColorResources.BACKGROUND,
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height,
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      if (!IZIValidate.nullOrEmpty(controller.userResponse.value.myAlbum)) {
                        return

                            /// Avatar Profile.
                            Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_5X,
                          ),
                          width: IZIDimensions.iziSize.width,
                          height: IZIDimensions.iziSize.height * .4,
                          child: _avatarProfile(controller),
                        );
                      }

                      return const SizedBox();
                    }),
                    SafeArea(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() => Container(
                                margin: EdgeInsets.fromLTRB(
                                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                  !IZIValidate.nullOrEmpty(controller.userResponse.value.myAlbum) ? 0 : IZIDimensions.SPACE_SIZE_4X,
                                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                  IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  controller.userResponse.value.fullName.toString(),
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6,
                                    color: ColorResources.BLACK,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )),
                          Obx(() => Container(
                                margin: EdgeInsets.fromLTRB(
                                  IZIDimensions.SPACE_SIZE_2X,
                                  0,
                                  IZIDimensions.SPACE_SIZE_2X,
                                  IZIDimensions.ONE_UNIT_SIZE * 30,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.pin_drop_outlined,
                                      color: ColorResources.PRIMARY_APP,
                                    ),
                                    Expanded(
                                      child: Text(
                                        controller.genStringAddress(
                                          controller.userResponse.value.address.toString(),
                                          controller.userResponse.value.idProvince,
                                          controller.userResponse.value.nation.toString(),
                                        ),
                                        style: TextStyle(
                                          fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                          color: ColorResources.BLACK.withOpacity(.8),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),

                          /// Rated.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.ONE_UNIT_SIZE * 30,
                            ),
                            padding: EdgeInsets.all(
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.BLUR_RADIUS_4X,
                              ),
                              border: Border.all(
                                width: IZIDimensions.ONE_UNIT_SIZE * 1,
                                color: ColorResources.GREY,
                              ),
                            ),
                            child: _rated(controller),
                          ),

                          /// Detail Info.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.ONE_UNIT_SIZE * 30,
                            ),
                            child: _detailInfor(controller),
                          ),

                          /// Experience.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.ONE_UNIT_SIZE * 30,
                            ),
                            child: _experience(controller),
                          ),

                          /// Comment.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.ONE_UNIT_SIZE * 30,
                            ),
                            child: _comment(controller),
                          ),

                          /// Images.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: _images(controller),
                          ),

                          /// Certificates.
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              0,
                              IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                              IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: _certificates(controller),
                          ),

                          Obx(() {
                            if (controller.statusSelect.value != SELECTED && controller.statusQuestion.value != COMPLETED) {
                              return //Button
                                  IZIButton(
                                margin: EdgeInsets.fromLTRB(
                                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                  IZIDimensions.SPACE_SIZE_5X,
                                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                  IZIDimensions.SPACE_SIZE_5X,
                                ),
                                onTap: () {
                                  controller.onShowDialog();
                                },
                                label: "Select_account_quote".tr,
                              );
                            }

                            return const SizedBox();
                          })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  ///
  /// Avatar Profile.
  ///
  Widget _avatarProfile(DetailProfilePeopleController controller) {
    return Obx(() => Stack(
          children: [
            SizedBox(
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height * .33,
              child: PageView.builder(
                onPageChanged: (val) {
                  controller.onPageChanged(index: val);
                },
                controller: controller.pageController,
                itemCount: controller.userResponse.value.myAlbum!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.onGoToPreviewImage(
                        urlImage: controller.userResponse.value.myAlbum![index].toString(),
                      );
                    },
                    child: IZIImage(
                      controller.userResponse.value.myAlbum![index].toString(),
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.iziSize.height * .33,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.width * .27,
                child: ListView.builder(
                  controller: controller.controllerItemAvatar,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: controller.userResponse.value.myAlbum!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.clickToAvatar(index: index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 0 : IZIDimensions.SPACE_SIZE_3X,
                        ),
                        child: Center(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                IZIDimensions.BORDER_RADIUS_5X,
                              ),
                              child: Obx(() {
                                return IZIImage(
                                  controller.userResponse.value.myAlbum![index].toString(),
                                  width: controller.currentIndex.value == index ? IZIDimensions.iziSize.width * .38 : IZIDimensions.iziSize.width * .34,
                                  height: controller.currentIndex.value == index ? IZIDimensions.iziSize.width * .25 : IZIDimensions.iziSize.width * .21,
                                );
                              })),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }

  ///
  /// Rated.
  ///
  Widget _rated(DetailProfilePeopleController controller) {
    return Obx(() => Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_2X,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    initialRating: (controller.userResponse.value.statisticReview!.totalRating != 0 && controller.userResponse.value.statisticReview!.countRating != 0) ? (controller.userResponse.value.statisticReview!.totalRating! / controller.userResponse.value.statisticReview!.countRating!) : 0,
                    minRating: 1,
                    itemSize: IZIDimensions.ONE_UNIT_SIZE * 40,
                    allowHalfRating: true,
                    itemPadding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.SPACE_SIZE_1X,
                    ),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: ColorResources.STAR_COLOR,
                      size: IZIDimensions.ONE_UNIT_SIZE * 40,
                    ),
                    onRatingUpdate: (rataing) {},
                  ),
                  Text(
                    (controller.userResponse.value.statisticReview!.totalRating != 0 && controller.userResponse.value.statisticReview!.countRating != 0) ? (controller.userResponse.value.statisticReview!.totalRating! / controller.userResponse.value.statisticReview!.countRating!).toStringAsPrecision(2) : '0.0',
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Reputation".tr,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                color: ColorResources.BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: IZIImage(
                              ImagesPath.prestige_detail_profile,
                              color: ColorResources.PRIMARY_APP,
                            ),
                          ),
                          Text(
                            (controller.userResponse.value.statisticReview!.countReputation! != 0 && controller.userResponse.value.statisticReview!.totalReputation! != 0) ? (controller.userResponse.value.statisticReview!.totalReputation! / controller.userResponse.value.statisticReview!.countReputation!).toStringAsFixed(0) : "0",
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 2,
                  height: IZIDimensions.ONE_UNIT_SIZE * 50,
                  color: ColorResources.BLACK.withOpacity(.6),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Satisfied".tr,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                color: ColorResources.BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: IZIImage(
                              ImagesPath.logo_satisfied,
                              color: ColorResources.PRIMARY_APP,
                            ),
                          ),
                          Text(
                            controller.userResponse.value.statisticReview!.numberStatisfied!.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 2,
                  height: IZIDimensions.ONE_UNIT_SIZE * 50,
                  color: ColorResources.BLACK.withOpacity(.6),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          bottom: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Unsatisfied".tr,
                              style: TextStyle(
                                fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                color: ColorResources.BLACK,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                              right: IZIDimensions.SPACE_SIZE_1X,
                            ),
                            child: IZIImage(
                              ImagesPath.logo_unsatisfied,
                              color: ColorResources.PRIMARY_APP,
                            ),
                          ),
                          Text(
                            controller.userResponse.value.statisticReview!.numberNotStatisfied!.toStringAsFixed(0),
                            style: TextStyle(
                              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                              color: ColorResources.BLACK,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  ///
  /// Detail Info.
  ///
  Widget _detailInfor(DetailProfilePeopleController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Time
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: IZIImage(
                          ImagesPath.logo_calendar_detail_question,
                          color: ColorResources.PRIMARY_APP,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: !IZIValidate.nullOrEmpty(controller.userResponse.value.born) ? IZIDate.formatDate(controller.userResponse.value.born!) : 'Not_updated_yet'.tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Sex
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Container(
                        margin: EdgeInsets.only(
                          right: IZIDimensions.SPACE_SIZE_1X,
                        ),
                        child: IZIImage(
                          controller.userResponse.value.gender == FEMALE
                              ? ImagesPath.female_detail_profile
                              : controller.userResponse.value.gender == ALL
                                  ? ImagesPath.other_gender_detail_profile
                                  : ImagesPath.male_detail_profile,
                          color: ColorResources.PRIMARY_APP,
                        ),
                      ),
                    ),
                    TextSpan(
                      text: IZIValidate.getGenderString(controller.userResponse.value.gender),
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                        color: ColorResources.BLACK,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Total answer question
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                    child: Container(
                      margin: EdgeInsets.only(
                        right: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      child: IZIImage(
                        ImagesPath.total_answer_question_detail_profile,
                        color: ColorResources.PRIMARY_APP,
                      ),
                    ),
                  ),
                  TextSpan(
                    text: "${controller.userResponse.value.statisticReview!.totalRating!.toStringAsFixed(0)} ${'Answered_question'.tr}",
                    style: TextStyle(
                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                      color: ColorResources.BLACK,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  ///
  /// Experience.
  ///
  Widget _experience(DetailProfilePeopleController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                "experience".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (IZIValidate.nullOrEmpty(controller.userResponse.value.experiences))
              Text(
                "No_experience".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                ),
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.userResponse.value.experiences!.length <= 2 ? controller.userResponse.value.experiences!.length : 2,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: index == 0 ? 0 : IZIDimensions.SPACE_SIZE_3X,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_4X,
                      ),
                      border: Border.all(
                        width: IZIDimensions.ONE_UNIT_SIZE * 1,
                        color: ColorResources.GREY,
                      ),
                    ),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    width: IZIDimensions.iziSize.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            bottom: IZIDimensions.SPACE_SIZE_1X,
                          ),
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Field".tr,
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    fontWeight: FontWeight.w600,
                                    color: ColorResources.BLACK,
                                  ),
                                ),
                                TextSpan(
                                  text: controller.userResponse.value.experiences![index].fieldName.toString(),
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    color: ColorResources.BLACK,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Years_experience".tr,
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  fontWeight: FontWeight.w600,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                              TextSpan(
                                text: "${controller.userResponse.value.experiences![index].year} ${'year'.tr}",
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ));
  }

  ///
  /// Comment.
  ///
  Widget _comment(DetailProfilePeopleController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X,
              ),
              child: Text(
                "Comment".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  color: ColorResources.BLACK,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (IZIValidate.nullOrEmpty(controller.reviewsResponseList))
              Text(
                "validate_comment".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                ),
              )
            else
              ListView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.reviewsResponseList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: index == 0 ? 0 : IZIDimensions.SPACE_SIZE_3X,
                    ),
                    decoration: BoxDecoration(
                      color: ColorResources.WHITE,
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BLUR_RADIUS_4X,
                      ),
                      border: Border.all(
                        width: IZIDimensions.ONE_UNIT_SIZE * 1,
                        color: ColorResources.GREY,
                      ),
                    ),
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    width: IZIDimensions.iziSize.width,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: IZIDimensions.SPACE_SIZE_3X,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              IZIDimensions.BLUR_RADIUS_3X,
                            ),
                            child: IZIImage(
                              IZIValidate().getTypeAvatarString(controller.reviewsResponseList[index].idAnswerer!.avatar.toString()),
                              width: IZIDimensions.iziSize.width * .18,
                              height: IZIDimensions.iziSize.width * .18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  controller.reviewsResponseList[index].idAnswerer!.fullName.toString(),
                                  style: TextStyle(
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    color: ColorResources.CALL_VIDEO,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Text(
                                controller.reviewsResponseList[index].content.toString(),
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.BLACK,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ));
  }

  ///
  /// Images.
  ///
  Widget _images(DetailProfilePeopleController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X * .5,
              ),
              child: Text(
                "Capability_description".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
            ),
            if (IZIValidate.nullOrEmpty(controller.userResponse.value.certificates))
              Text(
                "validate_bility".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                ),
              )
            else
              IZIBoxImage(
                images: controller.userResponse.value.certificates,
                onDelete: (val, values) {},
                onPress: () {},
                onPreviewImages: (val, values) {
                  controller.onGoToPreviewImage(urlImage: val);
                },
              ),
          ],
        ));
  }

  ///
  /// Certificates.
  ///
  Widget _certificates(DetailProfilePeopleController controller) {
    return Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                bottom: IZIDimensions.SPACE_SIZE_1X * .5,
              ),
              child: Text(
                'certificate'.tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                  fontWeight: FontWeight.w600,
                  color: ColorResources.BLACK,
                ),
              ),
            ),
            if (IZIValidate.nullOrEmpty(controller.historyQuizResponseList))
              Text(
                "Not_updated_yet".tr,
                style: TextStyle(
                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.historyQuizResponseList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    width: IZIDimensions.iziSize.width,
                    padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        IZIDimensions.BORDER_RADIUS_2X,
                      ),
                      color: ColorResources.WHITE,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_2X,
                          ),
                          child: IZIImage(
                            controller.historyQuizResponseList[index].idCertificate!.thumbnail.toString(),
                            width: IZIDimensions.ONE_UNIT_SIZE * 140,
                            height: IZIDimensions.ONE_UNIT_SIZE * 140,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: IZIDimensions.SPACE_SIZE_2X,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    controller.historyQuizResponseList[index].idCertificate!.title.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    '${'percent_certi'.tr} ${controller.historyQuizResponseList[index].percent!.toStringAsFixed(0)}/100%',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    '${'number_exam_certi'.tr} ${controller.historyQuizResponseList[index].numberTest}',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    bottom: IZIDimensions.SPACE_SIZE_1X,
                                  ),
                                  child: Text(
                                    '${'last_date_certi'.tr} ${IZIDate.formatDate(controller.historyQuizResponseList[index].updatedAt!)}',
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
          ],
        ));
  }
}
