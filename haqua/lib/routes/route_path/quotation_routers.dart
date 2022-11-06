import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:template/view/screen/my_question_list/my_question_list_binding.dart';
import 'package:template/view/screen/my_question_list/my_question_list_page.dart';
import 'package:template/view/screen/quotation_list/detail/detail_quotation_binding.dart';
import 'package:template/view/screen/quotation_list/quotation_list_binding.dart';
import 'package:template/view/screen/quotation_list/share/notify_share/notify_share_binding.dart';
import 'package:template/view/screen/quotation_list/share/notify_share/notify_share_page.dart';
import 'package:template/view/screen/quotation_list/detail/detail_quotation_item_page.dart';
import 'package:template/view/screen/quotation_list/quotationed_list_page.dart';
import 'package:template/view/screen/quotation_list/share/request_share/request_share_binding.dart';
import 'package:template/view/screen/quotation_list/share/request_share/request_share_page.dart';

// ignore: avoid_classes_with_only_static_members
class QuotationRoutes {
  static const String QUOTATION = '/quotation';
  static const String DETAILQUOTATIONITEM = '/detailquotationItem';
  static const String MY_QUESTION_LIST = '/my_question_list';
  static const String REQUESTSHARE = '/requestShare';
  static const String NOTIFYSHARE = '/notfyShare';

  static List<GetPage> list = [
    GetPage(
      name: QUOTATION,
      page: () =>
          QuotationedListPage(), 
      binding: QuotationBinding(),
    ),
    GetPage(
      name: DETAILQUOTATIONITEM,
      page: () => DetailQuotationItemPage(),
      binding: DetailQuotationBinding(),
    ),
    GetPage(
      name: REQUESTSHARE,
      page: () => RequestSharePage(),
      binding: RequestShareBinding(),
    ),
    GetPage(
      name: NOTIFYSHARE,
      page: () => NotifySharePage(),
      binding: NotifyShareBinding(),
    ),
    GetPage(
      name: MY_QUESTION_LIST,
      page: () => MyQuestionListPage(),
      binding: MyQuestionListBinding(),
    ),
  ];
}
