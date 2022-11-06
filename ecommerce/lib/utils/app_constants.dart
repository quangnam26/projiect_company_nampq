// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

const String BASE_URL = 'https://p24ecommerce.izisoft.io/v1';
const String BASE_URL_IMAGE = 'https://p24ecommerce.izisoft.io';
// const String BASE_URL = 'http://127.0.0.1:4024/v1';
// const String BASE_URL_IMAGE = 'http://127.0.0.1:4022';
const String socket_url = 'wss://socket1.crudcode.tk';
const String support_message = 'p24ecommerce_chat';
const String ecommerce_socket = 'ecommerce_socket';
final String clientId = Platform.isAndroid
    ? '353051682231-k01189va18bsghrhh34v1vd05v00n3hi.apps.googleusercontent.com'
    : '353051682231-rchertolq28cu3hs43fkdjksq88p8cho.apps.googleusercontent.com'; //"104055501200451194456";
// "353051682231-aai3ct6lq44c3id5645krs5fnc66lk02.apps.googleusercontent.com";
// '504196734381436';
// '402268459777-en6osp5ccnqmd03p42rvapn5jcs3lh69.apps.googleusercontent.com';

/// Xác định là trang thêm
const int FLOAT_ACTION_BUTTON_PAGE = 100;

const String HOANG_SA = '62cbf0c51903c461cb81765a';
const String CON_DAO = '62cbf0c71903c461cb818066';

//Type Question
const String ORDER = 'ORDER';
const String CART = 'CART';
const String VOUCHER = 'VOUCHER';
const String PRODUCT = 'PRODUCT';
const String NEWS = 'NEWS';
const String PAYMENT = 'PAYMENT';

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

List<String> gender = ["Nam", "Nữ", "Khác"];

///
/// Muốn set ngôn ngữ tự động theo ngôn ngữ máy
///
// Locale localeResolutionCallback(Locale locale,Iterable<Locale> supportedLocales){
//   if(locale == null){
//     return supportedLocales.first;
//   }
//   for(final supportedLocale in supportedLocales){
//     if(supportedLocale.languageCode == locale.languageCode){
//       return supportedLocale;
//     }
//   }
//   return supportedLocales.first;
// }

List<LocalizationsDelegate> localizationsDelegates = [
  // AppLocalizations.delegate,// Load dư liệu trước
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate
];

const htmlData = """

     <h2> <p style="text-align: center;"><span style="color: rgba(0, 0, 0, 0.95);">Chính sách đổi hàng</span></p></h2>
 
    <p "><span style="color: rgba(0, 0, 0, 0.95);">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec vestibulum sapien feugiat lorem tempor, id porta orci elementum. Fusce sed justo id arcu egestas congue. Fusce tincidunt lacus ipsum, in imperdiet felis ultricies eu. In ullamcorper risus felis, ac maximus dui bibendum vel. Integer ligula tortor, facilisis eu mauris ut, ultrices hendrerit ex. Donec scelerisque massa consequat, eleifend mauris eu, mollis dui. Donec placerat augue tortor, et tincidunt quam tempus non. Quisque sagittis enim nisi, eu condimentum lacus egestas ac. Nam facilisis luctus ipsum, at aliquam urna fermentum a. Quisque tortor dui, faucibus in ante eget, pellentesque mattis nibh. In augue dolor, euismod vitae eleifend nec, tempus vel urna. Donec vitae augue accumsan ligula fringilla ultrices et vel ex.</span></p>

     

   
    
  

 


   


    

  
  
""";
