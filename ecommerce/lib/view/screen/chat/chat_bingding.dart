

import 'package:get/get.dart';
import 'package:template/view/screen/chat/chat_controller.dart';


class ChatBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ChatController>(()=> ChatController());
  }
}