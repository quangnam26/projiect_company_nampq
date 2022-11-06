
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String BASE_URL = 'https://p22supertransport.izisoft.io/v1';
const String BASE_URL_IMAGE = 'https://p22supertransport.izisoft.io';
// const String BASE_URL = 'http://127.0.0.1:4022/v1';
// const String BASE_URL_IMAGE = 'http://127.0.0.1:4022';


/// Xác định là trang thêm 
const int FLOAT_ACTION_BUTTON_PAGE = 100;


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

///
/// Muốn set ngôn ngữ tự động theo ngôn ngữ máy
///
Locale localeResolutionCallback(Locale locale,Iterable<Locale> supportedLocales){
  if(locale == null){
    return supportedLocales.first;
  }
  for(final supportedLocale in supportedLocales){
    if(supportedLocale.languageCode == locale.languageCode){
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

