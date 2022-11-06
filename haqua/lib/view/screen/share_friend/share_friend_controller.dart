import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:template/utils/app_constants.dart';

import '../../../helper/izi_toast.dart';
import '../../../helper/izi_validate.dart';
import '../../../provider/settings_provider.dart';

class ShareFriendController extends GetxController {
  ///
  /// Declare API.
  final SettingsProvider settingProvider = GetIt.I.get<SettingsProvider>();

  /// Declare Data.
  String urlShare = '';
  bool isLoading = true;

  @override
  void onInit() {
    /// Call API get share link .
    getShareLink();
    super.onInit();
  }

  ///
  /// Call API get share link .
  ///
  void getShareLink() {
    settingProvider.findSetting(
      onSuccess: (model) {
        if (!IZIValidate.nullOrEmpty(model)) {
          urlShare = model!.shareContent.toString();
        }

        isLoading = false;
        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }

  ///
  ///genLinkShare
  ///
  String genLinkShare() {
    if (Platform.isIOS) {
      return urlShare.split('/').last;
    }

    return urlShare.split('/').last;
  }

  ///
  ///Copy
  ///
  void onBtnCopy() {
    String urlLink = urlShare;
    if (Platform.isIOS) {
      urlLink = urlShare;
    }
    Clipboard.setData(ClipboardData(text: urlLink));
    IZIToast().successfully(message: 'copy_successful'.tr);
  }

  ///
  /// shareLinkFriend
  ///
  Future<void> shareLinkFriend() async {
    String urlLink = urlShare;
    if (Platform.isIOS) {
      urlLink = urlShare;
    }
    await Share.share(urlLink);
  }
}
