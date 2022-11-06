// ignore_for_file: use_setters_to_change_properties
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/history_quiz/history_quiz_request.dart';
import 'package:template/data/model/quiz/quiz_response.dart';
import 'package:template/provider/history_quiz_provider.dart';
import 'package:template/provider/quiz_provider.dart';
import 'package:video_player/video_player.dart';
import '../../../../base_widget/izi_dialog.dart';
import '../../../../data/model/history_quiz/history_quiz_response.dart';
import '../../../../di_container.dart';
import '../../../../helper/izi_dimensions.dart';
import '../../../../helper/izi_number.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../routes/route_path/account_routers.dart';
import '../../../../sharedpref/shared_preference_helper.dart';
import '../../../../utils/app_constants.dart';

class QuizzController extends GetxController with SingleGetTickerProviderMixin {
  ///
  /// Declare API.
  final QuizProvider quizProvider = GetIt.I.get<QuizProvider>();
  final HistoryQuizProvider historyQuizProvider = GetIt.I.get<HistoryQuizProvider>();
  RxList<QuizResponse> quizResponsesList = <QuizResponse>[].obs;
  Rx<HistoryQuizResponse> historyResponses = HistoryQuizResponse().obs;
  final AudioPlayer audioPlayer = AudioPlayer();
  VideoPlayerController? videoPlayerController;

  /// Declare Data.
  late AnimationController animationController;
  late Animation animation;
  bool isLoading = true;
  RxBool isPlaying = false.obs;
  RxBool isPlayingVideo = false.obs;
  RxBool isMuteVolumeVideo = false.obs;
  RxBool isShowOptionalVideo = false.obs;
  RxBool isJustOnceBack = false.obs;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  Duration durationVideo = Duration.zero;
  Duration positionVideo = Duration.zero;
  PageController pageController = PageController();
  RxInt currentIndexSelected = 10.obs;
  RxInt point = 0.obs;
  RxInt totalPoint = 0.obs;
  int currentIndexPageViewQuiz = 0;
  int timeOut = 0;
  String idCertificate = '';
  List<String> alphabetQuestion = ['A. ', 'B. ', 'C. ', 'D. ', 'E. ', 'F. ', 'G. ', 'H. ', 'I. ', 'K. '];
  RxString urlVideo = ''.obs;

  @override
  void onInit() {
    super.onInit();

    /// Get arguments from before screen.
    getArguments();
  }

  @override
  void dispose() {
    isJustOnceBack.close();
    quizResponsesList.close();
    historyResponses.close();
    isPlaying.close();
    isPlayingVideo.close();
    isMuteVolumeVideo.close();
    isShowOptionalVideo.close();
    currentIndexSelected.close();
    point.close();
    totalPoint.close();
    urlVideo.close();
    videoPlayerController!.dispose();
    audioPlayer.dispose();
    animationController.dispose();
    animation.removeListener(() {});
    pageController.dispose();
    super.dispose();
  }

