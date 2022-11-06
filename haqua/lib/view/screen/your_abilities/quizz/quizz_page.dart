import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/view/screen/your_abilities/quizz/quizz_controller.dart';
import 'package:video_player/video_player.dart';
import '../../../../base_widget/izi_loading.dart';
import '../../../../helper/izi_date.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../utils/app_constants.dart';
import '../../../../utils/color_resources.dart';
import '../../../../utils/images_path.dart';

class QuizzPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: QuizzController(),
      builder: (QuizzController controller) {
        if (controller.isLoading) {
          return Center(
            child: IZILoading().isLoadingKit,
          );
        }
        return WillPopScope(
          onWillPop: () async {
            controller.showExitConfirmationDialog();
            return true;
          },
          child: Scaffold(
            backgroundColor: ColorResources.BACKGROUND_QUIZ_COLOR,
            body: SizedBox(
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SvgPicture.asset(
                      ImagesPath.quiz_background,
                      width: IZIDimensions.iziSize.width,
                      height: IZIDimensions.iziSize.height,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            width: IZIDimensions.iziSize.width,
                            height: kToolbarHeight,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    controller.showExitConfirmationDialog();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: ColorResources.WHITE,
                                    size: IZIDimensions.ONE_UNIT_SIZE * 45,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Obx(() => Text(
                                          'Tổng điểm: ${controller.point.value}/${controller.totalPoint.value}',
                                          style: TextStyle(
                                            color: ColorResources.WHITE,
                                            fontSize: IZIDimensions.FONT_SIZE_H6,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: ColorResources.WHITE,
                                    size: IZIDimensions.ONE_UNIT_SIZE * 45,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN),
                            child:

                                /// Linear time count dow.
                                _linearTimeCountDow(controller),
                          ),

                          /// Selected quiz.
                          Expanded(
                            child: Obx(
                              () => PageView(
                                controller: controller.pageController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  ...List.generate(controller.quizResponsesList.length, (index) {
                                    return SizedBox(
                                      width: IZIDimensions.iziSize.width,
                                      height: IZIDimensions.iziSize.height,
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Obx(
                                              () => Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                                      top: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                                    ),
                                                    child: Text('Câu ${index + 1}: ',
                                                        style: TextStyle(
                                                          color: ColorResources.WHITE,
                                                          fontSize: IZIDimensions.FONT_SIZE_H6,
                                                        )),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.symmetric(
                                                      horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                                      vertical: IZIDimensions.SPACE_SIZE_3X,
                                                    ),
                                                    width: IZIDimensions.iziSize.width,
                                                    padding: controller.generateTypeQuestion() == TEXT_TYPE_QUESTION || controller.generateTypeQuestion() == AUDIO_TYPE_QUESTION
                                                        ? EdgeInsets.symmetric(
                                                            horizontal: IZIDimensions.SPACE_SIZE_2X,
                                                            vertical: IZIDimensions.SPACE_SIZE_2X,
                                                          )
                                                        : EdgeInsets.zero,
                                                    decoration: BoxDecoration(
                                                      color: ColorResources.WHITE,
                                                      borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        if (controller.generateTypeQuestion() == IMAGE_TYPE_QUESTION)

                                                          ///
                                                          /// Image type question.
                                                          IZIImage(
                                                            controller.quizResponsesList[index].imageQuestion.toString(),
                                                            width: IZIDimensions.iziSize.width,
                                                            height: IZIDimensions.iziSize.width / 16 * 9,
                                                          )
                                                        else if (controller.generateTypeQuestion() == VIDEO_TYPE_QUESTION)

                                                          ///
                                                          /// Video type question.
                                                          _videoTypeQuestion(controller)
                                                        else if (controller.generateTypeQuestion() == AUDIO_TYPE_QUESTION)

                                                          ///
                                                          /// Audio type question.
                                                          _audioTypeQuestion(controller, index)
                                                        else if (!IZIValidate.nullOrEmpty(controller.quizResponsesList[index].textQuestion))

                                                          ///
                                                          /// Text type question.
                                                          Html(
                                                            data: controller.quizResponsesList[index].textQuestion,
                                                            shrinkWrap: true,
                                                          )
                                                        else
                                                          Center(
                                                            child: IZILoading().spinKitLoadImage,
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            /// Selected Quiz.
                                            Obx(() {
                                              if (controller.generateTypeAnswer() == IMAGE_TYPE_QUESTION) {
                                                ///
                                                /// Grid view type answer.
                                                return _gridViewTypeAnswer(controller, index);
                                              }

                                              /// List View type answer.
                                              return _listViewTypeAnswer(controller, index);
                                            }),

                                            /// Button
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: IZIDimensions.SPACE_SIZE_3X,
                                                horizontal: IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                                              ),
                                              child:

                                                  /// Button skip and next.
                                                  _buttonSkipAndNext(controller),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ///
  /// Linear time count dow.
  ///
  Container _linearTimeCountDow(QuizzController controller) {
    return Container(
      width: double.infinity,
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        children: [
          // LayoutBuilder provide us the available space for the conatiner
          // constraints.maxWidth needed for our animation
          LayoutBuilder(
            builder: (context, constraints) => Container(
              // from 0 to 1 it takes 60s
              width: constraints.maxWidth * double.parse(controller.animation.value.toString()),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                ),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: IZIDimensions.SPACE_SIZE_2X),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("${(controller.animation.value * 60).round()} min"),
                  SvgPicture.asset(ImagesPath.clock_quiz),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Video type question.
  ///
  Column _videoTypeQuestion(QuizzController controller) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.onChangeIsShowOptionalVideo();
          },
          child: SizedBox(
            width: IZIDimensions.iziSize.width,
            child: controller.videoPlayerController != null && controller.videoPlayerController!.value.isInitialized
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(IZIDimensions.BORDER_RADIUS_3X),
                        child: AspectRatio(
                          aspectRatio: controller.videoPlayerController!.value.aspectRatio,
                          child: VideoPlayer(
                            controller.videoPlayerController!,
                          ),
                          // child: ,
                        ),
                      ),
                      Obx(() {
                        if (controller.isShowOptionalVideo.value) {
                          return Positioned(
                            top: 0,
                            right: 0,
                            left: 0,
                            bottom: 0,
                            child: AspectRatio(
                              aspectRatio: controller.videoPlayerController!.value.aspectRatio,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    controller.onChangePlayOrPauseVideo();
                                  },
                                  icon: Obx(
                                    () => Icon(
                                      controller.isPlayingVideo.value ? Icons.pause : Icons.play_arrow,
                                      color: ColorResources.WHITE,
                                      size: IZIDimensions.ONE_UNIT_SIZE * 80,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                      Obx(() {
                        if (controller.isShowOptionalVideo.value) {
                          return Positioned(
                            child: SizedBox(
                              width: IZIDimensions.iziSize.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${IZIDate.formatTimeFromDuration(controller.positionVideo)} / ${IZIDate.formatTimeFromDuration(controller.durationVideo)}',
                                    style: const TextStyle(
                                      color: ColorResources.WHITE,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      controller.onChangeVolumeVideo();
                                    },
                                    icon: Obx(
                                      () => Icon(
                                        controller.isMuteVolumeVideo.value ? Icons.volume_off : Icons.volume_up,
                                        color: ColorResources.WHITE,
                                        size: IZIDimensions.ONE_UNIT_SIZE * 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      }),
                      Obx(
                        () {
                          if (controller.isShowOptionalVideo.value) {
                            return Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: SizedBox(
                                height: IZIDimensions.ONE_UNIT_SIZE * 17,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(IZIDimensions.BORDER_RADIUS_3X),
                                    bottomRight: Radius.circular(IZIDimensions.BORDER_RADIUS_3X),
                                  ),
                                  child: VideoProgressIndicator(
                                    controller.videoPlayerController!,
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                      backgroundColor: ColorResources.GREY,
                                      playedColor: ColorResources.BOTTOM_BAR_DASHBOAD,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  )
                : Center(
                    child: IZILoading().spinKitLoadImage,
                  ),
          ),
        ),
      ],
    );
  }

  ///
  /// Audio type question.
  ///
  Column _audioTypeQuestion(QuizzController controller, int index) {
    return Column(
      children: [
        Slider(
          max: controller.duration.inSeconds.toDouble(),
          value: controller.position.inSeconds.toDouble(),
          onChanged: (val) async {
            controller.onChangePositionDurationAudio(val);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              IZIDate.formatTimeFromDuration(controller.position),
            ),
            Text(
              IZIDate.formatTimeFromDuration(controller.duration - controller.position),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                controller.seekRewind();
              },
              icon: Icon(
                Icons.fast_rewind,
                color: ColorResources.PRIMARY_BLUE_APP,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.playAudioQuestion(urlAudio: controller.quizResponsesList[index].audioQuestion.toString());
              },
              child: Container(
                padding: EdgeInsets.all(
                  IZIDimensions.SPACE_SIZE_1X,
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.SPACE_SIZE_2X,
                ),
                decoration: BoxDecoration(
                  color: ColorResources.WHITE,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: ColorResources.PRIMARY_BLUE_APP,
                    width: IZIDimensions.ONE_UNIT_SIZE * 3,
                  ),
                ),
                child: Obx(
                  () => Center(
                    child: Icon(
                      controller.isPlaying.value ? Icons.pause : Icons.play_arrow,
                      color: ColorResources.PRIMARY_BLUE_APP,
                      size: IZIDimensions.ONE_UNIT_SIZE * 50,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                controller.seekForward();
              },
              icon: Icon(
                Icons.fast_forward,
                color: ColorResources.PRIMARY_BLUE_APP,
                size: IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
            ),
          ],
        )
      ],
    );
  }

  ///
  /// Grid view type answer.
  ///
  Container _gridViewTypeAnswer(QuizzController controller, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(
        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
        IZIDimensions.PADDING_HORIZONTAL_SCREEN,
        0,
      ),
      width: IZIDimensions.iziSize.width,
      height: IZIDimensions.iziSize.width * 1.17,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.quizResponsesList[index].answers!.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: IZIDimensions.SPACE_SIZE_2X,
          mainAxisSpacing: IZIDimensions.SPACE_SIZE_2X,
          childAspectRatio: .8,
        ),
        itemBuilder: (context, indexAnswer) {
          return GestureDetector(
            onTap: () {
              controller.onChangeCurrentIndexSelected(indexAnswer);
            },
            child: Stack(
              children: [
                Obx(() => Container(
                      decoration: BoxDecoration(
                        color: controller.currentIndexSelected.value == indexAnswer ? ColorResources.CALL_VIDEO : ColorResources.WHITE,
                        borderRadius: BorderRadius.circular(
                          IZIDimensions.BORDER_RADIUS_4X,
                        ),
                      ),
                      child: Column(
                        children: [
                          if (controller.quizResponsesList[index].answers![indexAnswer].typeAnswers == IMAGE_TYPE_ANSWER)
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    IZIDimensions.BORDER_RADIUS_4X,
                                  ),
                                  topLeft: Radius.circular(
                                    IZIDimensions.BORDER_RADIUS_4X,
                                  )),
                              child: IZIImage(
                                controller.quizResponsesList[index].answers![indexAnswer].image.toString(),
                                width: IZIDimensions.iziSize.width / 2 - IZIDimensions.SPACE_SIZE_2X,
                                height: IZIDimensions.iziSize.width / 2 - IZIDimensions.SPACE_SIZE_2X,
                              ),
                            )
                          else
                            SizedBox(
                              width: IZIDimensions.iziSize.width / 2 - IZIDimensions.SPACE_SIZE_2X,
                              height: IZIDimensions.iziSize.width / 2 - IZIDimensions.SPACE_SIZE_2X,
                              child: Padding(
                                padding: EdgeInsets.all(IZIDimensions.SPACE_SIZE_2X),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.quizResponsesList[index].answers![indexAnswer].text.toString(),
                                      style: TextStyle(
                                        color: controller.currentIndexSelected.value == indexAnswer ? ColorResources.WHITE : ColorResources.BLACK,
                                        fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 7,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(top: IZIDimensions.SPACE_SIZE_1X),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.alphabetQuestion[indexAnswer].replaceAllMapped('. ', (match) => ''),
                                  style: TextStyle(
                                    color: controller.currentIndexSelected.value == indexAnswer ? ColorResources.WHITE : ColorResources.BLACK,
                                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                  right: IZIDimensions.ONE_UNIT_SIZE * 10,
                  top: IZIDimensions.ONE_UNIT_SIZE * 10,
                  child: Obx(() {
                    if (controller.currentIndexSelected.value == indexAnswer) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: ColorResources.CALL_VIDEO,
                          shape: BoxShape.circle,
                        ),
                        width: IZIDimensions.ONE_UNIT_SIZE * 40,
                        height: IZIDimensions.ONE_UNIT_SIZE * 40,
                        child: Center(
                          child: Icon(
                            Icons.done,
                            color: ColorResources.WHITE,
                            size: IZIDimensions.ONE_UNIT_SIZE * 30,
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  }),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  ///
  /// List View type answer.
  ///
  ListView _listViewTypeAnswer(QuizzController controller, int index) {
    return ListView.builder(
      itemCount: controller.quizResponsesList[index].answers!.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, indexAnswer) {
        return GestureDetector(
          onTap: () {
            controller.onChangeCurrentIndexSelected(indexAnswer);
          },
          child: Obx(
            () {
              return Container(
                margin: EdgeInsets.fromLTRB(
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  IZIDimensions.PADDING_HORIZONTAL_SCREEN,
                  0,
                ),
                width: IZIDimensions.iziSize.width,
                padding: EdgeInsets.symmetric(
                  vertical: IZIDimensions.SPACE_SIZE_4X,
                  horizontal: IZIDimensions.SPACE_SIZE_5X,
                ),
                decoration: BoxDecoration(
                  color: controller.currentIndexSelected.value == indexAnswer ? ColorResources.COLOR_SELECTED : ColorResources.WHITE,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: ColorResources.BLACK,
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                            fontWeight: FontWeight.w600,
                          ),
                          children: [
                            TextSpan(
                              text: controller.alphabetQuestion[indexAnswer],
                            ),
                            TextSpan(
                              text: controller.quizResponsesList[index].answers![indexAnswer].text,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Obx(
                      () {
                        if (controller.currentIndexSelected.value == indexAnswer) {
                          return Container(
                              decoration: const BoxDecoration(
                                color: ColorResources.CALL_VIDEO,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.done,
                                  color: ColorResources.WHITE,
                                  size: IZIDimensions.ONE_UNIT_SIZE * 30,
                                ),
                              ));
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  ///
  /// Button skip and next.
  ///
  Row _buttonSkipAndNext(QuizzController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(() => IZIButton(
              isEnabled: controller.generateSkipButton(),
              width: IZIDimensions.iziSize.width * .4,
              colorBG: ColorResources.RED,
              label: 'Bỏ qua',
              onTap: () {
                controller.goToSkipQuiz();
              },
            )),
        Obx(
          () => IZIButton(
            isEnabled: controller.generateNextButton(),
            colorBG: ColorResources.CALL_VIDEO,
            width: IZIDimensions.iziSize.width * .4,
            label: controller.generateValueStringButton(),
            onTap: () {
              controller.goToNextQuiz();
            },
          ),
        ),
      ],
    );
  }
}
