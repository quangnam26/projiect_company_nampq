import 'package:get/get.dart';
import 'package:template/view/screen/chat/chat_bingding.dart';
import 'package:template/view/screen/chat/chat_page.dart';

// ignore: avoid_classes_with_only_static_members
class ChatRoutes {
  static const String CHAT = '/chat';


  static List<GetPage> list = [
    GetPage(
      name: CHAT,
      page: () => ChatPage(),
      binding: ChatBingding(),
    ),

  ];
}
