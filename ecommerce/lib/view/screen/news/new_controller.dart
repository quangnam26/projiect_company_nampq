import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/news/news_response.dart';
import 'package:template/data/model/newscategory/news_category_response.dart';
import 'package:template/provider/news_category_provider.dart';
import 'package:template/provider/news_provider.dart';
import 'package:template/provider/voucher_provider.dart';
import 'package:template/routes/route_path/news%20routes.dart';
import '../../../data/model/news/news_request.dart';
import '../../../helper/izi_validate.dart';

class NewsController extends GetxController {
// khai bao api
  final NewsProvider newsProvider = GetIt.I.get<NewsProvider>();
  final VoucherProvider voucherProvider = GetIt.I.get<VoucherProvider>();
  final NewsCategoryProvider newsCategoryProvider =
      GetIt.I.get<NewsCategoryProvider>();
  RefreshController refreshController = RefreshController();

  NewsCategoryResponse newsCategoryResponse = NewsCategoryResponse();
  NewsResponse newsResponse = NewsResponse();

// List
  List<NewsResponse> listNewsResponse = [];
  List<NewsCategoryResponse> listNewsCategoryResponse = [];
  NewsCategoryResponse newsCategoryResponse1 = NewsCategoryResponse();

// vaiable
  int page = 1;
  int limitPage = 10;
  int postion = 0;
  bool isloading = false;
  String filterProduct = '';

  @override
  void onInit() {
    super.onInit();
    Get.arguments;
    _getDataAllNews();

    // TODO: implement onInit
  }

  @override
  void onClose() {
    // TODO: implement onClose
    refreshController.dispose();
    super.onClose();
  }

  ///
  /// Get Data All News.
  ///
//get data tất cả của news về
  void _getDataAllNews() {
    isloading = true;
    newsCategoryProvider.all(
      onSuccess: (List<NewsCategoryResponse> model) {
        Future.delayed(
          const Duration(milliseconds: 200),
          () {
            listNewsCategoryResponse = model;
            _getDataNews(
                isRefresh: true, id: listNewsCategoryResponse[postion].id!);
            isloading = false;
            update();
          },
        );
      },
      onError: (onError) {
        print("onError $onError");
      },
    );
  }



  ///
  /// selecIndexTabbar
  ///
// nhấn để chuyển sang
  void selectIndexTabbar(int index) {
    postion = index;
    _getDataAllNews();
    update();
  }

  ///
  ///onLoading
  ///
  void onLoadingData(String id) {
    _getDataNews(isRefresh: false, id: id);
  }

  ///
  ///onRefresh
  ///
  void onRefreshData(String id) {
    refreshController.resetNoData();
    _getDataNews(isRefresh: true, id: id);
  }

  ///
  /// getDataNew
  ///
  //get data theo id
  void _getDataNews({required bool isRefresh, required String id}) {
    if (isRefresh) {
      page = 1;
      listNewsResponse.clear();
    } else {
      page++;
    }
    newsProvider.paginate(
      page: page,
      limit: 10,
      filter:
          '&populate=newsCategory${!IZIValidate.nullOrEmpty(id) ? '&newsCategory=$id' : ""}',
      onSuccess: (List<NewsResponse> model) {
     
        listNewsResponse.addAll(
          model.where((element) =>
              !IZIValidate.nullOrEmpty(element.newsCategory) &&
              element.newsCategory!.isShow == false),
        );
        // }
        // }
        update();

        if (isRefresh) {
          Future.delayed(const Duration(milliseconds: 300), () {
            refreshController.resetNoData(); // data đã làm mới lại
            refreshController.refreshCompleted(); // data đã hoàn thành
            // làm mới dữ liệu
          });
        } else {
          refreshController.loadNoData();
          refreshController.loadComplete();
          // đã load thanh công
        }
        // listNewsResponse.clear();
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// get Update View
  ///
  void getUpdateView(String id) {
    print("a111");
    final NewsRequest newsRequest = NewsRequest();
    newsRequest.numberView = newsResponse.numberView;

    newsProvider.update(
      data: newsRequest,
      onSuccess: (onSuccess) {
        print("a");
        // _getDataAllNews();
      },
      onError: (onError) {},
    );
  }

  ///
  ///GotoSDetailedNews
  ///
//chuyển sang màn hình detailed
  void gotoSDetailedNews(String? id) {
    Get.toNamed(NewsRouters.DETAILED_NEWS, arguments: id)!.then((value) {
      if (!IZIValidate.nullOrEmpty(value) && value == true) {
        getUpdateView(id!);
      }
    });
    //  Get.toNamed(NewsRouters.DETAILED_NEWS,arguments:id );
  }
}
