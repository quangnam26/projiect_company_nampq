// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/routes/route_path/Search_Results_Routes.dart';
import 'package:template/routes/route_path/detail_page_router.dart';
import 'package:template/routes/route_path/splash_routes.dart';
import '../../../data/model/brand/brand_response.dart';
import '../../../data/model/category/category_response.dart';
import '../../../helper/izi_validate.dart';
import '../../../provider/brand_provider.dart';
import '../../../provider/category_provider.dart';
import '../../../routes/route_path/detail_page_router.dart';

class SearchResultsController extends GetxController {
// khai bao api
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  RefreshController refreshController = RefreshController();
  ProductResponse productResponse = ProductResponse();

  // khai áo API
  final CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  final BrandProvider brandProvider = GetIt.I.get<BrandProvider>();

// List
  List<CategoryResponse> listCategoryResponse = [];
  List<BrandResponse> listBrandResponse = [];
  List<ProductResponse> listProducts = [];

  List<Map> tabbarStringList = [
    {"text": "Phổ biến", "flag": false},
    {"text": "Mới nhất", "flag": false},
    {"text": "Bán chạy", "flag": false},
    {"text": "Giá", "flag": true}
  ];

//valiable
  int page = 1;
  int limitPage = 10;
  bool isLoading = false;
  bool isload = false;
  int selected = 0;
  bool descTextShowFlag = true;

  RxString term = ''.obs;
  String brand = '';
  String category = '';
  String price1 = '';
  String price2 = '';
  String products = '';
  int? ratePoint;
  int? countSold;
  int currentIndexTabbar = 0;
  String filterProduct = '&sort=-countSold';
  String searchFilterValueReturn = "";
  int pageSearch = 1;
  int pageLimitSearch = 10;
  bool isSort = false;
  String searchController = "";
  int selectBrands = 0;
  bool descTextPortfolio = true;
  bool ickeckLoading = false;
  String idBrand = '';
  String idCategory = '';

  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
    ickeckLoading = true;
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        _getDataBrand();
        _getDataCategory();
        ickeckLoading = false;
      },
    );

    final arg = Get.arguments;
    if (arg != null) {
      if (!IZIValidate.nullOrEmpty(arg['term'])) {
        term.value = arg['term'].toString();
        searchController = term.value;
        onConfirmSearch();
      } else {
        callAPIFilterProduct(isRefresh: true);
      }
    } else {
      callAPIFilterProduct(isRefresh: true);
    }
    // getDataBrand();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
  }

  ///
  ///GetDataCategory
  ///
  void _getDataCategory() {
    categoryProvider.paginate(
      page: 1,
      limit: 10,
      filter: '',
      onSuccess: (onSuccess) {
        listCategoryResponse = onSuccess;
        print("listCate $onSuccess");
        update();
      },
      onError: (onError) {
        print("on Error category $onError");
      },
    );
  }

  ///
  /// getDataBrand
  ///
  void _getDataBrand() {
    brandProvider.paginate(
      page: page,
      limit: limitPage,
      filter: '',
      onSuccess: (model) {
        listBrandResponse = model;
        update();
      },
      onError: (onError) {
        print("brandProvider $onError");
      },
    );
  }

  ///
  /// selec color
  ///
  void selecColorProducts(int index) {
    selected = index;
    idCategory = listCategoryResponse[index].id ?? "";
    print("id ${idCategory}");
    update();
  }

  ///
  ///
  ///
  void moreProductPortfolio() {
    descTextPortfolio = !descTextPortfolio;
    update();
  }

  ///
  ///
  ///
  void selecColorBrand(int index) {
    selectBrands = index;
    idBrand = listBrandResponse[index].id ?? "";
    print("object ${idBrand}");
    update();
  }

  ///
  /// moreProductPortfolio
  ///
  void moreProductBrands() {
    descTextShowFlag = !descTextShowFlag;
    update();
  }

  ///
  ///price3
  ///
  void priceOne(String val) {
    price2 = val;
    update();
  }

  ///
  ///price3
  ///
  void priceTwo(String val) {
    price1 = val;
    update();
  }

  ///
  /// Get data.
  ///
  void getdata() {
    productProvider.paginate(
      page: 1,
      limit: 10,
      filter: getDatafilter(),
      onSuccess: (onSuccess) {
        listProducts = onSuccess;
        update();
      },
      onError: (onError) {
        print(onError);
      },
    );
  }

  ///
  /// get Data filter.
  ///
  String getDatafilter() {
    String filter = '';
    if (double.parse(price1.replaceAll('.', "")) >= 0 &&
        double.parse(price2.toString().replaceAll('.', "")) >=
            double.parse(price1.toString().replaceAll('.', ""))) {
      filter =
          '&price>=${double.parse(price1.toString().replaceAll('.', ""))}&price<=${double.parse(price2.toString().replaceAll('.', ""))}';
    }
    return filter;
  }

  ///
  ///OnBack
  ///
  void onComeBack() {
    print("aar ${getDatafilter()}");
    if (price1 == '0' && price2 == '0') {
      Get.back(
        result: {
          'category': IZIValidate.nullOrEmpty(idCategory)
              ? listCategoryResponse[selected].id
              : idCategory,
          'brand': IZIValidate.nullOrEmpty(idBrand)
              ? listBrandResponse[selected].id
              : idBrand,
        },
      );
    } else {
      Get.back(
        result: {
          'category': IZIValidate.nullOrEmpty(idCategory)
              ? listCategoryResponse[selected].id
              : idCategory,
          'brand': IZIValidate.nullOrEmpty(idBrand)
              ? listBrandResponse[selected].id
              : idBrand,
          'price': getDatafilter(),
        },
      );
    }
  }

  void backToScreen() {
    callAPIFilterProduct(isRefresh: true);
    Get.back();
    //     isRefresh: true
  }

  void establish() {
    idBrand = "";
    idCategory = "";
    callAPIFilterProduct(isRefresh: true);
  }

  ///
  /// select Index Tabbar
  ///
  void selectIndexTabber(int index) {
    currentIndexTabbar = index;
    if (currentIndexTabbar == 3) {
      isSort = !isSort;
      update();
    }

    /// When on change tabbar then call API get data product again.
    callAPIFilterProduct(isRefresh: true);
    // update();
  }

  ///
  /// Generate filter search.
  ///
  String _generateFilterSearch() {
    if (!IZIValidate.nullOrEmpty(price1) && !IZIValidate.nullOrEmpty(price2)) {
      if (IZINumber.parseDouble(price1.toString().replaceAll('.', "")) >= 0 &&
          IZINumber.parseDouble(price2.toString().replaceAll('.', "")) >=
              IZINumber.parseDouble(price1.toString().replaceAll('.', ""))) {
        filterProduct =
            '&price>=${IZINumber.parseDouble(price1.toString().replaceAll('.', ""))}&price<=${IZINumber.parseDouble(price2.toString().replaceAll('.', ""))}';
      }
    }

    // // searchFilterValueReturn += "&category=${value['category']}";

    if (idBrand.isNotEmpty) {
      filterProduct += '&brand=$idBrand';
    }
    if (idCategory.isNotEmpty) {
      filterProduct += '&category=$idCategory';
    }
    if (currentIndexTabbar == 0) {
      filterProduct += "&sort=-countSold";
    }
    if (currentIndexTabbar == 1) {
      filterProduct += '&sort=-createdAt';
    }
    if (currentIndexTabbar == 2) {
      filterProduct += "&sort=-countSold";
    }
    if (currentIndexTabbar == 3) {
      if (isSort) {
        filterProduct += '&sort=price';
      } else {
        filterProduct += '&sort=-price';
      }
    }
    return filterProduct;
  }

