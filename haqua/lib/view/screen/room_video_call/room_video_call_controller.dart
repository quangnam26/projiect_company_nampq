import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_drawing_board/flutter_drawing_board.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_input.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/review_and_payment_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/color_resources.dart';
import '../../../data/datasource/remote/dio/izi_socket.dart';
import '../../../data/model/question/question_request.dart';
import '../../../data/model/user/user_response.dart';
import '../../../routes/route_path/call_screen_routers.dart';
import '../../../utils/flutter_webrtc/signaling.dart';
import 'component_drawing/triangle.dart';

class RoomVideoCallController extends GetxController with WidgetsBindingObserver, SingleGetTickerProviderMixin {
  //Khai bao API
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final IZISocket iziSocket = GetIt.I.get<IZISocket>();

  //Khai bao Data
  List<dynamic> peers = [];
  String? _selfId;
  String? idQuestionAsker;
  String? idRespondent;
  String? idQuestion;
  String? caller;
  String? idRoom;
  String? otherReportController;
  String? errorTextOtherReportController;
  int valueImageReport = 0;
  int valueLanguageReport = 1;
  int valueOtherReport = 2;
  int groupValueReport = 0;
  RxInt statusCalling = 0.obs;
  RxInt timeCountDow = 50.obs;
  RxInt callTimerCountDowValue = 1800.obs;
  Session? _session;
  Signaling? _signaling;
  final RTCVideoRenderer localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer remoteRenderer = RTCVideoRenderer();
  RxBool isSwitchCamera = false.obs;
  RxBool isMuteMic = false.obs;
  RxBool isOpenDrawingScreen = false.obs;
  RxBool isEnableCamera = false.obs;
  bool isLoading = true;
  bool isLoadingStatusCalling = false;
  UserResponse? userResponse;
  Rx<Widget> drawingScreen = SizedBox(
    width: IZIDimensions.ONE_UNIT_SIZE * 5,
    height: IZIDimensions.ONE_UNIT_SIZE * 5,
  ).obs;
  DrawingController? drawingController;
  AnimationController? animationController;
  late AnimationController animationCallIconController;
  Animatable<Color?> background = TweenSequence(
    [
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.blueAccent,
          end: Colors.greenAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.greenAccent,
          end: Colors.pinkAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.pinkAccent,
          end: Colors.orangeAccent,
        ),
      ),
      TweenSequenceItem(
        weight: 1.0,
        tween: ColorTween(
          begin: Colors.orangeAccent,
          end: Colors.blueAccent,
        ),
      ),
    ],
  );
  final assetsAudioPlayer = AssetsAudioPlayer();
  final oneSec = const Duration(seconds: 1);
  Timer? timerCountDow;
  Timer? callTimerCountDow;

  @override
  void onInit() {
    super.onInit();

    /// Initialize controller.
    initController();
  }

  @override
  void onClose() {
    statusCalling.close();
    timeCountDow.close();
    callTimerCountDowValue.close();
    isSwitchCamera.close();
    isMuteMic.close();
    isOpenDrawingScreen.close();
    isEnableCamera.close();
    drawingScreen.close();
    iziSocket.socket.off('end_call_socket');
    _signaling?.close();
    drawingController!.dispose();
    assetsAudioPlayer.dispose();
    animationController!.dispose();
    animationCallIconController.dispose();
    if (!IZIValidate.nullOrEmpty(timerCountDow)) {
      timerCountDow!.cancel();
    }
    if (!IZIValidate.nullOrEmpty(callTimerCountDow)) {
      callTimerCountDow!.cancel();
    }
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Start Socket
      startSocket();
    }
  }

  ///
  /// Initialize controller.
  ///
  void initController() {
    drawingController = DrawingController();
    animationController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    animationCallIconController = AnimationController(
      duration: const Duration(milliseconds: 160),
      vsync: this,
    )
      ..addListener(() {
        switch (animationCallIconController.status) {
          case AnimationStatus.completed:
            animationCallIconController.reverse();
            break;
          case AnimationStatus.dismissed:
            animationCallIconController.forward();
            break;
          default:
        }
      })
      ..forward();

    /// Start listen event socket.
    startSocket();
  }

  ///
  /// Start listen event socket.
  ///
  void startSocket() {
    /// List end call socket event from server.
    if (!iziSocket.socket.hasListeners('end_call_socket')) {
      iziSocket.socket.on('end_call_socket', (data) {
        if (!IZIValidate.nullOrEmpty(data)) {
          /// Listen socket and join video room after for respondent.
          listSocketAndJoinRoomVideoAfterForRespondent(dataSocket: data);

          /// Listen socket and reject video call from respondent.
          rejectCallVideoFromRespondent(dataSocket: data);
        }
      });
    }

    /// Get Argument from before screen.
    getArgument();
  }

  ///
  /// Listen socket and join video room after for respondent.
  ///
  Future<void> listSocketAndJoinRoomVideoAfterForRespondent({required dynamic dataSocket}) async {
    /// Listen socket to update video call screen from respondent.
    ///
    /// The caller is the asking the question.
    if (dataSocket['idRespondent'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == JOIN_ROOM_CALL_VIDEO && dataSocket['caller'].toString() == QUESTION_ASKER_CALL) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 0;
        await Future.delayed(const Duration(seconds: 1));
      }

      /// Call API change status question.
      questionProvider.changeStatusStartCall(
        id: dataSocket['idQuestion'].toString(),
        onSuccess: (models) {},
        onError: (error) {
          print(error);
        },
      );
    }

    ///  The caller is the answer the question.
    else if (dataSocket['idQuestionAsker'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == JOIN_ROOM_CALL_VIDEO && dataSocket['caller'].toString() == RESPONDENT_CALL) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 0;
        await Future.delayed(const Duration(seconds: 1));
      }

      /// Call API change status question.
      questionProvider.changeStatusStartCall(
        id: dataSocket['idQuestion'].toString(),
        onSuccess: (models) {},
        onError: (error) {
          print(error);
        },
      );
    }
  }

  ///
  /// Reject Call video from respondent.
  ///
  Future<void> rejectCallVideoFromRespondent({required dynamic dataSocket}) async {
    /// Reject the call where the caller is the answering the question
    if (dataSocket['idQuestionAsker'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == TURN_OFF_CALL && dataSocket['userEndedCall'].toString() == RESPONDENT_ENDED_CALL && dataSocket['caller'].toString() == RESPONDENT_CALL) {
      IZIToast().error(message: 'reject_call'.tr);
      await Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    }

    /// Reject the call where the caller is the asking the question.
    else if (dataSocket['idRespondent'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == TURN_OFF_CALL && dataSocket['userEndedCall'].toString() == QUESTION_ASKER_ENDED_CALL && dataSocket['caller'].toString() == QUESTION_ASKER_CALL) {
      IZIToast().error(message: 'caller_end'.tr);
      await Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    }

    /// Call timeout when the caller is the one answering the question
    if (dataSocket['idQuestionAsker'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == CALL_TIME_OUT && dataSocket['userEndedCall'].toString() == RESPONDENT_ENDED_CALL && dataSocket['caller'].toString() == RESPONDENT_CALL) {
      await Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    }

    /// Call timeout when the caller is the one asking the question
    else if (dataSocket['idRespondent'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == CALL_TIME_OUT && dataSocket['userEndedCall'].toString() == QUESTION_ASKER_ENDED_CALL && dataSocket['caller'].toString() == QUESTION_ASKER_CALL) {
      await Future.delayed(const Duration(seconds: 1), () {
        Get.back();
      });
    }
  }

  ///
  /// Get Argument form screen before.
  ///
  void getArgument() {
    if (!IZIValidate.nullOrEmpty(Get.arguments)) {
      idQuestionAsker = Get.arguments['idQuestionAsker'].toString();
      idRespondent = Get.arguments['idRespondent'].toString();
      idQuestion = Get.arguments['idQuestion'].toString();
      idRoom = Get.arguments['idRoom'].toString();
      caller = Get.arguments['caller'].toString();
    }

    /// Initialize video renderer
    initRenderers();
  }

  ///
  /// Initialize video renderer
  ///
  Future<void> initRenderers() async {
    await localRenderer.initialize();
    await remoteRenderer.initialize();

    /// Connect to server.
    await connect();
  }

  ///
  /// Connect to server.
  ///
  Future<void> connect() async {
    _signaling ??= Signaling(HOST_CALL_VIDEO)..connect();
    _signaling?.onSignalingStateChange = (SignalingState state) {
      switch (state) {
        case SignalingState.ConnectionClosed:
        case SignalingState.ConnectionError:
        case SignalingState.ConnectionOpen:
          break;
      }
    };

    _signaling?.onCallStateChange = (Session session, CallState state) async {
      switch (state) {
        case CallState.CallStateNew:

          /// Create new session.
          if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
            _session = session;
            update();
          }
          break;
        case CallState.CallStateRinging:

          /// Accept join room.
          _accept();

          break;
        case CallState.CallStateBye:

          /// Hang up call video.
          stateByeCallVideo();
          break;
        case CallState.CallStateInvite:
          break;
        case CallState.CallStateConnected:

          /// Start count dow time call video.
          callTimerCountDow = Timer.periodic(oneSec, (timer) {
            if (callTimerCountDowValue.value == 0) {
              IZIToast().successfully(message: 'call_ended'.tr, colorBG: ColorResources.CALL_VIDEO);
              if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
                Get.back();
              } else {
                final Map<String, dynamic> param = {
                  'idRoom': '',
                  'idQuestionAsker': idQuestionAsker,
                  'idRespondent': idRespondent,
                  'idQuestion': idQuestion,
                };
                Get.toNamed(ReviewAndPaymentRoutes.REVIEW_AND_PAYMENT, arguments: param)!.then((value) {
                  sl<SharedPreferenceHelper>().setCalling(isCalling: false);
                  Get.back();
                });
              }
              callTimerCountDow!.cancel();
            } else {
              callTimerCountDowValue.value--;
            }
          });
          assetsAudioPlayer.dispose();
          if (caller == QUESTION_ASKER_CALL) {
            if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
              timerCountDow!.cancel();
            }
          } else if (caller == RESPONDENT_CALL) {
            if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
              timerCountDow!.cancel();
            }
          }

          break;
      }
    };

    _signaling?.onPeersUpdate = (event) {
      /// Create self id.
      createSelfId(data: event);
    };

    /// On get local stream.
    _signaling?.onLocalStream = (stream) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        localRenderer.srcObject = stream;
        update();
      }
    };

    /// On get remote stream.
    _signaling?.onAddRemoteStream = (_, stream) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        remoteRenderer.srcObject = stream;
        update();
      }
    };

    /// On remove remote stream.
    _signaling?.onRemoveRemoteStream = (_, stream) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        remoteRenderer.srcObject = null;
        update();
      }
    };

    /// Call API get data user.
    getInfoUser();
  }

  ///
  /// Call API get data user.
  ///
  void getInfoUser() {
    /// Check and display caller information.
    if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
      userProvider.find(
        id: "${idRespondent.toString()}?populate=idProvince",
        onSuccess: (model) {
          userResponse = model;

          /// Generate status calling.
          genStatusCalling();
        },
        onError: (error) {
          print(error);
        },
      );
    } else {
      userProvider.find(
        id: "${idQuestionAsker.toString()}?populate=idProvince",
        onSuccess: (model) {
          userResponse = model;

          /// Generate status calling.
          genStatusCalling();
        },
        onError: (error) {
          print(error);
        },
      );
    }

    /// Start count dow time ring the bell.
    if (caller == QUESTION_ASKER_CALL) {
      if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow = Timer.periodic(
          oneSec,
          (Timer timer) {
            if (timeCountDow.value == 0) {
              final Map<String, dynamic> paramSocket = {};
              paramSocket['status'] = CALL_TIME_OUT;
              paramSocket['idQuestionAsker'] = idQuestionAsker;
              paramSocket['idRespondent'] = idRespondent;
              paramSocket['userEndedCall'] = QUESTION_ASKER_ENDED_CALL;
              paramSocket['caller'] = QUESTION_ASKER_CALL;

              /// Shoot socket when call timeout.
              iziSocket.socket.emit('end_call_socket', paramSocket);

              IZIToast().error(message: 'tilte_room_call_video_1'.tr);
              assetsAudioPlayer.dispose();
              timerCountDow!.cancel();
              Get.back();
            } else {
              if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
                timeCountDow.value--;
              }
            }
          },
        );
      } else {
        assetsAudioPlayer.open(
          Audio("assets/audios/incoming_call.mp3"),
        );
      }
    } else if (caller == RESPONDENT_CALL) {
      if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow = Timer.periodic(
          oneSec,
          (Timer timer) {
            if (timeCountDow.value == 0) {
              final Map<String, dynamic> paramSocket = {};
              paramSocket['status'] = CALL_TIME_OUT;
              paramSocket['idQuestionAsker'] = idQuestionAsker;
              paramSocket['idRespondent'] = idRespondent;
              paramSocket['userEndedCall'] = RESPONDENT_ENDED_CALL;
              paramSocket['caller'] = RESPONDENT_CALL;

              /// Shoot socket when call timeout.
              iziSocket.socket.emit('end_call_socket', paramSocket);

              IZIToast().error(message: 'tilte_room_call_video_1'.tr);
              assetsAudioPlayer.dispose();
              timerCountDow!.cancel();
              Get.back();
            } else {
              if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
                timeCountDow.value--;
              }
            }
          },
        );
      } else {
        assetsAudioPlayer.open(
          Audio("assets/audios/incoming_call.mp3"),
        );
      }
    }
  }

  ///
  ///  Generate status calling.
  ///
  ///status = 0 : Display video call screen, status = 1: Display call screen, status = 2: Show incoming call screen.
  void genStatusCalling() {
    if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser && caller == QUESTION_ASKER_CALL) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 1;
      }
    }
    if (idRespondent == sl<SharedPreferenceHelper>().getIdUser && caller == QUESTION_ASKER_CALL) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 2;
      }
    }

    if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser && caller == RESPONDENT_CALL) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 2;
      }
    }
    if (idRespondent == sl<SharedPreferenceHelper>().getIdUser && caller == RESPONDENT_CALL) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 1;
      }
    }

    /// If you are the recipient of the call, turn off loading.
    if (IZIValidate.nullOrEmpty(idRoom)) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        isLoading = false;
        update();
      }
    }

    /// If android device then check permission.
    if (Platform.isAndroid) {
      /// Check permission device.
      checkPermission();
    }
  }

  ///
  /// Check permission device.
  ///
  Future<void> checkPermission() async {
    /// Check speech permission.
    final statusSpeech = await Permission.speech.request();
    if (statusSpeech == PermissionStatus.granted) {
    } else if (statusSpeech == PermissionStatus.denied) {
      await openAppSettings();
    } else if (statusSpeech == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }

    /// Check camera permission.
    final statusCamera = await Permission.camera.request();
    if (statusCamera == PermissionStatus.granted) {
    } else if (statusCamera == PermissionStatus.denied) {
      await openAppSettings();
    } else if (statusCamera == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }
  }

  ///
  /// Create self id.
  ///
  void createSelfId({required dynamic data}) {
    if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
      _selfId = data['self'].toString();
      peers = data['peers'] as List<dynamic>;
      update();
    }

    /// Shooting Socket initiates the call. Whoever gets in first will shoot the socket.
    final Map<String, dynamic> paramSocket = {};
    if (caller == QUESTION_ASKER_CALL) {
      if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
        paramSocket['idRoom'] = _selfId;
        paramSocket['status'] = CONNECT_CALL;
        paramSocket['idQuestionAsker'] = idQuestionAsker;
        paramSocket['idRespondent'] = idRespondent;
        paramSocket['idQuestion'] = idQuestion;
        paramSocket['caller'] = QUESTION_ASKER_CALL;
      }
    } else {
      paramSocket['idRoom'] = _selfId;
      paramSocket['status'] = CONNECT_CALL;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['idQuestion'] = idQuestion;
      paramSocket['caller'] = RESPONDENT_CALL;
    }

    /// Start the call. Shoot socket for receiver with idRoom.
    iziSocket.socket.emit('call_socket', paramSocket);

    /// The person who initiates the call does not need to load.
    if (!IZIValidate.nullOrEmpty(idRoom)) {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        isLoading = false;
        update();
      }
    } else {
      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        isLoadingStatusCalling = true;
        update();
      }
    }
  }

  ///
  /// Turn off video called.
  ///
  void turnOffVideoCalled() {
    final Map<String, dynamic> paramSocket = {};
    if (caller == QUESTION_ASKER_CALL) {
      paramSocket['idRoom'] = '';
      paramSocket['status'] = TURN_OFF_CALL;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['userEndedCall'] = RESPONDENT_ENDED_CALL;
      paramSocket['caller'] = QUESTION_ASKER_CALL;
    } else {
      paramSocket['idRoom'] = '';
      paramSocket['status'] = TURN_OFF_CALL;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['userEndedCall'] = QUESTION_ASKER_ENDED_CALL;
      paramSocket['caller'] = RESPONDENT_CALL;
    }
    iziSocket.socket.emit('end_call_socket', paramSocket);
    Get.back();
  }

  ///
  /// Turn off video call.
  ///
  void turnOffVideoCall() {
    final Map<String, dynamic> paramSocket = {};
    if (caller == QUESTION_ASKER_CALL) {
      paramSocket['idRoom'] = '';
      paramSocket['status'] = TURN_OFF_CALL;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['userEndedCall'] = QUESTION_ASKER_ENDED_CALL;
      paramSocket['caller'] = QUESTION_ASKER_CALL;
    } else {
      paramSocket['idRoom'] = '';
      paramSocket['status'] = TURN_OFF_CALL;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['userEndedCall'] = RESPONDENT_ENDED_CALL;
      paramSocket['caller'] = RESPONDENT_CALL;
    }
    iziSocket.socket.emit('end_call_socket', paramSocket);
    Get.back();
  }

  ///
  /// Accept video caller.
  ///
  Future<void> acceptVideoCaller() async {
    await joinRoom();
  }

  ///
  /// Join room video call.
  ///
  Future<void> joinRoom() async {
    if (!IZIValidate.nullOrEmpty(idRoom)) {
      /// Invite join room.
      await invitePeer(Get.context!, idRoom.toString(), false);
    }
  }

  ///
  /// Invite join room.
  ///
  Future<void> invitePeer(BuildContext context, String peerId, bool useScreen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling?.invite(peerId, 'video', useScreen);
    }

    if (caller == QUESTION_ASKER_CALL) {
      if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow!.cancel();
      }
    } else if (caller == RESPONDENT_CALL) {
      if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow!.cancel();
      }
    }
  }

  ///
  /// Accept join room.
  ///
  void _accept() {
    if (_session != null) {
      _signaling?.accept(_session!.sid);

      if (Get.routing.current == CallVideoScreenRoutes.ROOM_VIDEO_CALL) {
        statusCalling.value = 0;
      }
      assetsAudioPlayer.dispose();
    }

    /// Start count dow call time.
    callTimerCountDow = Timer.periodic(oneSec, (timer) {
      if (callTimerCountDowValue.value == 0) {
        IZIToast().successfully(message: 'call_ended'.tr, colorBG: ColorResources.CALL_VIDEO);
        if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
          Get.back();
        } else {
          final Map<String, dynamic> param = {
            'idRoom': '',
            'idQuestionAsker': idQuestionAsker,
            'idRespondent': idRespondent,
            'idQuestion': idQuestion,
          };
          Get.toNamed(ReviewAndPaymentRoutes.REVIEW_AND_PAYMENT, arguments: param)!.then((value) {
            sl<SharedPreferenceHelper>().setCalling(isCalling: false);
            Get.back();
          });
        }
        callTimerCountDow!.cancel();
      } else {
        callTimerCountDowValue.value--;
      }
    });
    if (caller == QUESTION_ASKER_CALL) {
      if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow!.cancel();
      }
    } else if (caller == RESPONDENT_CALL) {
      if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow!.cancel();
      }
    }

    final Map<String, dynamic> paramSocket = {};
    if (caller == QUESTION_ASKER_CALL) {
      paramSocket['idRoom'] = '';
      paramSocket['status'] = JOIN_ROOM_CALL_VIDEO;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['idQuestion'] = idQuestion;
      paramSocket['caller'] = QUESTION_ASKER_CALL;
    } else {
      paramSocket['idRoom'] = '';
      paramSocket['status'] = JOIN_ROOM_CALL_VIDEO;
      paramSocket['idQuestionAsker'] = idQuestionAsker;
      paramSocket['idRespondent'] = idRespondent;
      paramSocket['idQuestion'] = idQuestion;
      paramSocket['caller'] = RESPONDENT_CALL;
    }

    iziSocket.socket.emit('end_call_socket', paramSocket);
  }

  ///
  /// Hang up video call.
  ///
  void stateByeCallVideo() {
    //! Remove video
    localRenderer.srcObject = null;
    remoteRenderer.srcObject = null;
    _session = null;
    update();

    if (!IZIValidate.nullOrEmpty(localRenderer)) {
      localRenderer.dispose();
    }
    if (!IZIValidate.nullOrEmpty(remoteRenderer)) {
      remoteRenderer.dispose();
    }
    if (!IZIValidate.nullOrEmpty(timerCountDow)) {
      timerCountDow!.cancel();
    }
    if (!IZIValidate.nullOrEmpty(callTimerCountDow)) {
      callTimerCountDow!.cancel();
    }
    _signaling?.close();

    IZIToast().successfully(message: 'call_ended'.tr, colorBG: ColorResources.CALL_VIDEO);
    if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
      Get.back();
    } else {
      final Map<String, dynamic> param = {
        'idRoom': '',
        'idQuestionAsker': idQuestionAsker,
        'idRespondent': idRespondent,
        'idQuestion': idQuestion,
      };
      Get.toNamed(ReviewAndPaymentRoutes.REVIEW_AND_PAYMENT, arguments: param)!.then((value) {
        sl<SharedPreferenceHelper>().setCalling(isCalling: false);
        Get.back();
      });
    }
  }

  ///
  /// Reject join room.
  ///
  void reject() {
    if (_session != null) {
      _signaling?.reject(_session!.sid);
    }
    _signaling?.close();
    if (!IZIValidate.nullOrEmpty(localRenderer)) {
      localRenderer.dispose();
    }
    if (!IZIValidate.nullOrEmpty(remoteRenderer)) {
      remoteRenderer.dispose();
    }
  }

  ///
  ///  Hangup join room.
  ///
  void hangUp() {
    if (!IZIValidate.nullOrEmpty(localRenderer)) {
      localRenderer.dispose();
    }
    if (!IZIValidate.nullOrEmpty(remoteRenderer)) {
      remoteRenderer.dispose();
    }
    if (_session != null) {
      _signaling?.bye(_session!.sid);
    }
    _signaling?.close();
    drawingController!.dispose();
    assetsAudioPlayer.dispose();
    if (!IZIValidate.nullOrEmpty(callTimerCountDow)) {
      callTimerCountDow!.cancel();
    }
    if (caller == QUESTION_ASKER_CALL) {
      if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow!.cancel();
      }
    } else if (caller == RESPONDENT_CALL) {
      if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
        timerCountDow!.cancel();
      }
    }
    IZIToast().successfully(message: 'call_ended'.tr, colorBG: ColorResources.CALL_VIDEO);
    if (idRespondent == sl<SharedPreferenceHelper>().getIdUser) {
      Get.back();
    } else {
      final Map<String, dynamic> param = {
        'idRoom': '',
        'idQuestionAsker': idQuestionAsker,
        'idRespondent': idRespondent,
        'idQuestion': idQuestion,
      };

      if (!IZIValidate.nullOrEmpty(timerCountDow)) {
        timerCountDow!.cancel();
      }
      Get.toNamed(ReviewAndPaymentRoutes.REVIEW_AND_PAYMENT, arguments: param)!.then((value) {
        Get.back();
      });
    }
  }

  ///
  /// Switch Camera.
  ///
  void switchCamera() {
    isSwitchCamera.value = !isSwitchCamera.value;

    _signaling?.switchCamera();
  }

  ///
  /// Mute mic.
  ///
  void muteMic() {
    isMuteMic.value = !isMuteMic.value;
    _signaling?.muteMic();
  }

  ///
  /// On change camera.
  ///
  void onChangedCamera() {
    isEnableCamera.value = !isEnableCamera.value;

    if (isEnableCamera.value == true) {
      _signaling?.onChangedCamera(enabled: false);
    } else {
      _signaling?.onChangedCamera(enabled: true);
    }
  }

  ///
  /// On change radio report.
  ///
  void onChangeRadioReport(int value) {
    groupValueReport = value;
    update();
  }

  ///
  /// Generate bool button.
  ///
  bool genBoolButton() {
    if (groupValueReport == valueOtherReport && IZIValidate.nullOrEmpty(otherReportController)) {
      return false;
    }
    return true;
  }

  ///
  /// Generate value status calling.
  ///
  String genValueStatusCalling() {
    if (isLoadingStatusCalling == true) {
      return 'tilte_room_call_video_2'.tr;
    }
    if (!IZIValidate.nullOrEmpty(idRoom)) {
      return 'tilte_room_call_video_3'.tr;
    }

    return 'tilte_room_call_video_4'.tr;
  }

  ///
  /// Generate value status screen.
  ///
  int genValueStatusScreen() {
    if (statusCalling.value == 1) {
      return 1;
    }
    if (statusCalling.value == 2) {
      return 1;
    }
    return 0;
  }

  ///
  /// Open drawing screen.
  ///
  void openDrawingScreen() {
    drawingController = DrawingController();
    isOpenDrawingScreen.value = !isOpenDrawingScreen.value;
    if (isOpenDrawingScreen.value == false) {
      drawingScreen.value = SizedBox(
        width: IZIDimensions.ONE_UNIT_SIZE * 5,
        height: IZIDimensions.ONE_UNIT_SIZE * 5,
      );
    } else {
      drawingScreen.value = SizedBox(
        width: IZIDimensions.iziSize.width,
        height: IZIDimensions.iziSize.height,
        child: Align(
          alignment: Alignment.topCenter,
          child: DrawingBoard(
            onPanUpdate: (data) {},
            onPanEnd: (data) {},
            onPanStart: (data) {},
            controller: drawingController,
            background: Container(
              width: IZIDimensions.iziSize.width,
              height: IZIDimensions.iziSize.height,
              color: Colors.white,
            ),
            showDefaultActions: true,
            showDefaultTools: true,
            defaultToolsBuilder: (Type t, _) {
              return DrawingBoard.defaultTools(t, drawingController!)
                ..insert(
                  1,
                  DefToolItem(
                    icon: Icons.change_history_rounded,
                    isActive: t == Triangle,
                    onTap: () => drawingController!.setPaintContent = Triangle(),
                  ),
                );
            },
          ),
        ),
      );
    }
  }

  ///
  /// Show Report dialog.
  ///
  void showDialogReport() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      barrierDismissible: false,
      title: '',
      content: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          width: IZIDimensions.iziSize.width,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "denounce".tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6,
                            fontWeight: FontWeight.w600,
                            color: ColorResources.BLACK,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        activeColor: ColorResources.PRIMARY_APP,
                        value: valueImageReport,
                        groupValue: groupValueReport,
                        onChanged: (val) {
                          setState(() {
                            groupValueReport = val!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'content_1_report'.tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        activeColor: ColorResources.PRIMARY_APP,
                        value: valueLanguageReport,
                        groupValue: groupValueReport,
                        onChanged: (val) {
                          setState(() {
                            groupValueReport = val!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'content_2_report'.tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio<int>(
                        activeColor: ColorResources.PRIMARY_APP,
                        value: valueOtherReport,
                        groupValue: groupValueReport,
                        onChanged: (val) {
                          setState(() {
                            groupValueReport = val!;
                          });
                        },
                      ),
                      Expanded(
                        child: Text(
                          'other'.tr,
                          style: TextStyle(
                            fontSize: IZIDimensions.FONT_SIZE_H6 * .9,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (groupValueReport == valueOtherReport)
                    Container(
                      margin: EdgeInsets.only(
                        bottom: IZIDimensions.SPACE_SIZE_2X,
                        left: IZIDimensions.SPACE_SIZE_2X,
                        right: IZIDimensions.SPACE_SIZE_2X,
                      ),
                      child: IZIInput(
                        type: IZIInputType.MULTILINE,
                        isRequired: true,
                        textInputAction: TextInputAction.newline,
                        maxLine: 2,
                        isBorder: true,
                        colorBorder: ColorResources.PRIMARY_APP,
                        placeHolder: "hint_report".tr,
                        onChanged: (val) {
                          setState(() {
                            otherReportController = val;
                          });
                        },
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: IZIDimensions.SPACE_SIZE_2X,
                      left: IZIDimensions.SPACE_SIZE_2X,
                      right: IZIDimensions.SPACE_SIZE_2X,
                    ),
                    child: Text(
                      "note_report".tr,
                      style: TextStyle(
                        fontSize: IZIDimensions.FONT_SIZE_SPAN,
                        color: ColorResources.RED,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      IZIButton(
                        margin: const EdgeInsets.all(0),
                        type: IZIButtonType.OUTLINE,
                        label: "back".tr,
                        width: IZIDimensions.iziSize.width * 0.33,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                          vertical: IZIDimensions.ONE_UNIT_SIZE * 15,
                        ),
                        onTap: () {
                          Get.back();
                        },
                      ),
                      const Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      SizedBox(
                        width: IZIDimensions.SPACE_SIZE_1X,
                      ),
                      const Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                      IZIButton(
                        isEnabled: genBoolButton(),
                        margin: const EdgeInsets.all(0),
                        width: IZIDimensions.iziSize.width * 0.33,
                        padding: EdgeInsets.symmetric(
                          horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                          vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                        ),
                        colorBG: ColorResources.RED,
                        label: "report_video".tr,
                        onTap: () {

                          final QuestionRequest questionRequest = QuestionRequest();
                          if (groupValueReport == valueImageReport) {
                            questionRequest.denounce = 'content_1_report'.tr;
                          } else if (groupValueReport == valueLanguageReport) {
                            questionRequest.denounce = 'content_2_report'.tr;
                          } else if (groupValueReport == valueOtherReport) {
                            questionRequest.denounce = otherReportController;
                          }
                          if (idQuestionAsker == sl<SharedPreferenceHelper>().getIdUser) {
                            questionRequest.denounceBy = idRespondent;
                          } else {
                            questionRequest.denounceBy = idQuestionAsker;
                          }
                          questionProvider.update(
                            id: idQuestion.toString(),
                            data: questionRequest,
                            onSuccess: (val) {
                              IZIToast().successfully(message: 'tilte_room_call_video_5'.tr);
                              Get.back();
                            },
                            onError: (error) {
                              print(error);
                            },
                          );
                        },
                      ),
                      const Flexible(
                        fit: FlexFit.tight,
                        child: SizedBox(),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
