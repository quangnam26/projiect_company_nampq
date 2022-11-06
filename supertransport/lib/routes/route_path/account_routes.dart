import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../view/screen/account/update_account/update_account_binding.dart';
import '../../view/screen/account/update_account/update_account_page.dart';
import '../../view/screen/terms_and_policy/terms_and_policy_binding.dart';
import '../../view/screen/terms_and_policy/terms_and_policy_page.dart';
import '../../view/screen/trains/train_binding.dart';
import '../../view/screen/trains/train_page.dart';


// ignore: avoid_classes_with_only_static_members
class AccountRoutes {
  static const String UPDATE_ACCOUNT = '/update_account';
  static const String TRAIN = '/train';
  static const String TERMS_AND_POLICY = '/terms_and_policy';

  static List<GetPage> list = [
    GetPage(
      name: UPDATE_ACCOUNT,
      page: () => UpdateAccountPage(),
      binding: UpdateAccountBinding(),
    ),
    GetPage(
      name: TRAIN,
      page: () => TrainPage(),
      binding: TrainBinding(),
    ),
    GetPage(
      name: TERMS_AND_POLICY,
      page: () => TermsAndPolicyPage(),
      binding: TermsAndPolicyBinding(),
    ),
    
  ];
}
