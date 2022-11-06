import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:glass/glass.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/base_widget/izi_loading.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/utils/color_resources.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/room_video_call/room_video_call_controller.dart';
import '../../../helper/izi_validate.dart';
import 'dart:math' as math;

class RoomVideoCallPage extends GetView {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: GetBuilder(
        init: RoomVideoCallController(),
        builder: (RoomVideoCallController controller) {
          if (controller.isLoading) {
            return Center(
              child: IZILoading().isLoadingKit,
            );
          }

          return Scaffold(
              body: Obx(
            () => controller.genValueStatusScreen() == 1 || controller.genValueStatusScreen() == 2 ? _callingView(controller) : _videoView(controller),
          ));
        },
      ),
    );
  }

  ///
  /// Calling view.
  ///
  Widget _callingView(RoomVideoCallController controller) {
    return AnimatedBuilder(
      animation: controller.animationController!,
      builder: (context, child) {
        return Container(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          color: controller.background.evaluate(AlwaysStoppedAnimation(controller.animationController!.value)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SafeArea(
                    child: Container(
                      width: IZIDimensions.iziSize.width,
                      margin: EdgeInsets.fromLTRB(
                        IZIDimensions.SPACE_SIZE_5X,
                        IZIDimensions.ONE_UNIT_SIZE * 40,
                        0,
                        0,
                      ),
                      child: Stack(
                        children: [
                          //HAQUA
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "HAQUA",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: IZIDimensions.FONT_SIZE_H5,
                                  color: ColorResources.WHITE,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  //Avatar User
                  Stack(
                    children: [
                      AvatarGlow(
                        duration: const Duration(milliseconds: 1500),
                        endRadius: IZIDimensions.iziSize.width * .5,
                        repeatPauseDuration: const Duration(milliseconds: 50),
                        child: ClipOval(
                          child: Container(
                            width: IZIDimensions.iziSize.width * .33,
                            height: IZIDimensions.iziSize.width * .33,
                            color: ColorResources.WHITE,
                            child: Center(
                                child: ClipOval(
                              child: IZIImage(
                                !IZIValidate.nullOrEmpty(controller.userResponse!.avatar) ? controller.userResponse!.avatar.toString() : ImagesPath.splash_haqua,
                                width: IZIDimensions.iziSize.width * .32,
                                height: IZIDimensions.iziSize.width * .32,
                              ),
                            )),
                          ),
                        ),
                      ),

                      //Name User
                      Positioned(
                        bottom: IZIDimensions.ONE_UNIT_SIZE * 90,
                        left: 0,
                        right: 0,
                        child: SizedBox(
                          width: IZIDimensions.iziSize.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  bottom: IZIDimensions.SPACE_SIZE_1X,
                                ),
                                child: Text(
                                  controller.userResponse!.fullName.toString(),
                                  style: TextStyle(
                                    color: ColorResources.WHITE,
                                    fontWeight: FontWeight.w600,
                                    fontSize: IZIDimensions.FONT_SIZE_H4,
                                  ),
                                ),
                              ),
                              DefaultTextStyle(
                                style: TextStyle(
                                  fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                                  color: ColorResources.WHITE,
                                  fontWeight: FontWeight.w600,
                                ),
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText(
                                      controller.genValueStatusCalling(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                  repeatForever: true,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              //Button Call
              Obx(
                () => Container(
                  margin: EdgeInsets.only(
                    bottom: IZIDimensions.ONE_UNIT_SIZE * 100,
                  ),
                  child: controller.statusCalling.value == 1
                      ? _buttonCall(controller)
                      : controller.statusCalling.value == 2
                          ? _buttonCalled(controller)
                          : const SizedBox(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  ///
  /// Video view.
  ///
  Widget _videoView(RoomVideoCallController controller) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return SizedBox(
          width: IZIDimensions.iziSize.width,
          height: IZIDimensions.iziSize.height,
          child: Stack(
            children: [
              SizedBox(
                width: IZIDimensions.iziSize.width,
                height: IZIDimensions.iziSize.height,
                child: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      /// Remote video.
                      Container(
                        margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        width: IZIDimensions.iziSize.width,
                        height: IZIDimensions.iziSize.height,
                        decoration: const BoxDecoration(color: Colors.black54),
                        child: RTCVideoView(
                          controller.remoteRenderer,
                          objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                          filterQuality: FilterQuality.medium,
                          mirror: true,
                        ),
                      ),

                      /// Local video.
                      Positioned(
                        right: IZIDimensions.SPACE_SIZE_2X,
                        top: IZIDimensions.ONE_UNIT_SIZE * 80,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            IZIDimensions.BORDER_RADIUS_4X,
                          ),
                          child: SizedBox(
                            width: orientation == Orientation.portrait ? 110.0 : 140.0,
                            height: orientation == Orientation.portrait ? 140.0 : 110.0,
                            child: RTCVideoView(
                              controller.localRenderer,
                              mirror: true,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ),
                      ),

                      /// Count dow time.
                      Positioned(
                        left: 0,
                        right: 0,
                        top: IZIDimensions.ONE_UNIT_SIZE * 5,
                        child: _countDowTime(controller),
                      ),

                      /// Button top call video.
                      Positioned(
                        left: 0,
                        right: 0,
                        top: IZIDimensions.ONE_UNIT_SIZE * 5,
                        child: _buttonTopCallVideo(controller),
                      ),
                    ],
                  ),
                ),
              ),

              /// Drawing screen.
              Obx(() {
                return Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return ScaleTransition(scale: animation, child: child);
                    },
                    child: controller.drawingScreen.value,
                  ),
                );
              }),

              /// Button call video.
              Obx(() {
                if (!controller.isOpenDrawingScreen.value) {
                  return Positioned(
                    left: 0,
                    right: 0,
                    bottom: IZIDimensions.SPACE_SIZE_2X,
                    child: _buttonCallVideo(controller),
                  );
                }
                return const SizedBox();
              }),

              /// Drawing screen button.
              Obx(() {
                if (controller.isOpenDrawingScreen.value) {
                  return Positioned(
                    left: IZIDimensions.SPACE_SIZE_2X,
                    top: IZIDimensions.ONE_UNIT_SIZE * 110,
                    child: _drawingScreen(controller),
                  );
                }
                return const SizedBox();
              }),

              /// Drawing screen button.
              Obx(() {
                if (controller.isOpenDrawingScreen.value) {
                  return Positioned(
                    left: 0,
                    top: IZIDimensions.ONE_UNIT_SIZE * 110,
                    child: _drawingHangUpScreen(controller),
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
        );
      },
    );
  }

  ///
  /// Count dow time.
  ///
  Widget _countDowTime(RoomVideoCallController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: IZIDimensions.iziSize.width * .19,
            padding: EdgeInsets.symmetric(
              vertical: IZIDimensions.SPACE_SIZE_2X,
            ),
            decoration: BoxDecoration(
              //Trạng thái
              borderRadius: BorderRadius.circular(
                IZIDimensions.ONE_UNIT_SIZE * 50,
              ),
            ),
            child: Center(child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.fiber_manual_record_rounded,
                    color: ColorResources.RED,
                    size: IZIDimensions.ONE_UNIT_SIZE * 20,
                  ),
                  Text(
                    Duration(minutes: controller.callTimerCountDowValue.value).toString().substring(0, 5),
                    style: TextStyle(
                      color: ColorResources.WHITE,
                      fontSize: IZIDimensions.FONT_SIZE_SPAN,
                    ),
                  ),
                ],
              );
            })),
          ).asGlass(
            clipBorderRadius: BorderRadius.circular(
              IZIDimensions.ONE_UNIT_SIZE * 50,
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Button top call video.
  ///
  Widget _buttonTopCallVideo(RoomVideoCallController controller) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: IZIDimensions.SPACE_SIZE_2X,
      ),
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.showDialogReport();
            },
            child: Row(
              children: [
                Text(
                  "denounce".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: ColorResources.RED,
                    fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                    decoration: TextDecoration.underline,
                  ),
                ),
                IZIImage(
                  ImagesPath.call_video_report,
                  width: IZIDimensions.ONE_UNIT_SIZE * 30,
                  height: IZIDimensions.ONE_UNIT_SIZE * 30,
                  color: ColorResources.RED,
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     controller.changeTypeVolume();
          //   },
          //   child: Container(
          //     width: IZIDimensions.ONE_UNIT_SIZE * 60,
          //     height: IZIDimensions.ONE_UNIT_SIZE * 60,
          //     decoration: BoxDecoration(
          //       color: ColorResources.BLACK.withOpacity(.4),
          //       shape: BoxShape.circle,
          //     ),
          //     child: Center(
          //       child: IZIImage(
          //         controller.isSpeakerPhone == false ? ImagesPath.call_video_volume_off : ImagesPath.call_video_volume_on,
          //         color: ColorResources.WHITE,
          //         width: IZIDimensions.ONE_UNIT_SIZE * 40,
          //         height: IZIDimensions.ONE_UNIT_SIZE * 40,
          //       ),
          //     ),
          //   ),
          // ),

          GestureDetector(
              onTap: () {
                controller.switchCamera();
              },
              child: Obx(
                () => Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 50,
                  height: IZIDimensions.ONE_UNIT_SIZE * 50,
                  decoration: BoxDecoration(
                    color: controller.isSwitchCamera.value == false ? ColorResources.BLACK.withOpacity(.4) : ColorResources.WHITE,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IZIImage(
                      ImagesPath.call_video_switch_camera,
                      color: controller.isSwitchCamera.value == false ? ColorResources.WHITE : ColorResources.BLACK,
                      width: IZIDimensions.ONE_UNIT_SIZE * 30,
                      height: IZIDimensions.ONE_UNIT_SIZE * 30,
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  ///
  /// Button call video.
  ///
  Widget _buttonCallVideo(RoomVideoCallController controller) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                controller.onChangedCamera();
              },
              child: Obx(
                () => Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 90,
                  height: IZIDimensions.ONE_UNIT_SIZE * 90,
                  decoration: BoxDecoration(
                    color: controller.isEnableCamera.value == false ? ColorResources.BLACK.withOpacity(.4) : ColorResources.WHITE,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IZIImage(
                      controller.isEnableCamera.value == false ? ImagesPath.call_video_video_open : ImagesPath.call_video_video_off,
                      color: controller.isEnableCamera.value == false ? ColorResources.WHITE : ColorResources.BLACK,
                      width: IZIDimensions.ONE_UNIT_SIZE * 40,
                      height: IZIDimensions.ONE_UNIT_SIZE * 40,
                    ),
                  ),
                ),
              )),
          GestureDetector(
              onTap: () {
                controller.muteMic();
              },
              child: Obx(
                () => Container(
                  width: IZIDimensions.ONE_UNIT_SIZE * 90,
                  height: IZIDimensions.ONE_UNIT_SIZE * 90,
                  decoration: BoxDecoration(
                    color: controller.isMuteMic.value == false ? ColorResources.BLACK.withOpacity(.4) : ColorResources.WHITE,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: IZIImage(
                      controller.isMuteMic.value == false ? ImagesPath.call_video_micro : ImagesPath.call_video_mute_micro,
                      color: controller.isMuteMic.value == false ? ColorResources.WHITE : ColorResources.BLACK,
                      width: IZIDimensions.ONE_UNIT_SIZE * 40,
                      height: IZIDimensions.ONE_UNIT_SIZE * 40,
                    ),
                  ),
                ),
              )),
          GestureDetector(
            onTap: () {
              controller.hangUp();
            },
            child: Container(
              width: IZIDimensions.ONE_UNIT_SIZE * 90,
              height: IZIDimensions.ONE_UNIT_SIZE * 90,
              decoration: BoxDecoration(
                color: ColorResources.RED,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
              ),
              child: Center(
                child: IZIImage(
                  ImagesPath.call_video_hang_up,
                  color: ColorResources.WHITE,
                  width: IZIDimensions.ONE_UNIT_SIZE * 40,
                  height: IZIDimensions.ONE_UNIT_SIZE * 40,
                ),
              ),
            ),
          ),
          Obx(() {
            return GestureDetector(
              onTap: () {
                controller.openDrawingScreen();
                // controller.onChangeShareScreen();
              },
              child: Container(
                width: IZIDimensions.ONE_UNIT_SIZE * 90,
                height: IZIDimensions.ONE_UNIT_SIZE * 90,
                decoration: BoxDecoration(
                  color: controller.isOpenDrawingScreen.value == false ? ColorResources.BLACK.withOpacity(.4) : ColorResources.WHITE,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: IZIImage(
                    ImagesPath.call_video_paint,
                    color: controller.isOpenDrawingScreen.value == false ? ColorResources.WHITE : ColorResources.BLACK,
                    width: IZIDimensions.ONE_UNIT_SIZE * 40,
                    height: IZIDimensions.ONE_UNIT_SIZE * 40,
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  ///
  /// Drawing screen.
  ///
  Widget _drawingScreen(RoomVideoCallController controller) {
    return GestureDetector(
      onTap: () {
        controller.openDrawingScreen();
      },
      child: Container(
        width: IZIDimensions.ONE_UNIT_SIZE * 60,
        height: IZIDimensions.ONE_UNIT_SIZE * 60,
        decoration: const BoxDecoration(
          color: ColorResources.RED,
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Icon(
            Icons.close,
            color: ColorResources.WHITE,
          ),
        ),
      ),
    );
  }

  ///
  /// Drawing hang up screen.
  ///
  Widget _drawingHangUpScreen(RoomVideoCallController controller) {
    return SizedBox(
      width: IZIDimensions.iziSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              controller.hangUp();
            },
            child: Container(
              width: IZIDimensions.ONE_UNIT_SIZE * 60,
              height: IZIDimensions.ONE_UNIT_SIZE * 60,
              decoration: BoxDecoration(
                color: ColorResources.RED,
                borderRadius: BorderRadius.circular(
                  IZIDimensions.BLUR_RADIUS_3X,
                ),
              ),
              child: Center(
                child: IZIImage(
                  ImagesPath.call_video_hang_up,
                  color: ColorResources.WHITE,
                  width: IZIDimensions.ONE_UNIT_SIZE * 35,
                  height: IZIDimensions.ONE_UNIT_SIZE * 35,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ///
  /// Button call.
  ///
  Row _buttonCall(RoomVideoCallController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     controller.changeTypeVolume();
        //   },
        //   child: ClipOval(
        //     child: Container(
        //       color: ColorResources.GREY.withOpacity(.5),
        //       width: IZIDimensions.ONE_UNIT_SIZE * 100,
        //       height: IZIDimensions.ONE_UNIT_SIZE * 100,
        //       child: Center(
        //         child: IZIImage(
        //           controller.isSpeakerPhone == false ? ImagesPath.call_video_volume_off : ImagesPath.call_video_volume_on,
        //           width: IZIDimensions.ONE_UNIT_SIZE * 55,
        //           height: IZIDimensions.ONE_UNIT_SIZE * 55,
        //           color: ColorResources.WHITE,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
        GestureDetector(
          onTap: () {
            controller.turnOffVideoCall();
          },
          child: ClipOval(
            child: Container(
              color: ColorResources.RED,
              width: IZIDimensions.ONE_UNIT_SIZE * 100,
              height: IZIDimensions.ONE_UNIT_SIZE * 100,
              child: Center(
                child: IZIImage(
                  ImagesPath.logo_call_screen,
                  width: IZIDimensions.ONE_UNIT_SIZE * 55,
                  height: IZIDimensions.ONE_UNIT_SIZE * 55,
                  color: ColorResources.WHITE,
                ),
              ),
            ),
          ),
        ),
        // GestureDetector(
        //   onTap: () {},
        //   child: ClipOval(
        //     child: Container(
        //       color: ColorResources.GREY.withOpacity(.5),
        //       width: IZIDimensions.ONE_UNIT_SIZE * 100,
        //       height: IZIDimensions.ONE_UNIT_SIZE * 100,
        //       child: Center(
        //         child: IZIImage(
        //           ImagesPath.microphone,
        //           width: IZIDimensions.ONE_UNIT_SIZE * 50,
        //           height: IZIDimensions.ONE_UNIT_SIZE * 50,
        //           color: ColorResources.WHITE,
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  ///
  /// Button Called.
  ///
  Row _buttonCalled(RoomVideoCallController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          margin: EdgeInsets.only(
            right: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: GestureDetector(
            onTap: () {
              controller.turnOffVideoCalled();
            },
            child: ClipOval(
              child: Container(
                color: ColorResources.RED,
                width: IZIDimensions.ONE_UNIT_SIZE * 100,
                height: IZIDimensions.ONE_UNIT_SIZE * 100,
                child: Center(
                  child: IZIImage(
                    ImagesPath.logo_call_screen,
                    width: IZIDimensions.ONE_UNIT_SIZE * 55,
                    height: IZIDimensions.ONE_UNIT_SIZE * 55,
                    color: ColorResources.WHITE,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: IZIDimensions.SPACE_SIZE_2X,
          ),
          child: GestureDetector(
            onTap: () async {
              controller.acceptVideoCaller();
            },
            child: AvatarGlow(
              duration: const Duration(milliseconds: 1500),
              endRadius: IZIDimensions.iziSize.width * .15,
              child: ClipOval(
                child: Container(
                  color: ColorResources.CALL_VIDEO,
                  width: IZIDimensions.ONE_UNIT_SIZE * 100,
                  height: IZIDimensions.ONE_UNIT_SIZE * 100,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: controller.animationCallIconController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: controller.animationCallIconController.value * (math.pi / 8),
                          child: IZIImage(
                            ImagesPath.logo_call_video_screen,
                            width: IZIDimensions.ONE_UNIT_SIZE * 50,
                            height: IZIDimensions.ONE_UNIT_SIZE * 50,
                            color: ColorResources.WHITE,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
