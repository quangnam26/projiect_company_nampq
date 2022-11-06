import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:marquee/marquee.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:tiktoklikescroller/tiktoklikescroller.dart';
import '../../../base_widget/izi_loading.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeController(),
      builder: (HomeController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return Scaffold(
          backgroundColor: ColorResources.BLACK,
          body: Stack(
            children: [
              Obx(
                () {
                  if (controller.isLoadingQuestion.value == true) {
                    return Center(
                      child: IZILoading().isLoadingKit,
                    );
                  } else if (IZIValidate.nullOrEmpty(controller.questionResponseList)) {
                    return SizedBox(
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.iziSize.height,
                      child: Center(
                        child: Text(
                          'No_data'.tr,
                          style: TextStyle(
                            color: ColorResources.WHITE,
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Expanded(
                          child: TikTokStyleFullPageScroller(
                            swipePositionThreshold: 0.1,
                            controller: controller.controllerTikTok,
                            contentSize: controller.questionResponseList.length,
                            animationDuration: const Duration(milliseconds: 200),
                            swipeVelocityThreshold: 700,
                            builder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  controller.onGoToDetailQuestion(
                                    idQuestion: controller.questionResponseList[index].id.toString(),
                                    idUser: controller.questionResponseList[index].idUser!.id.toString(),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    /// Image question.
                                    if (IZIValidate.nullOrEmpty(controller.questionResponseList[index].attachImages))
                                      IZIImage(
                                        ImagesPath.image_home_page,
                                        height: IZIDimensions.iziSize.height,
                                        width: IZIDimensions.iziSize.width,
                                      )
                                    else
                                      _imageQuestion(controller, index),

                                    SafeArea(
                                      child: SizedBox(
                                        width: IZIDimensions.iziSize.width,
                                        height: IZIDimensions.iziSize.height,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.fromLTRB(
                                                IZIDimensions.SPACE_SIZE_2X,
                                                IZIDimensions.iziSize.width * .2,
                                                IZIDimensions.SPACE_SIZE_2X,
                                                0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  //Price Question
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                      IZIDimensions.SPACE_SIZE_1X,
                                                    ),
                                                    child: Text(
                                                      (controller.questionResponseList[index].moneyFrom != 0 && controller.questionResponseList[index].moneyTo != 0) ? "${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponseList[index].moneyFrom))}đ - ${IZIPrice.currencyConverterVND(IZINumber.parseDouble(controller.questionResponseList[index].moneyTo))}đ" : "free".tr,
                                                      style: TextStyle(
                                                        color: ColorResources.WHITE,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: IZIDimensions.FONT_SIZE_H6,
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                  ).asGlass(
                                                    tintColor: Colors.transparent,
                                                    clipBorderRadius: BorderRadius.circular(
                                                      IZIDimensions.BLUR_RADIUS_2X,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// Content Question.
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: IZIDimensions.SPACE_SIZE_5X,
                                              ),
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                  IZIDimensions.SPACE_SIZE_5X,
                                                ),
                                                child: Text(
                                                  controller.questionResponseList[index].content.toString(),
                                                  style: TextStyle(
                                                    color: ColorResources.WHITE,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: IZIDimensions.FONT_SIZE_H4,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ).asGlass(
                                                tintColor: Colors.transparent,
                                                clipBorderRadius: BorderRadius.circular(
                                                  IZIDimensions.BLUR_RADIUS_3X,
                                                ),
                                              ),
                                            ),

                                            Column(
                                              children: [
                                                /// Avatar User.
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                    IZIDimensions.SPACE_SIZE_2X,
                                                    0,
                                                    IZIDimensions.SPACE_SIZE_2X,
                                                    IZIDimensions.SPACE_SIZE_5X,
                                                  ),
                                                  child: _avatarUser(controller, index),
                                                ),

                                                /// Info user.
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                    IZIDimensions.SPACE_SIZE_2X,
                                                    0,
                                                    IZIDimensions.SPACE_SIZE_2X,
                                                    IZIDimensions.SPACE_SIZE_2X,
                                                  ),
                                                  width: IZIDimensions.iziSize.width,
                                                  child: _infoUser(controller, index),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        if (controller.isLoadingMore.value == true)
                          SizedBox(
                            width: IZIDimensions.iziSize.width,
                            height: IZIDimensions.iziSize.height * .08,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: IZIDimensions.SPACE_SIZE_3X,
                                  ),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                      color: ColorResources.WHITE,
                                    ),
                                    child: AnimatedTextKit(
                                      animatedTexts: [
                                        TyperAnimatedText(
                                          'Loading'.tr,
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                      repeatForever: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    );
                  }
                },
              ),

              // TabBar Home Page.
              Stack(
                children: [
                  Positioned(
                    top: -IZIDimensions.ONE_UNIT_SIZE * 120,
                    left: -IZIDimensions.ONE_UNIT_SIZE * 80,
                    child: Container(
                      height: IZIDimensions.iziSize.width * 0.4,
                      width: IZIDimensions.iziSize.width * 0.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.WHITE.withOpacity(.3),
                            ColorResources.WHITE.withOpacity(.3),
                            ColorResources.WHITE.withOpacity(.2),
                            ColorResources.WHITE.withOpacity(.005),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -IZIDimensions.ONE_UNIT_SIZE * 260,
                    right: -IZIDimensions.ONE_UNIT_SIZE * 70,
                    child: Container(
                      height: IZIDimensions.iziSize.height * 0.4,
                      width: IZIDimensions.iziSize.width * 0.4,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            ColorResources.WHITE.withOpacity(.005),
                            ColorResources.WHITE.withOpacity(.1),
                            ColorResources.WHITE.withOpacity(.2),
                            ColorResources.WHITE.withOpacity(.005),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(
                        0,
                        IZIDimensions.SPACE_SIZE_5X,
                        0,
                        0,
                      ),
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.iziSize.height,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// TabBar HomePage
                          Container(
                            margin: EdgeInsets.fromLTRB(
                              IZIDimensions.SPACE_SIZE_5X,
                              0,
                              IZIDimensions.SPACE_SIZE_5X,
                              0,
                            ),
                            child: Obx(() => _tabBarQuestion(controller)),
                          ),

                          //My Question
                          Obx(() {
                            if (!IZIValidate.nullOrEmpty(controller.questionResponseShowHome.value.id)) {
                              return _myQuestion(controller);
                            }
                            return const SizedBox();
                          })
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  ///
  /// TabBar Home Page.
  ///
  Widget _tabBarQuestion(HomeController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ...List.generate(
              controller.titleTabBar.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    controller.onChangeTabBar(index: index);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: IZIDimensions.ONE_UNIT_SIZE * 3,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              index == 0 ? "question".tr : "my_question".tr,
                              style: TextStyle(
                                fontWeight: controller.currentIndex.value == index ? FontWeight.w600 : FontWeight.normal,
                                fontSize: controller.currentIndex.value == index ? IZIDimensions.FONT_SIZE_H5 * .9 : IZIDimensions.FONT_SIZE_H5 * .8,
                                color: ColorResources.WHITE,
                              ),
                            ),
                            if (index == 0)
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                width: IZIDimensions.ONE_UNIT_SIZE * 3,
                                height: IZIDimensions.ONE_UNIT_SIZE * 30,
                                decoration: const BoxDecoration(
                                  color: ColorResources.WHITE,
                                ),
                              )
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),

        /// Notifications
        Obx(
          () => GestureDetector(
            onTap: () {
              controller.goToNotificationPage();
            },
            child: controller.countNotice.value != 0
                ? Badge(
                    padding: EdgeInsets.all(IZIDimensions.ONE_UNIT_SIZE * 10),
                    badgeContent: Text(
                      controller.countNotice.value > 10 ? "10+" : controller.countNotice.value.toString(),
                      style: TextStyle(
                        color: ColorResources.WHITE,
                        fontWeight: FontWeight.w600,
                        fontSize: IZIDimensions.FONT_SIZE_SPAN * .9,
                      ),
                    ),
                    child: Icon(
                      Icons.notifications_active_rounded,
                      color: ColorResources.WHITE,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                    ),
                  )
                : Icon(
                    Icons.notifications_active_rounded,
                    color: ColorResources.WHITE,
                    size: IZIDimensions.ONE_UNIT_SIZE * 50,
                  ),
          ),
        )
      ],
    );
  }

  ///
  /// Image question.
  ///
  Widget _imageQuestion(HomeController controller, int index) {
    return PageView(
      children: [
        ...List.generate(
          controller.questionResponseList[index].attachImages!.length,
          (i) {
            return Container(
              height: IZIDimensions.iziSize.height,
              width: IZIDimensions.iziSize.width,
              color: ColorResources.BLACK,
              child: Center(
                child: IZIImage(
                  controller.questionResponseList[index].attachImages![i].toString(),
                  height: IZIDimensions.iziSize.height,
                  width: IZIDimensions.iziSize.width,
                  fit: BoxFit.contain,
                ),
              ),
            );
          },
        )
      ],
    );
  }

  ///
  /// Avatar User.
  ///
  Widget _avatarUser(HomeController controller, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            controller.onGoToViewProfileUserCreateQues(idUser: controller.questionResponseList[index].idUser!.id.toString());
          },
          child: ClipOval(
            child: Container(
              color: ColorResources.WHITE,
              width: IZIDimensions.ONE_UNIT_SIZE * 85,
              height: IZIDimensions.ONE_UNIT_SIZE * 85,
              child: Center(
                child: ClipOval(
                  child: IZIImage(
                    IZIValidate().getTypeAvatarString(controller.questionResponseList[index].idUser!.avatar.toString()),
                    width: IZIDimensions.ONE_UNIT_SIZE * 80,
                    height: IZIDimensions.ONE_UNIT_SIZE * 80,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///
  /// Info User.
  ///
  Widget _infoUser(HomeController controller, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_1X * .5,
          ),
          child: Text(
            controller.questionResponseList[index].idUser!.fullName.toString(),
            style: TextStyle(
              color: ColorResources.WHITE,
              fontWeight: FontWeight.w600,
              fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.SPACE_SIZE_1X * .5,
          ),
          child: Text(
            controller.questionResponseList[index].hashTag.toString(),
            style: TextStyle(
              color: ColorResources.WHITE,
              fontSize: IZIDimensions.FONT_SIZE_SPAN,
              fontStyle: FontStyle.italic,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            bottom: IZIDimensions.ONE_UNIT_SIZE * 60,
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(
                  right: IZIDimensions.ONE_UNIT_SIZE * 5,
                ),
                child: const Icon(
                  Icons.stars,
                  color: ColorResources.PRIMARY_TAB_BAR,
                ),
              ),
              Expanded(
                child: Text(
                  controller.questionResponseList[index].idSubSpecialize!.name.toString(),
                  style: TextStyle(
                    color: ColorResources.WHITE,
                    fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  ///
  /// My Question.
  ///
  Widget _myQuestion(HomeController controller) {
    return GestureDetector(
      onTap: () {
        controller.onGoToHelpWatingListPage(
          idQuestion: controller.questionResponseShowHome.value.id.toString(),
        );
      },
      child: Container(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.ONE_UNIT_SIZE * 50,
        color: ColorResources.MY_QUESTION,
        padding: EdgeInsets.symmetric(
          vertical: IZIDimensions.SPACE_SIZE_1X,
          horizontal: IZIDimensions.SPACE_SIZE_2X,
        ),
        child: Row(
          children: [
            Expanded(
              child: Marquee(
                text: '${'Questions_about'.tr}“${controller.questionResponseShowHome.value.content.toString()}” ${!IZIValidate.nullOrEmpty(controller.fullNameUserQuoteQuestion.value) ? controller.fullNameUserQuoteQuestion.value : ''} ${IZIValidate.getValueStringTypeStatusQuestion(controller.questionResponseShowHome.value.statusQuestion)}',
                style: TextStyle(
                  color: ColorResources.WHITE,
                  fontSize: IZIDimensions.FONT_SIZE_SPAN,
                  fontWeight: FontWeight.normal,
                ),
                crossAxisAlignment: CrossAxisAlignment.start,
                blankSpace: 20.0,
                startPadding: IZIDimensions.SPACE_SIZE_2X,
                accelerationCurve: Curves.linear,
                decelerationCurve: Curves.easeOut,
                startAfter: const Duration(seconds: 3),
                pauseAfterRound: const Duration(seconds: 3),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: ColorResources.WHITE,
            ),
          ],
        ),
      ),
    );
  }
}
