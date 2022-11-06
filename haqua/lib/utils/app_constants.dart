import 'package:get/get.dart';
import 'package:template/data/model/languages/language_model.dart';
import 'package:template/helper/izi_dimensions.dart';

const String BASE_URL = 'https://p21haqua.izisoft.io/v1';
const String BASE_URL_IMAGE = 'https://p21haqua.izisoft.io/static/';
// const String HOST_CALL_VIDEO = 'demo.cloudwebrtc.com';
const String HOST_CALL_VIDEO = 'webrtc.izisoft.io';

//FirebaseMessaging
const String FCM_TOPIC_DEFAULT = 'p21_haqua';
const String NOTIFICATION_KEY = 'notification_key';
const String NOTIFICATION_TITLE = 'notification_title';

List<LanguageModel> languages = [
  LanguageModel(imageUrl: '', languageName: 'Việt Nam', countryCode: 'VI', languageCode: 'vi'),
  LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
];

final double SPACE_BOTTOM_SHEET = IZIDimensions.iziSize.height * .08;

const String LINK_APP_ANDROID = 'https://play.app.goo.gl/?link=https://play.google.com/store/apps/details?id=io.izisoft.p09fivesbs';
const String LINK_APP_IOS = 'https://apps.apple.com/vn/app/clips/id1597116330?l=vi';

List<String> LANGUAGE_CREATE_QUESTION = [
  "Not_required".tr,
  "english".tr,
  "vietnamese".tr,
  "Japanese".tr,
  "French".tr,
  "Chinese".tr,
  "Korean".tr,
];
List<String> GENDER_DATA_PROFILE = [
  'All'.tr,
  "male".tr,
  "Female".tr,
];

List<String> GENDER_DATA_CREATE_QUESTION = [
  "All".tr,
  "male".tr,
  "Female".tr,
];

List<String> REGION_DATA_CREATE_QUESTION = [
  "Not_required".tr,
  "Northern".tr,
  "Central".tr,
  "South".tr,
];

List<String> NATION_PROFILE = [
  'nation_English'.tr,
  'nation_Vietnam'.tr,
  'nation_France'.tr,
  'nation_China'.tr,
  'nation_Korea'.tr,
  'nation_Singapore'.tr,
];

//Type Register
const String GOOGLE = 'google';
const String FACEBOOK = 'facebook';
const String APPLE = 'apple';
const String HAQUA = 'haqua';

//Sign Up HaQua
const int TYPE_REGISTERS_HAQUA = 1;
const int TYPE_REGISTERS_GOOGLE = 2;
const int TYPE_REGISTERS_APPLE = 3;
const int TYPE_REGISTERS_FACEBOOK = 4;

// Status Call Socket
const String CONNECT_CALL = 'connect_call';
const String CONNECT_VIDEO_CALL = 'connect_video_call';
const String TURN_OFF_CALL = 'turn_off_call';
const String JOIN_ROOM_CALL_VIDEO = 'join_room_call_video';
const String QUESTION_ASKER_ENDED_CALL = 'question_asker_ended_call';
const String RESPONDENT_ENDED_CALL = 'respondent_ended_call';
const String QUESTION_ASKER_CALL = 'question_asker_call';
const String RESPONDENT_CALL = 'respondent_call';
const String CALL_TIME_OUT = 'call_time_out';

//Status Question
const String CONNECTING = 'connecting';
const String SELECTED_PERSON = 'selected person';
const String CALLED = 'called';
const String COMPLETED = 'completed';
const String CANCELED = 'canceled';

//Status Payment
const String DEPOSITED = 'deposited';
const String UNPAID = 'unpaid';
const String PAID = 'paid';
const String REFUNDED = 'refunded';

//Region
const String NORTH = 'North';
const String CENTRAL = 'Central';
const String SOUTH = 'South';

//Gender Question
const String ALL = 'all';
const String MALE = 'male';
const String FEMALE = 'female';

//Priority
const String PRIORITY = 'priority';
const String NOT_PRIORITY = 'not priority';

//Status share
const String NOT_SHARED = "not shared";
const String SHARED = "shared";

//Status Select Answer List
const String WAITING = "waiting";
const String SELECTED = "selected";
const String FAILURE = "failure";

//Type Question
const String QUESTION_ASK = 'question ask';
const String QUESTION_ANSWER = 'question answer';
const String TRANSACTION = 'transaction';
const String CUSTOMER_ANSWER = 'customer answer';
const String SHARING_VIDEO = 'sharing video';
const String OPTION = 'option';
const String SURVEY = 'survey';
const String DATING = 'dating';

//Status Review
const String CHECKING = 'checking';
const String TRUE = 'true';
const String UN_TRUE = 'untrue';

//Type Transaction
const String RECHARGE = 'recharge';
const String WITHDRAW = 'withdraw';

//Status Transaction
const String WAITING_TRANSACTION = 'waiting';
const String SUCCESS_TRANSACTION = 'success';
const String FAILED_TRANSACTION = 'failed';

//Method transaction
const String TRANSFERS = 'transfers';
const String MOMO = 'momo';
const String VIETTEL_PAY = 'viettel pay';

//Notice Socket
const String NOTICE_TO_ALL_USERS = 'notice to all users';
const String NOTICE_TO_CHANNEL = 'notice to channel';
const String NOTICE_TO_ADMIN = 'notice to admin';

//Quote helping list
const String QUOTED = 'quoted';
const String QUOTED_CANCELED = 'quote canceled';

//Data Hashtag Create Question
const List<String> DATA_HASHTAG = [
  '#haqua',
  '#vanhoc',
  '#toanhoc',
  '#tienganh',
  '#chungkhoan',
  '#bitcoin',
  '#vatly',
  '#dilam',
  '#flutter',
  '#nodejs',
  '#intern',
  '#fresher',
];

/// Type question.
const String TEXT_TYPE_QUESTION = 'text';
const String IMAGE_TYPE_QUESTION = 'image';
const String AUDIO_TYPE_QUESTION = 'audio';
const String VIDEO_TYPE_QUESTION = 'video';

/// Type answer.
const String TEXT_TYPE_ANSWER = 'text';
const String IMAGE_TYPE_ANSWER = 'image';
