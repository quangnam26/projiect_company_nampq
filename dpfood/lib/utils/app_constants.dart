// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String BASE_URL = 'https://p23dpfood.izisoft.io/v1';
// const String BASE_URL = 'http://127.0.0.1:4023/v1';
const String BASE_URL_IMAGE = 'https://p23dpfood.izisoft.io';
const String GOONG_KEY = 't4csnkeZOwAUYCIOCTAg5AAGw6HGuQ7lNWsiHM8c';
const String GOONG_URL = 'https://rsapi.goong.io';
const String SOCKET_URL = 'http://127.0.0.1:6023';

/// Xác định là trang thêm
const int FLOAT_ACTION_BUTTON_PAGE = 100;

const String HOANG_SA = '62cbf0c51903c461cb81765a';
const String CON_DAO = '62cbf0c71903c461cb818066';

const IconData DELICIOUS = Icons.sentiment_very_satisfied_rounded;
const IconData WELLPACKED = CupertinoIcons.cube_box_fill;
const IconData VERY_WORTH_THE_MONEY = Icons.sentiment_satisfied_alt_rounded;
const IconData SATISFIED = Icons.thumb_up;
const IconData QUICKSERVICE = Icons.bolt;
const IconData SAD = Icons.sentiment_dissatisfied_rounded;

// const String IAP_SUBSCRIPTION_MONTHLY = 'com.astralerstudio.dmv.monthly';
// const String IAP_SUBSCRIPTION_6_MONTHS = 'com.astralerstudio.dmv.6_months';
// const String IAP_SUBSCRIPTION_LIFETIME = 'com.astralerstudio.dmv.lifetime_purchase';

// const List<String> IAP_LIST_SUBSCRIPTIONS = [
//   IAP_SUBSCRIPTION_MONTHLY,
//   IAP_SUBSCRIPTION_6_MONTHS,
//   IAP_SUBSCRIPTION_LIFETIME,
// ];

const String FCM_TOPIC_DEFAULT = 'fcm_all';
const String NOTIFICATION_KEY = 'notification_key';
const String NOTIFICATION_TITLE = 'title';
const String NOTIFICATION_BODY = 'body';

const String TRANG_THAI_DON_HANG_DON_MOI = '0';
const String TRANG_THAI_DON_HANG_NHAN_DON = '1';
const String TRANG_THAI_DON_HANG_NHAN_MON = '2'; // NHẬN MÓN TẠI NHÀ HÀNG
const String TRANG_THAI_DON_HANG_XAC_NHAN = '3'; // XÁC NHẬN LẤY MÓN
const String TRANG_THAI_DON_HANG_DEN_VI_TRI_GIAO = '4';
const String TRANG_THAI_DON_HANG_GIAO_HANG = '5';
const String TRANG_THAI_DON_HANG_XAC_NHAN_GIAO = '6';
const String TRANG_THAI_DON_HANG_HUY_DON = '7';
const String TRANG_THAI_DON_HANG_HOAN_TIEN = '8';

///
/// Muốn set ngôn ngữ tự động theo ngôn ngữ máy
///

Locale localeResolutionCallback(
    Locale locale, Iterable<Locale> supportedLocales) {
  if (locale == null) {
    return supportedLocales.first;
  }
  for (final supportedLocale in supportedLocales) {
    if (supportedLocale.languageCode == locale.languageCode) {
      return supportedLocale;
    }
  }
  return supportedLocales.first;
}

List<LocalizationsDelegate> localizationsDelegates = [
  // AppLocalizations.delegate,// Load dư liệu trước
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate
];
