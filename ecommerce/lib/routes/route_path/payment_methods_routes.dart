import 'package:get/get.dart';
import 'package:template/view/screen/paymentmethods/addcreditcard/add_credit_card_bingding.dart';
import 'package:template/view/screen/paymentmethods/addcreditcard/add_credit_card_page.dart';
import 'package:template/view/screen/paymentmethods/domesticatmcard/domestic_atm_card_bingding.dart';
import 'package:template/view/screen/paymentmethods/domesticatmcard/domestic_atm_card_page.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_bingding.dart';
import 'package:template/view/screen/paymentmethods/payment_methods_page.dart';

// ignore: avoid_classes_with_only_static_members
class PaymentmethodsRoutes {
  static const String PAYMENT_METHODS = '/payment_methods';
  static const String DOMESTIC_ATM_CARD = '/domestic_atm_card';
    static const String ADD_CREDIT_CARD = '/add_credit_card';

  static List<GetPage> list = [
    GetPage(
      name: PAYMENT_METHODS,
      page: () => PaymentMethodsPage(),
      binding: PaymentmethodsBingding(),
    ),
    GetPage(
      name: DOMESTIC_ATM_CARD,
      page: () => DomestiAtmCardPage(),
      binding: DomestiAtmCardBingding(),
    ),
        GetPage(
      name: ADD_CREDIT_CARD,
      page: () => AddCreditCardPage(),
      binding: AddCreditCardBingding(),
    ),
  ];
}
