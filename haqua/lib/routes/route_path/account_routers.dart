import 'package:get/get.dart';
import 'package:template/view/screen/account_user/account_binding.dart';
import 'package:template/view/screen/account_user/account_page.dart';
import 'package:template/view/screen/account_user/briefcase/briefcase_binding.dart';
import 'package:template/view/screen/account_user/briefcase/briefcase_page.dart';
import 'package:template/view/screen/account_user/infor_account/infor_account_binding.dart';
import 'package:template/view/screen/account_user/infor_account/infor_account_page.dart';
import 'package:template/view/screen/account_user/introduced_friend/introduced_friend_binding.dart';
import 'package:template/view/screen/account_user/introduced_friend/introduced_friend_page.dart';
import 'package:template/view/screen/your_abilities/exam_result/exam_result_binding.dart';
import 'package:template/view/screen/your_abilities/exam_result/exam_result_page.dart';
import 'package:template/view/screen/your_abilities/quizz/quizz_binding.dart';

import '../../view/screen/account_user/change_language/change_language_binding.dart';
import '../../view/screen/account_user/change_language/change_language_page.dart';
import '../../view/screen/share_friend/share_friend_binding.dart';
import '../../view/screen/share_friend/share_friend_page.dart';
import '../../view/screen/your_abilities/detail_abilities/detail_abilities_binding.dart';
import '../../view/screen/your_abilities/detail_abilities/detail_abilities_page.dart';
import '../../view/screen/your_abilities/quizz/quizz_page.dart';
import '../../view/screen/your_abilities/your_abilities_binding.dart';
import '../../view/screen/your_abilities/your_abilities_page.dart';

class AccountRouter {
  static const String ACCOUNT = '/account';
  static const String BRIEFCASE = '/briefCase';
  static const String INFORACCOUNT = '/inforAccount';
  static const String INTRODUCEDFRIEND = '/introducedFriend';
  static const String CHANGE_LANGUAGE = '/change_language';
  static const String SHARE_FRIEND = '/share_friend';
  static const String YOUR_ABILITIES = '/your_abilities';
  static const String DETAIL_ABILITIES = '/detail_abilities';
  static const String QUIZZ = '/quizz';
  static const String EXAM_RESULT = '/exam_result';

  static List<GetPage> list = [
    GetPage(
      name: ACCOUNT,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: BRIEFCASE,
      page: () => BriefCasePage(),
      binding: BriefCaseBinding(),
    ),
    GetPage(
      name: INFORACCOUNT,
      page: () => InforAccountPage(),
      binding: InforAccountBinding(),
    ),
    GetPage(
      name: INTRODUCEDFRIEND,
      page: () => IntroducedFriendPage(),
      binding: IntroducedFriendBinding(),
    ),
    GetPage(
      name: CHANGE_LANGUAGE,
      page: () => ChangeLanguagePage(),
      binding: ChangeLanguageBinding(),
    ),
    GetPage(
      name: SHARE_FRIEND,
      page: () => ShareFriendPage(),
      binding: ShareFriendBinding(),
    ),
    GetPage(
      name: YOUR_ABILITIES,
      page: () => YourAbilitiesPage(),
      binding: YourAbilitiesBinding(),
    ),
    GetPage(
      name: DETAIL_ABILITIES,
      page: () => DetailAbilitiesPage(),
      binding: DetailAbilitiesBinding(),
    ),
    GetPage(
      name: QUIZZ,
      page: () => QuizzPage(),
      binding: QuizzBinding(),
    ),
    GetPage(
      name: EXAM_RESULT,
      page: () => ExamResultPage(),
      binding: ExamResultBinding(),
    ),
  ];
}
