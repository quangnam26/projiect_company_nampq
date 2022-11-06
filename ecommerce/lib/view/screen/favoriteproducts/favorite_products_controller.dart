import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/brand/brand_response.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/provider/brand_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/route_path/detail_page_router.dart';

import '../../../../di_container.dart';
import '../../../../helper/izi_validate.dart';
import '../../../../routes/route_path/Search_Results_Routes.dart';
import '../../../../sharedpref/shared_preference_helper.dart';

class FavoriteProductsController extends GetxController {
  // khai báo API
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  final BrandProvider brandProvider = GetIt.I.get<BrandProvider>();
  final RefreshController refreshController = RefreshController();

// valiable
  int page = 1;
  int limit = 10;
  String brand = '';
  String category = '';
  int? price1 = 0;
  String searchTerm = '';
  bool price = false;
  bool isShort = false;
  String userId = sl<SharedPreferenceHelper>().getProfile;

//List
  List<ProductResponse> listProducts = [];
  List<BrandResponse> listBrand = [];
  List<CategoryResponse> listResponse = [];
  ProductResponse productResponse = ProductResponse();

  ///
  /// OnInit
  ///
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _getDataSearchResults(isRefresh: true);
  }

  ///
  ///OnClose
  ///
  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  ///
  ///onRefresh
  ///
  void onRefreshData() {
    refreshController.resetNoData();
    _getDataSearchResults(isRefresh: true);
  }

  ///
  ///onLoading
  ///
  void onLoadingData() {
    _getDataSearchResults(isRefresh: false);
  }

  ///
  /// GetDataSearchResults
  ///
  void _getDataSearchResults({required bool isRefresh}) {
    if (isRefresh) {
      page = 1;
      listProducts.clear();
    } else {
      page++;
    }
    productProvider.paginate(
      page: page,
      limit: limit,
      filter: _getFilter(),
      onSuccess: (model) async {
        listProducts.addAll(model);
        print("model11 ${listProducts.length}");
        if (isRefresh) {
          Future.delayed(
            const Duration(milliseconds: 300),
            () {
              refreshController.resetNoData();
              refreshController.refreshCompleted();
              // làm mới dữ liệu
            },
          );
        } else {
          refreshController.loadNoData();
          refreshController.loadComplete();
          // đã load thanh công
        }

        print("model111 $model");
        // EasyLoading.dismiss();
        // isLoading = false;
        update();
      },
      onError: (onError) {
        print("erro11 $onError");

      },
    );
  }

  ///
  ///getIdUser
  ///
  void getIdUser(){
      
  }

  ///
  ///_GetFilter
  ///
  String _getFilter() {
    String filter = '';
    if (!IZIValidate.nullOrEmpty(userId)) {
      filter = '&favorites=$userId';
    }

    if (isShort == false) {
      filter = "&favorites=$userId&sort=-price";
    } else {
      filter = "&favorites=$userId&sort=price";
    }
    if (!IZIValidate.nullOrEmpty(searchTerm)) {
      filter = "&nameSearch=$searchTerm";
    }

    print("filter11 $filter");

    return filter;
  }

  ///
  ///OnPrice
  ///
  void onPrice() {
    _getDataSearchResults(isRefresh: true);
  }

  ///
  ///OnChangeIsSort
  ///
  void onChangeIsSort() {
    isShort = !isShort;
    onPrice();
    update();
  }

  ///
  ///OnTapProduct
  ///
  void onTapProduct({required ProductResponse product}) {
    Get.toNamed(DetailPageRoutes.DETAIL_PAGE, arguments: product);
  }

  ///
  ///SearchName
  ///
  void searchByName() {
    _getDataSearchResults(isRefresh: true);
  }

  ///
  ///onGoWithDraw
  ///
  void onGoWithDraw() {
    Get.toNamed(SearchResultsRoutes.SEARCH_FILTER)?.then((value) => {
          // if (value == true)
          //   {onGetDataWalletWithUser(isRefresh: true), onGetDataUserById()}
        });
  }
}