  ///
  /// Get arguments from before screen.
  ///
  void getArguments() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idCertificate = Get.arguments.toString();
    }

    if (!IZIValidate.nullOrEmpty(Get.parameters['timeOut'])) {
      timeOut = IZINumber.parseInt(IZINumber.parseDouble(Get.parameters['timeOut'].toString()) / 60);
    }

    /// Call API get data history quiz.
    getDataHistoryQuiz();
  }

  ///
  /// Call API get data history quiz.
  ///
  void getDataHistoryQuiz() {
    historyQuizProvider.paginate(
      page: 1,
      limit: 1,
      filter: '&idUser=${sl<SharedPreferenceHelper>().getIdUser}&idCertificate=$idCertificate',
      onSuccess: (models) {
        if (models.isNotEmpty) {
          historyResponses.value = models.first;
        }

        /// Call API get data Quiz.
        getDataQuiz();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Call API get data Quiz.
  ///
  void getDataQuiz() {
    quizProvider.paginate(
      page: 1,
      limit: 100,
      filter: '&idCertificate=$idCertificate',
      onSuccess: (models) {
        print('models $models');
        quizResponsesList.value = models;

        /// Check if the first type question is video.
        if (quizResponsesList.isNotEmpty) {
          if (quizResponsesList.first.typeQuestion == VIDEO_TYPE_QUESTION) {
            urlVideo.value = quizResponsesList.first.videoQuestion.toString();
          }
        }

        totalPoint.value = quizResponsesList.length;

        /// Initialize animation controller.
        initializeAnimationCOntroller();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  /// Initialize animation controller.
  ///
  void initializeAnimationCOntroller() {
    ///
    /// Initialize count dow animation controller .
    animationController = AnimationController(duration: Duration(minutes: timeOut), vsync: this);

    /// Listen value animation count dow controller.
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        print(animation.value);
        update();
      });

    /// Start animation controller.
    animationController.forward().whenComplete(() => examTimeOut());

    /// Listen to state audio play.
    audioPlayer.onPlayerStateChanged.listen((event) {
      isPlaying.value = event == PlayerState.playing;
      update();
    });

    /// Listen to audio duration.
    audioPlayer.onDurationChanged.listen((event) {
      duration = event;
      update();
    });

    /// Listen to audio duration.
    audioPlayer.onPositionChanged.listen((event) {
      position = event;
      if (position >= duration) {
        isPlaying.value = false;
      }
      update();
    });

    /// Initialize video controller.
    videoPlayerController = VideoPlayerController.network(urlVideo.value)
      ..setLooping(true)
      ..initialize().then((value) => videoPlayerController!.play())
      ..addListener(() {
        ///
        /// Listen status is playing video.
        isPlayingVideo.value = videoPlayerController!.value.isPlaying;

        /// Listen status volume video.
        isMuteVolumeVideo.value = videoPlayerController!.value.volume == 0;

        /// Listen position duration video.
        positionVideo = videoPlayerController!.value.position;

        /// Listen duration video.
        durationVideo = videoPlayerController!.value.duration;

        update();
      });

    /// Just [update] first load [Quiz page].
    if (isLoading) {
      isLoading = false;
      update();
    }
  }

  ///
  /// Show exit confirmation dialog.
  ///
  void showExitConfirmationDialog() {
    IZIDialog.showDialog(
      lable: "Thoát bài thi",
      confirmLabel: "dong_y".tr,
      cancelLabel: "quay_lai".tr,
      description: "Bài thi sẽ bị tính là 0 điểm nếu như bạn thoát!",
      onCancel: () {
        Get.back();
      },
      onConfirm: () {
        EasyLoading.show(status: "please_waiting".tr);
        Get.back();
        if (!isJustOnceBack.value) {
          isJustOnceBack.value = true;
          if (!IZIValidate.nullOrEmpty(historyResponses.value.id)) {
            final HistoryQuizRequest historyQuizRequest = HistoryQuizRequest();
            historyQuizRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser.toString();
            historyQuizRequest.idCertificateRequest = idCertificate;
            historyQuizRequest.point = 0;
            historyQuizRequest.totalPoint = totalPoint.value;
            historyQuizRequest.percent = 0;
            historyQuizRequest.numberTest = historyResponses.value.numberTest! + 1;
            historyQuizProvider.update(
              id: historyResponses.value.id.toString(),
              data: historyQuizRequest,
              onSuccess: (model) {
                ///
                /// Get back to before screen.
                getBack(value: model);
              },
              onError: (error) {
                print(error);
              },
            );
          } else {
            final HistoryQuizRequest historyQuizRequest = HistoryQuizRequest();
            historyQuizRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser.toString();
            historyQuizRequest.idCertificateRequest = idCertificate;
            historyQuizRequest.point = 0;
            historyQuizRequest.totalPoint = totalPoint.value;
            historyQuizRequest.percent = 0;
            historyQuizRequest.numberTest = 1;
            historyQuizProvider.add(
              data: historyQuizRequest,
              onSuccess: (model) {
                ///
                /// Get back to before screen.
                getBack(value: model);
              },
              onError: (error) {
                print(error);
              },
            );
          }
        }
      },
    );
  }

  ///
  /// Get back to before screen.
  ///
  void getBack({required HistoryQuizResponse value}) {
    videoPlayerController!.dispose();
    audioPlayer.dispose();
    animationController.dispose();
    animation.removeListener(() {});
    isJustOnceBack.value = false;
    EasyLoading.dismiss();
    Get.back(result: value);
  }

  ///
  /// Generate type question.
  ///
  String generateTypeQuestion() {
    if (currentIndexPageViewQuiz < quizResponsesList.length) {
      ///
      /// If type question is image.
      if (quizResponsesList[currentIndexPageViewQuiz].typeQuestion == IMAGE_TYPE_QUESTION) {
        return IMAGE_TYPE_QUESTION;
      }

      /// If type question is audio.
      if (quizResponsesList[currentIndexPageViewQuiz].typeQuestion == AUDIO_TYPE_QUESTION) {
        return AUDIO_TYPE_QUESTION;
      }

      /// If type question is video.
      if (quizResponsesList[currentIndexPageViewQuiz].typeQuestion == VIDEO_TYPE_QUESTION) {
        return VIDEO_TYPE_QUESTION;
      }
    }

    return TEXT_TYPE_QUESTION;
  }

  ///
  /// Generate type answers.
  ///
  /// Case 1: 1 image sentence and 3 image sentences or 4 text sentences.
  /// Case 2: 2 text sentences adn 2 image sentences or 1 text sentence and 3 image sentences or 4 image sentences.
  String generateTypeAnswer() {
    int countImageSentences = 0;
    for (final e in quizResponsesList[currentIndexPageViewQuiz].answers!) {
      if (e.typeAnswers == IMAGE_TYPE_ANSWER) {
        countImageSentences++;
      }
    }
    if (countImageSentences >= 2) {
      return IMAGE_TYPE_ANSWER;
    }

    return TEXT_TYPE_ANSWER;
  }

  ///
  /// On change currentIndexSelected when selected answer.
  ///
  void onChangeCurrentIndexSelected(int val) {
    currentIndexSelected.value = val;
  }

  ///
  /// Generate enable next button.
  ///
  bool generateNextButton() {
    if (currentIndexPageViewQuiz < quizResponsesList.length) {
      if (currentIndexSelected.value > quizResponsesList[currentIndexPageViewQuiz].answers!.length) {
        return false;
      }
    }
    return true;
  }

  ///
  /// Generate enable skip button.
  ///
  bool generateSkipButton() {
    if (currentIndexPageViewQuiz >= quizResponsesList.length - 1) {
      return false;
    }
    return true;
  }

  ///
  /// Generate value string button.
  ///
  String generateValueStringButton() {
    if (currentIndexPageViewQuiz >= quizResponsesList.length - 1) {
      return 'Hoàn thành';
    }
    return 'Tiếp tục';
  }

  ///
  /// Play Audio question.
  ///
  Future<void> playAudioQuestion({required String urlAudio}) async {
    if (isPlaying.value) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource(urlAudio));
    }
  }

  ///
  /// Seek fast forward.
  ///
  Future<void> seekForward() async {
    final Duration seekPosition = Duration(seconds: position.inSeconds.toInt() + 10);
    await audioPlayer.seek(seekPosition);

    /// Optional: Play audio if was paused.
    await audioPlayer.resume();
  }

  ///
  /// On change play or pause video.
  ///
  void onChangePlayOrPauseVideo() {
    if (isPlayingVideo.value) {
      videoPlayerController!.pause();
    } else {
      videoPlayerController!.play();
    }
  }

  ///
  /// On change volume video.
  ///
  void onChangeVolumeVideo() {
    videoPlayerController!.setVolume(isMuteVolumeVideo.value ? 1 : 0);
  }

  ///
  /// Seek fast forward.
  ///
  Future<void> seekRewind() async {
    final Duration seekPosition = Duration(seconds: position.inSeconds.toInt() - 10);

    /// If duration >= then seek rewind else seek rewind to position 0.
    if (seekPosition.inSeconds.toInt() >= 0) {
      await audioPlayer.seek(seekPosition);
    } else {
      const Duration startPosition = Duration();
      await audioPlayer.seek(startPosition);
    }

    /// Optional: Play audio if was paused.
    await audioPlayer.resume();
  }

  ///
  /// On change value audio.
  ///
  Future<void> onChangePositionDurationAudio(double val) async {
    final position = Duration(seconds: val.toInt());
    await audioPlayer.seek(position);

    /// Optional: Play audio if was paused.
    await audioPlayer.resume();
  }

  ///
  /// On change is show optional video.
  ///
  void onChangeIsShowOptionalVideo() {
    isShowOptionalVideo.value = !isShowOptionalVideo.value;
  }

  ///
  /// Exam time out.
  ///
  void examTimeOut() {
    /// Close video player, animation and audio player controller.
    videoPlayerController!.dispose();
    audioPlayer.dispose();
    animationController.dispose();
    animation.removeListener(() {});

    /// Add or update history quiz.
    EasyLoading.show(status: "please_waiting".tr);
    if (!isJustOnceBack.value) {
      isJustOnceBack.value = true;
      if (!IZIValidate.nullOrEmpty(historyResponses.value.id)) {
        final HistoryQuizRequest historyQuizRequest = HistoryQuizRequest();
        historyQuizRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser.toString();
        historyQuizRequest.idCertificateRequest = idCertificate;
        historyQuizRequest.point = point.value;
        historyQuizRequest.totalPoint = totalPoint.value;
        historyQuizRequest.percent = (point.value / totalPoint.value) * 100;
        historyQuizRequest.numberTest = historyResponses.value.numberTest! + 1;
        historyQuizProvider.update(
          id: historyResponses.value.id.toString(),
          data: historyQuizRequest,
          onSuccess: (model) {
            EasyLoading.dismiss();

            /// Go to [Exam result page].
            Get.toNamed(AccountRouter.EXAM_RESULT, arguments: model)!.then((value) {
              Get.back(result: model);
            });
          },
          onError: (error) {
            print(error);
          },
        );
      } else {
        final HistoryQuizRequest historyQuizRequest = HistoryQuizRequest();
        historyQuizRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser.toString();
        historyQuizRequest.idCertificateRequest = idCertificate;
        historyQuizRequest.point = point.value;
        historyQuizRequest.totalPoint = totalPoint.value;
        historyQuizRequest.percent = (point.value / totalPoint.value) * 100;
        historyQuizRequest.numberTest = 1;
        historyQuizProvider.add(
          data: historyQuizRequest,
          onSuccess: (model) {
            EasyLoading.dismiss();

            /// Go to [Exam result page].
            Get.toNamed(AccountRouter.EXAM_RESULT, arguments: model)!.then((value) {
              Get.back(result: model);
            });
          },
          onError: (error) {
            print(error);
          },
        );
      }
    }
  }

  ///
  /// Button next quiz.
  ///
  Future<void> goToNextQuiz() async {
    ///
    /// If last question then go to [Success page] else go to next question.
    if (currentIndexPageViewQuiz >= quizResponsesList.length - 1) {
      /// Check the answer is right or wrong.
      if (quizResponsesList[currentIndexPageViewQuiz].answers![currentIndexSelected.value].isTrue!) {
        point.value++;
      }

      /// Close video player, animation and audio player controller.
      videoPlayerController!.dispose();
      audioPlayer.dispose();
      animationController.dispose();
      animation.removeListener(() {});

      /// Add or update history quiz.
      EasyLoading.show(status: "please_waiting".tr);
      if (!isJustOnceBack.value) {
        isJustOnceBack.value = true;
        if (!IZIValidate.nullOrEmpty(historyResponses.value.id)) {
          final HistoryQuizRequest historyQuizRequest = HistoryQuizRequest();
          historyQuizRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser.toString();
          historyQuizRequest.idCertificateRequest = idCertificate;
          historyQuizRequest.point = point.value;
          historyQuizRequest.totalPoint = totalPoint.value;
          historyQuizRequest.percent = (point.value / totalPoint.value) * 100;
          historyQuizRequest.numberTest = historyResponses.value.numberTest! + 1;
          historyQuizProvider.update(
            id: historyResponses.value.id.toString(),
            data: historyQuizRequest,
            onSuccess: (model) {
              EasyLoading.dismiss();

              /// Go to [Exam result page].
              Get.toNamed(AccountRouter.EXAM_RESULT, arguments: model)!.then((value) {
                Get.back(result: model);
              });
            },
            onError: (error) {
              print(error);
            },
          );
        } else {
          final HistoryQuizRequest historyQuizRequest = HistoryQuizRequest();
          historyQuizRequest.idUserRequest = sl<SharedPreferenceHelper>().getIdUser.toString();
          historyQuizRequest.idCertificateRequest = idCertificate;
          historyQuizRequest.point = point.value;
          historyQuizRequest.totalPoint = totalPoint.value;
          historyQuizRequest.percent = (point.value / totalPoint.value) * 100;
          historyQuizRequest.numberTest = 1;
          historyQuizProvider.add(
            data: historyQuizRequest,
            onSuccess: (model) {
              EasyLoading.dismiss();

              /// Go to [Exam result page].
              Get.toNamed(AccountRouter.EXAM_RESULT, arguments: model)!.then((value) {
                Get.back(result: model);
              });
            },
            onError: (error) {
              print(error);
            },
          );
        }
      }
    } else {
      /// Check the answer is right or wrong.
      if (quizResponsesList[currentIndexPageViewQuiz].answers![currentIndexSelected.value].isTrue!) {
        point.value++;
      }

      /// Reset value currentIndexSelected = 10.
      currentIndexSelected.value = 10;

      /// Increase currentIndexPageViewQuiz 1 unit.
      currentIndexPageViewQuiz++;

      /// Close video player and audio player controller before page.
      await audioPlayer.stop();
      videoPlayerController!.dispose();

      /// Reset duration and position.
      duration = Duration.zero;
      position = Duration.zero;

      /// Go to next question.
      final double positionAvatar = currentIndexPageViewQuiz * IZIDimensions.iziSize.width;
      pageController.animateTo(positionAvatar, duration: const Duration(milliseconds: 500), curve: Curves.ease);

      /// Check if next question have type question is video then initialize video player controller.
      if (quizResponsesList[currentIndexPageViewQuiz].typeQuestion == VIDEO_TYPE_QUESTION) {
        /// Set url video.
        urlVideo.value = quizResponsesList[currentIndexPageViewQuiz].videoQuestion.toString();

        /// Reset option defaults.
        isPlayingVideo.value = false;
        isMuteVolumeVideo.value = false;
        isShowOptionalVideo.value = false;
        durationVideo = Duration.zero;
        positionVideo = Duration.zero;

        /// Initialize video controller.
        videoPlayerController = VideoPlayerController.network(urlVideo.value)
          ..setLooping(true)
          ..initialize().then((value) => videoPlayerController!.play()).then((value) => videoPlayerController!.setVolume(1))
          ..addListener(() {
            ///
            /// Listen status is playing video.
            isPlayingVideo.value = videoPlayerController!.value.isPlaying;

            /// Listen status volume video.
            isMuteVolumeVideo.value = videoPlayerController!.value.volume == 0;

            /// Listen position duration video.
            positionVideo = videoPlayerController!.value.position;

            /// Listen duration video.
            durationVideo = videoPlayerController!.value.duration;

            update();
          });
        update();
      }
    }
  }

  ///
  /// Button skip quiz.
  ///
  Future<void> goToSkipQuiz() async {
    currentIndexPageViewQuiz++;
    currentIndexSelected.value = 10;

    /// Close video player and audio player controller before page.
    videoPlayerController!.dispose();
    await audioPlayer.stop();
    final double positionAvatar = currentIndexPageViewQuiz * IZIDimensions.iziSize.width;
    pageController.animateTo(positionAvatar, duration: const Duration(milliseconds: 500), curve: Curves.ease);

    /// Check if next question have type question is video then initialize video player controller.
    if (quizResponsesList[currentIndexPageViewQuiz].typeQuestion == VIDEO_TYPE_QUESTION) {
      /// Set url video.
      urlVideo.value = quizResponsesList[currentIndexPageViewQuiz].videoQuestion.toString();

      /// Reset option defaults.
      isPlayingVideo.value = false;
      isMuteVolumeVideo.value = false;
      isShowOptionalVideo.value = false;
      durationVideo = Duration.zero;
      positionVideo = Duration.zero;

      /// Initialize video controller.
      videoPlayerController = VideoPlayerController.network(urlVideo.value)
        ..setLooping(true)
        ..initialize().then((value) => videoPlayerController!.play()).then((value) => videoPlayerController!.setVolume(1))
        ..addListener(() {
          ///
          /// Listen status is playing video.
          isPlayingVideo.value = videoPlayerController!.value.isPlaying;

          /// Listen status volume video.
          isMuteVolumeVideo.value = videoPlayerController!.value.volume == 0;

          /// Listen position duration video.
          positionVideo = videoPlayerController!.value.position;

          /// Listen duration video.
          durationVideo = videoPlayerController!.value.duration;

          update();
        });
      update();
    }
  }
}
