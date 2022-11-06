import 'package:get/get.dart';
import 'package:template/view/screen/news/new_controller.dart';


class NewsBingding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(()=> NewsController(),);
  }
}