//  void

  ///
  ///onRefresh
  ///
  void onRefreshData() {
    refreshController.resetNoData();
    callAPIFilterProduct(isRefresh: true);
  }

  ///
  ///onLoading
  ///
  void onLoadingData() {
    callAPIFilterProduct(isRefresh: false);
  }

  ///
  /// Call API get data product.
  ///
  void callAPIFilterProduct({required bool isRefresh}) {
    if (isRefresh) {
      pageSearch = 1;
      listProducts.clear();
    } else {
      pageSearch++;
    }
    productProvider.paginate(
      page: pageSearch,
      limit: pageLimitSearch,
      filter:
          "${_generateFilterSearch()}${IZIValidate.nullOrEmpty(searchController) ? "" : "&nameSearch=$searchController"}",
      onSuccess: (models) {
        print("model11 ${models.length}");
        // productResponse = listProducts.first;
        if (models.isEmpty) {
          refreshController.loadNoData();
        } else {
          if (isRefresh) {
            listProducts = models;
            refreshController.refreshCompleted();
          } else {
            listProducts = listProducts.toList() + models;
            refreshController.loadComplete();
          }
        }
        isLoading = false;

        update();
      },
      onError: (error) {
        print(error);
      },
    );
  }


  //   double getMoneyHavePromote() {
  //   return productResponse.price! -
  //       (productResponse.price! *
  //           (productResponse.value.discountPercent! / 100));
  // }

  ///
  /// On confirm search
  ///
  void onConfirmSearch() {
    /// When confirm search then we will have new data from textediting controller.
    /// Then generate fillter again.
    callAPIFilterProduct(isRefresh: true);
  }

  ///
  /// Go to [Filter page].
  ///
  // void goToFilterPage() {
  //   Get.toNamed(SearchResultsRoutes.SEARCH_FILTER)!.then((value) {
  //     searchFilterValueReturn = "";
  //     if (value != null) {
  //       searchFilterValueReturn += "&category=${value['category']}";
  //       searchFilterValueReturn += "&brand=${value['brand']}";
  //       searchFilterValueReturn += IZIValidate.nullOrEmpty(value['price'])
  //           ? ""
  //           : value['price'].toString();
  //       callAPIFilterProduct(isRefresh: true);
  //       update();
  //     }
  //   });
  // }

  ///
  /// detail.
  ///
  void onTapProduct({required ProductResponse proudct}) {
    Get.toNamed(DetailPageRoutes.DETAIL_PAGE, arguments: proudct)?.then(
      (_) {
        onRefreshData();
      },
    );
  }

  Future<void> gotohome() async {
    Get.offAllNamed(SplashRoutes.HOME);
  }

  // ///
  // ///formatGenMoney
  // ///
  // String fromatGenMoney({required String al}) {
  //   final int countMoneyLenght = listProducts.length;
  //   final double moneyFormat =
  //       IZINumber.parseDouble(productResponse.countRate!.toString());

  //   final List<String> untilMoney = ["", "Nghìn", "Triệu", "Tỷ", "Ngàn tỷ"];

  //   int postion = 0;
  //   double value = 0;
  //   if (countMoneyLenght <= 3) {
  //     return "đ ${IZIPrice.currencyConverterVND(double.parse(moneyFormat.toString()))}";
  //   } else if (countMoneyLenght <= 6) {
  //     postion = 1;
  //     value = moneyFormat / 1000;
  //     return '${value.toStringAsFixed(0)} ${untilMoney[postion]}';
  //   }

  //   return '${value.toStringAsFixed(0)} ${untilMoney[postion]}';
  // }
}
