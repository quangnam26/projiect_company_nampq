import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/accounts/account_binding.dart';
import '../../view/screen/accounts/account_page.dart';
import '../../view/screen/accounts/personalInformation/personal_Information_bingding.dart';
import '../../view/screen/accounts/personalInformation/personal_Information_page.dart';
import '../../view/screen/accounts/personalinformation/inputpersonalinformation/input_personal_information_bingding.dart';
import '../../view/screen/accounts/personalinformation/inputpersonalinformation/input_personal_information_page.dart';
import '../../view/screen/wallet_money/recharge/recharge_binding.dart';
import '../../view/screen/wallet_money/recharge/recharge_page.dart';

// ignore: avoid_classes_with_only_static_members
class AccountRoutes {
  static const String ACCOUNT = '/account';
  static const String TERMS_AND_POLICY = '/terms_and_policy';
  static const String PERSONAL_INFORMATION = '/personal_information';
  static const String INPUT_PERSONAL_INFORMATION =
      '/input_personal_information';
  static const String WALLET_MONEY = '/wallet_money';
  static const String RECHARGE = '/recharge';
  static const String CONSULTATION_CALL_CENTER = '/ConsultationCallCenter';

  static List<GetPage> list = [
    GetPage(
      name: ACCOUNT,
      page: () => AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: PERSONAL_INFORMATION,
      page: () => PersonalInformationPage(),
      binding: PersonalInformationBingding(),
    ),
    GetPage(
      name: INPUT_PERSONAL_INFORMATION,
      page: () => InputPersonalInformationPage(),
      binding: InputPersonalInformationBingDing(),
    ),

    //   GetPage(
    //   name: WALLET_MONEY,
    //   page: () => WalletMoneyPage(),
    //   binding: WalletMoneyBinding(),
    // ),
    GetPage(
      name: RECHARGE,
      page: () => ReChargePage(),
      binding: ReChargeBinding(),
    ),

  ];
}
