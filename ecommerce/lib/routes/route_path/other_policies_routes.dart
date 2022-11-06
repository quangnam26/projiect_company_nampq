// ignore: avoid_classes_with_only_static_members
import 'package:get/get.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20exchangepolicy/%20exchange_policy_bingding.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20exchangepolicy/%20exchange_policy_page.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20warrantypolicy/%20warranty_policy_bingding.dart';
import 'package:template/view/screen/accounts/otherpolicies/%20warrantypolicy/%20warranty_policy_page.dart';
import 'package:template/view/screen/accounts/otherpolicies/purchasepolicy/%20purchase_policy_bingding.dart';
import 'package:template/view/screen/accounts/otherpolicies/purchasepolicy/purchase_policy_page.dart';
import 'package:template/view/screen/accounts/otherpolicies/shippingpolicy/shipping_policy_bingding.dart';
import 'package:template/view/screen/accounts/otherpolicies/shoppingguide/shopping_guide_bingding.dart';
import 'package:template/view/screen/accounts/otherpolicies/shoppingguide/shopping_guide_page.dart';
import 'package:template/view/screen/accounts/otherpolicies/termsandpolicies/terms_and_policies_bingding.dart';
import 'package:template/view/screen/accounts/otherpolicies/tranferinformation/transfer_Information_page.dart';
import 'package:template/view/screen/accounts/otherpolicies/tranferinformation/transfer_information_bingding.dart';

import '../../view/screen/accounts/otherpolicies/other_policies_bingding.dart';
import '../../view/screen/accounts/otherpolicies/other_policies_page.dart';
import '../../view/screen/accounts/otherpolicies/shippingpolicy/shipping_policy_page.dart';
import '../../view/screen/accounts/otherpolicies/termsandpolicies/terms_and_policies_page.dart';


// ignore: avoid_classes_with_only_static_members
class OtherPoliciesRoutes {
  static const String OTHER_POLICIES = '/other_policies';
  static const String PURCHASE_POLICY = '/purchase_policy';
  static const String EXCHANGE_POLICY = '/exchange_policy';
  static const String WARRANTY_POLICY = '/warranty_policy';
  static const String SHOPPING_GUIDE = '/shopping_guide';
  static const String TERMS_AND_POLICIES = '/terms_and_policies';
    static const String TRANSFER_INFORMATION = '/transfer_information';
     static const String SHIPPING_POLICY = '/shipping_policy';
  static List<GetPage> list = [

    // cac chinh sach khac
    GetPage(
      name: OTHER_POLICIES,
      page: () => OtherPoliciesPage(),
      binding: OtherPoliciesBingding(),
    ),

    // chính sách mua hàng
    GetPage(
      name: PURCHASE_POLICY,
      page: () => PurchasePolicyPage(),
      binding: PurchasePolicyBingding(),
    ),

    //Chính sách đổi hàng
    GetPage(
      name: EXCHANGE_POLICY,
      page: () => ExchangePolicyPage(),
      binding: ExchangePolicyBingding(),
    ),

    // chính sách bảo hành
    GetPage(
      name: WARRANTY_POLICY,
      page: () => WarrantyPolicyPage(),
      binding: WarrantyPoliciesBingding(),
    ),
// huong dan mua hang
    GetPage(
      name: SHOPPING_GUIDE,
      page: () => ShoppingGuidePage(),
      binding: ShoppingGuideBingding(),
    ),
// dieu khoan va chinh sach
    GetPage(
      name: TERMS_AND_POLICIES,
      page: () => TermsAndPoliciesPage(),
      binding: TermsAndPoliciesBingding(),
    ),
//thong tin chuyen khoan

   GetPage(
      name: TRANSFER_INFORMATION,
      page: () => TransferInformationPage(),
      binding: TransferInformationBingding(),
    ),

     GetPage(
      name: SHIPPING_POLICY,
      page: () => ShippingPolicyPage(),
      binding: ShippingPolicyBingding(),
    ),

  ];
}
