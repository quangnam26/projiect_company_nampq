import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/base_widget/izi_button.dart';
import 'package:template/base_widget/izi_image.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_dimensions.dart';
import 'package:template/helper/izi_toast.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/question_provider.dart';
import 'package:template/routes/route_path/call_screen_routers.dart';
import 'package:template/routes/route_path/create_question_routers.dart';
import 'package:template/routes/route_path/login_routers.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart';
import 'package:template/utils/images_path.dart';
import 'package:template/view/screen/%20my_wallet/component/custom_izi_cart.dart';
import 'package:template/view/screen/account_user/account_page.dart';
import 'package:template/view/screen/create_question/create_question_page.dart';
import 'package:template/view/screen/home/home_controller.dart';
import 'package:template/view/screen/home/home_page.dart';
import '../../../data/datasource/remote/dio/izi_socket.dart';
import '../room_video_call/room_video_call_controller.dart';

class DashBoardController extends GetxController with WidgetsBindingObserver {
  /// Declare API.
  final QuestionProvider questionProvider = GetIt.I.get<QuestionProvider>();
  final IZISocket iziSocket = GetIt.I.get<IZISocket>();

  /// Declare Data.
  final List<Map<String, dynamic>> pages = [
    {
      'label': "home".tr,
      'icon': ImagesPath.logo_home_page,
      'icon_unselected': ImagesPath.logo_home_unselected_page,
      'page': HomePage(),
    },
    {
      'label': "explore".tr,
      'icon': ImagesPath.logo_explore_page,
      'icon_unselected': ImagesPath.logo_explore_unselected_page,
      'page': IZIImage(
        ImagesPath.image_home_page,
        height: IZIDimensions.iziSize.height,
        width: IZIDimensions.iziSize.width,
      )
    },
    {
      'label': "",
      'icon': ImagesPath.logo_add_question,
      'icon_unselected': ImagesPath.logo_add_question,
      'page': CreateQuestionPage(),
    },
    {
      'label': "dating".tr,
      'icon': ImagesPath.logo_love_page,
      'icon_unselected': ImagesPath.logo_love_unselected_page,
      'page': IZIImage(
        ImagesPath.image_home_page,
        height: IZIDimensions.iziSize.height,
        width: IZIDimensions.iziSize.width,
      ),
    },
    {
      'label': "account".tr,
      'icon': ImagesPath.logo_account_page,
      'page': AccountPage(),
      'icon_unselected': ImagesPath.logo_account_unselected_page,
    },
  ];
  DateTime? currentBackPressTime;
  RxInt currentIndex = 0.obs;
  RxBool isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();

    /// Get value isLogin for check logger not yet.
    isLogin.value = sl<SharedPreferenceHelper>().getLogin;
    if (Get.arguments != null) {
      if (Get.arguments.runtimeType == int) {
        currentIndex.value = Get.arguments as int;
      }
    }

