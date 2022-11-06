import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_price.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/main.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/province_provider.dart';
import '../../../routes/route_path/home_routes.dart';
import '../../../utils/Loading_state.dart';

class SearchController extends GetxController with StateMixin<List<ProductResponse>>, LoadingState {
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final ProvinceProvider provinceProvider = GetIt.I.get<ProvinceProvider>();
  final CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();

  final RefreshController refreshController = RefreshController();
  RxList<ProductResponse> products = <ProductResponse>[].obs;
  RxList<ProvinceResponse> provinces = <ProvinceResponse>[].obs;
  RxList<CategoryResponse> categories = <CategoryResponse>[].obs;
  List<Map<String, double>> prices = [
    {
      'min': 0,
      'max': 100,
    },
    {
      'min': 100,
      'max': 200,
    },
    {
      'min': 200,
      'max': 300,
    },
  ];

  Map<int, String> sorts = {
    1: 'Gần nhất',
    2: 'Nổi bật',
  };

  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();

  // Position? currentLocation;

  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;
  Rx<CategoryResponse> category = CategoryResponse().obs;
  Rx<ProvinceResponse> province = ProvinceResponse().obs;
  int page = 1;
  int limit = 5;
  RxString term = ''.obs;
  RxInt sort = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      if (!IZIValidate.nullOrEmpty(arg['term'])) {
        term.value = arg['term'].toString();
      }
      if (!IZIValidate.nullOrEmpty(arg['sort'])) {
        sort.value = arg['sort'] as int;
      }
      if (!IZIValidate.nullOrEmpty(arg['group'])) {
        category.value = arg['group'] as CategoryResponse;
      }
    }
    // _getCurrentLocation();
    getProduct(isRefresh: true);

    getProvince();
    getAllCategores();
  }

  ///
  /// Loading
  ///
  void onLoading() {
    getProduct(isRefresh: false);
  }

  ///
  /// onRefresh
  ///
  void onRefresh() {
    change(null, status: RxStatus.loading());
    getProduct(isRefresh: true);
  }

  ///
  /// Get products
  ///
  void getProduct({required bool isRefresh}) {
    if (isRefresh) {
      products.clear();
      page = 1;
    } else {
      page++;
    }
    productProvider.search(
      page: page,
      limit: limit,
      filter: '&isActive=true${IZIValidate.nullOrEmpty(term) ? '' : '&keyword=${term.toLowerCase()}'}${getFilter()}',
      onSuccess: (data) async {
        products.addAll(data);
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        if (products.isEmpty) {
          change(products, status: RxStatus.empty());
        } else {
          change(products, status: RxStatus.success());
        }
      },
      onError: (onError) {
        print("An error occurred while getting productsNearBy $onError");
      },
    );
  }

  ///
  /// get province
  ///
  void getProvince() {
    provinceProvider.all(
      onSuccess: (provinces) {
        this.provinces.clear();
        this.provinces.addAll(provinces);
      },
      onError: (onError) {
        print("An error occurred while getting province $onError");
      },
    );
  }

  ///
  /// get all category
  ///
  void getAllCategores() {
    categoryProvider.all(
      onSuccess: (data) {
        categories.clear();
        categories.addAll(data);
        if (!IZIValidate.nullOrEmpty(category.value.id)) {
          category.value = data.firstWhere((e) => e.id.toString() == category.value.id.toString());
        }
      },
      onError: (onError) {
        print("An error occurred while getting the category $onError");
      },
    );
  }

  ///
  /// on change sort
  ///
  void onChangeSort(int position) {
    sort.value = position;
    onRefresh();
  }

  ///
  /// on change category
  ///
  void onChangeArea(ProvinceResponse province) {
    if (province.id == this.province.value.id) {
      this.province.value = ProvinceResponse();
    } else {
      this.province.value = province;
    }
  }

  ///
  /// on change price
  ///
  void onChangePrice(double min, double max) {
    // this.min.value = min * 1000;
    // this.max.value = max * 1000;
    if (min == this.min.value && max == this.max.value) {
      this.min.value = 0;
      this.max.value = 0;
    } else {
      this.min.value = min * 1000;
      this.max.value = max * 1000;
    }
  }

  ///
  /// on change category
  ///
  void onChangeCategory(CategoryResponse category) {
    if (category.id == this.category.value.id) {
      this.category.value = CategoryResponse();
    } else {
      this.category.value = category;
    }
  }

  ///
  /// get filter
  ///
  String getFilter() {
    String filter = '';
    if (min.value >= 0 && max.value > 0) {
      filter += '&startPrice=${min.value}&endPrice=${max.value}';
    }
    if (!IZIValidate.nullOrEmpty(category.value.id)) {
      filter += '&idCategory=${category.value.id}';
    }
    if (sort.value == 2) {
      filter += '&sort=-idUser.rankPoint';
    }
    if (!IZIValidate.nullOrEmpty(province.value.id)) {
      filter += '&idProvince=${province.value.id}';
    }
    filter += '&lat=${currentLocation!.latitude}&long=${currentLocation!.longitude}';

    print(filter);
    return filter;
  }

  ///
  /// Get current
  ///
  // Future<void> _getCurrentLocation() async {
  //   final permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
  //     Geolocator.getCurrentPosition().then((Position position) {
  //       currentLocation = position;
  //       getProduct(isRefresh: true);
  //     }).catchError((e) {
  //       print(e);
  //     });
  //   } else {
  //     Geolocator.openLocationSettings();
  //   }
  // }

  ///
  /// show drawer
  ///
  void onShowDrawer(BuildContext context) {
    maxController.text = IZIPrice.currencyConverterVND(max.value);
    minController.text = IZIPrice.currencyConverterVND(min.value);
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeEndDrawer();
    } else {
      Scaffold.of(context).openEndDrawer();
    }
  }

  ///
  /// On tap food
  ///
  void onTapToStore(UserResponse store) {
    Get.toNamed(HomeRoutes.STORE, arguments: {
      'store': store,
    })?.then((value) {
      onRefresh();
    });
  }

  ///
  ///search term
  ///
  void onSearch() {
    getProduct(isRefresh: true);
  }

  ///
  /// clear filter
  ///
  void clearFilter(BuildContext context) {
    min.value = 0;
    max.value = 0;
    category.value = CategoryResponse();
    province.value = ProvinceResponse();
    Scaffold.of(context).closeEndDrawer();
    onRefresh();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    products.close();
    provinces.close();
    categories.close();
    minController.dispose();
    maxController.dispose();
    min.close();
    max.close();
    category.close();
    province.close();
    term.close();
    sort.close();
  }
}
