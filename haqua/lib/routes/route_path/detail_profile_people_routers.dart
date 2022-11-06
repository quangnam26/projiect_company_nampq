

import 'package:get/get.dart';
import 'package:template/view/screen/detail_profile_people/detail_profile_people_page.dart';
import 'package:template/view/screen/view_profile_user_created_ques/view_profile_user_created_ques_binding.dart';
import 'package:template/view/screen/view_profile_user_created_ques/view_profile_user_created_ques_page.dart';

import '../../view/screen/detail_profile_people/detail_profile_people_binding.dart';

class DetailProfilePeopleListRoutes {
  static const String DETAIL_PROFILE_PROPLE = '/detail_profile_people';
  static const String VIEW_PROFILE_USER_CREATED_QUES = '/view_profile_user_created_ques';

  static List<GetPage> list = [
    GetPage(
      name: DETAIL_PROFILE_PROPLE,
      page: () => DetailProfilePeoplePage(),
      binding: DetailProfilePeopleBinding(),
    ),
     GetPage(
      name: VIEW_PROFILE_USER_CREATED_QUES,
      page: () => ViewProfileUserCreatedQuesPage(),
      binding: ViewProfileUserCreatedQuesBinding(),
    ),
  ];
}