    /// Start list socket.
    startSocket();
  }

  @override
  void dispose() {
    currentIndex.close();
    isLogin.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      /// Start list socket.
      startSocket();
    }
  }

  ///
  ///  Start list socket.
  ///
  void startSocket() {
    /// List event socket
    if (!iziSocket.socket.hasListeners('call_socket')) {
      iziSocket.socket.on(
        'call_socket',
        (data) {
          if (!IZIValidate.nullOrEmpty(data)) {
            ///
            /// List socket and go to [Call video page] for respondent.
            listSocketAndToCallVideoScreenForRespondent(dataSocket: data);
          }
        },
      );
    }
  }

  ///
  /// List socket and go to [Call video page] for respondent.
  ///
  void listSocketAndToCallVideoScreenForRespondent({required dynamic dataSocket}) {
    ///
    /// Go to the call where the caller is the person asking the question.
    if (dataSocket['idRespondent'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == CONNECT_CALL && dataSocket['caller'].toString() == QUESTION_ASKER_CALL) {
      ///
      /// Get value isCalling. If isCalling == false then allow go to [Call page] else don't allow.
      final isCalling = sl<SharedPreferenceHelper>().getCalling;
      if (isCalling == false) {
        ///
        /// Set isCalling == true purpose just join a call.
        sl<SharedPreferenceHelper>().setCalling(isCalling: true);

        /// Reload [Room video call controller] controller when used multiple times.
        Get.reload<RoomVideoCallController>();
        Get.toNamed(CallVideoScreenRoutes.ROOM_VIDEO_CALL, arguments: dataSocket)!.then(
          (value) async {
            ///
            /// When off calling then set isCalling == false purpose allow calling and delay 2 minutes.
            await Future.delayed(const Duration(seconds: 2));
            sl<SharedPreferenceHelper>().setCalling(isCalling: false);
          },
        );
      }
    }

    /// Go to the call where the caller is the answerer.
    else if (dataSocket['idQuestionAsker'].toString() == sl<SharedPreferenceHelper>().getIdUser && dataSocket['status'].toString() == CONNECT_CALL && dataSocket['caller'].toString() == RESPONDENT_CALL) {
      ///
      /// Get value isCalling. If isCalling == false then allow go to [Call page] else don't allow.
      final isCalling = sl<SharedPreferenceHelper>().getCalling;
      if (isCalling == false) {
        ///
        /// Set isCalling == true purpose just join a call.
        sl<SharedPreferenceHelper>().setCalling(isCalling: true);

        /// Reload [Room video call controller] controller when used multiple times.
        Get.reload<RoomVideoCallController>();
        Get.toNamed(CallVideoScreenRoutes.ROOM_VIDEO_CALL, arguments: dataSocket)!.then(
          (value) async {
            ///
            /// When off calling then set isCalling == false purpose allow calling and delay 2 minutes.
            await Future.delayed(const Duration(seconds: 2));
            sl<SharedPreferenceHelper>().setCalling(isCalling: false);
          },
        );
      }
    }
  }

  ///
  /// On change index in [DashBoard page].
  ///
  void onChangedPage(int index) {
    ///
    /// If index == 2 then perform condition below.
    if (index == 2) {
      ///
      /// If isLogin == false then show login dialog else go to [Create question page].
      if (isLogin.value == false) {
        showDialogLogin();
      } else {
        Get.toNamed(CreateQuestionRoutes.CREATE_QUESTION)!.then((value) {
          Get.find<HomeController>().getCountNotice();
        });
      }
    } else {
      currentIndex.value = index;
    }
  }

  ///
  /// On double back in perform device.
  ///
  Future<bool> onDoubleBack() {
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      IZIToast().error(message: "exit_app".tr);
      return Future.value(false);
    }
    return Future.value(true);
  }

  ///
  /// Show login dialog.
  ///
  void showDialogLogin() {
    Get.defaultDialog(
      titlePadding: EdgeInsets.zero,
      barrierDismissible: false,
      title: '',
      content: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_2X,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    IZIDimensions.BORDER_RADIUS_5X,
                  ),
                  child: IZIImage(
                    ImagesPath.login_guest,
                    height: IZIDimensions.ONE_UNIT_SIZE * 200,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: IZIDimensions.SPACE_SIZE_5X,
            ),
            child: IZIText(
              textAlign: TextAlign.center,
              text: "required_login".tr,
              maxLine: 7,
              style: TextStyle(
                fontSize: IZIDimensions.FONT_SIZE_H6,
                fontWeight: FontWeight.w600,
              ),
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
                margin: const EdgeInsets.all(0),
                width: IZIDimensions.iziSize.width * 0.33,
                padding: EdgeInsets.symmetric(
                  horizontal: IZIDimensions.ONE_UNIT_SIZE * 15,
                  vertical: IZIDimensions.ONE_UNIT_SIZE * 20,
                ),
                label: "Agree".tr,
                onTap: () {
                  Get.offNamed(LoginRoutes.LOGIN);
                },
              ),
              const Flexible(
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
