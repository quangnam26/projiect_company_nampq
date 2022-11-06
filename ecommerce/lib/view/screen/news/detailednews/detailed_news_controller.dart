import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/news/news_response.dart';

import '../../../../helper/izi_validate.dart';
import '../../../../provider/news_provider.dart';

class DetailedNewController extends GetxController {
  // khai bao api
  final NewsProvider newsProvider = GetIt.I.get<NewsProvider>();
  NewsResponse newsResponse = NewsResponse();

  // valiable
  bool isloading = false;
  String? id;
  // final arg = Get.arguments;
  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments is String) {
        id = Get.arguments.toString();
      } else {
        Get.arguments as NewsResponse;
      }
    }
    super.onInit();
    // TODO: implement onInit
    _getdataNewTetailed();
  }

  ///
  ///GetdataNewTetailed
  ///
  void _getdataNewTetailed() {
    isloading = true;
    newsProvider.find(
      id: Get.arguments.toString(),
      onSuccess: (onSuccess) {
        newsResponse = onSuccess;
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            print("onSuccess11 $onSuccess");
            isloading = false;
            update();
          },
        );
      },
      onError: (onError) {
        print(onError);
      },
    );
  }
}
