// ignore_for_file: use_setters_to_change_properties

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/banner/banner_response.dart';
import 'package:template/data/model/brand/brand_response.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/flash_sale/flash_sale_response.dart';
import 'package:template/data/model/notification/notification_reponse.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/di_container.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/banner_provider.dart';
import 'package:template/provider/brand_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/flash_sale_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/detail_page_router.dart';
import 'package:template/routes/route_path/search_results_routes.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';

import '../../../routes/route_path/category_routes.dart';

class HomeController extends GetxController {
  // refreshController
  final RefreshController refreshController = RefreshController();
  final RefreshController refreshControllerTop = RefreshController();
  // final RefreshController refreshControllerTop = RefreshController();
  // refreshController

  // các loại Provider
  UserProvider userProvider = GetIt.I.get<UserProvider>();

  CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  BrandProvider brandProvider = GetIt.I.get<BrandProvider>();
  BannerProvider bannerProvider = GetIt.I.get<BannerProvider>();
  FlashSaleProvider flashSaleProvider = GetIt.I.get<FlashSaleProvider>();
  ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  // các loại Provider

  // các loại List
  List<CategoryResponse> categoryResponseList = <CategoryResponse>[];
  List<BrandResponse> brandResponseList = <BrandResponse>[];
  List<BannerResponse> bannerList = <BannerResponse>[];
  List<FlashSaleResponse> flashSaleList = <FlashSaleResponse>[];
  List<ProductResponse> topSearchList = <ProductResponse>[];
  List<ProductResponse> lastestProductList = <ProductResponse>[];
  List<NotificationResponse> listNotifi = <NotificationResponse>[];
  ValueNotifier<ProductResponse> productResponse =
      ValueNotifier<ProductResponse>(ProductResponse());
  // các loạiList
  String iduser = sl<SharedPreferenceHelper>().getProfile;
  bool visibility = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration();
  String? hour;
  String? minute;
  String? seconds;
  String defaultAccount = '';
  RxString searchTerm = ''.obs;
  int? selectCategory;

  @override
  void onInit() {
    super.onInit();
    _getFiveBanner();
    _getDefaultAccount();
    _getAllFlashSale();
    _getTopSearch();
    _getAllCategorys();
    _getAllBrands();
    _getLatestProduct();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    refreshControllerTop.dispose();
    searchTerm.close();
  }

  ///
  ///getIdUser
  ///

  ///
  /// See more and search.
  ///
  void onToSearch(String value) {
    Get.toNamed(SearchResultsRoutes.SEARCH_RESULTS, arguments: {
      'term': value,
    })?.then((value) {
      searchTerm.value = '';
      // _onCheckOrderCurrent();
    });
  }

  ///
  ///get All Banner
  ///

  void _getFiveBanner() {
    bannerProvider.paginate(
      limit: 5,
      page: 1,
      filter: "",
      onSuccess: (data) {
        bannerList.clear();
        bannerList.addAll(data);
        for (final element in bannerList) {
          countdownTime(element.promotionCountdown);
        }
      },
      onError: (onError) {
        print("Error Banner List $onError");
      },
    );
  }

  ///
  ///get default account
  ///

  void _getDefaultAccount() {
    userProvider.find(
        id: sl<SharedPreferenceHelper>().getProfile,
        onSuccess: (UserResponse data) {
          defaultAccount = data.defaultAccount.toString();
        },
        onError: (onError) {
          print("Error Banner List $onError");
        });
  }

  ///
  ///get 5 Flash Sale
  ///

  void _getAllFlashSale() {
    flashSaleProvider.paginate(
        limit: 5,
        page: 1,
        filter: '&populate=product',
        onSuccess: (list) {
          flashSaleList = list
              .where((element) =>
                  element.productResponse != null &&
                  element.productResponse!.discountPercent != null)
              .toList();
        },
        onError: (err) {
          print("Error FlashSale List $err");
        });
  }

  void onRefesh() {
    _getFiveBanner();
    _getAllFlashSale();
    _getTopSearch();
  }

  ///
  ///get Top Search
  ///

  void _getTopSearch() {
    productProvider.paginate(
        limit: 10,
        page: 1,
        filter: "&sort=-ratePoint",
        onSuccess: (list) {
          topSearchList.clear();
          topSearchList.addAll(list);
          update();
        },
        onError: (err) {
          print("Error TopSearch List $err");
        });
  }

  ///
  /// get All Categorys
  ///

  void _getAllCategorys() {
    categoryProvider.all(
      onSuccess: (list) {
        categoryResponseList.addAll(list);
        update();
      },
      onError: (err) {
        print("Error Categorys List $err");
      },
    );
  }

  void ontapCate(int index) {
    selectCategory = index;
    update();
  }

  ///
  ///get All Brands
  ///

  void _getAllBrands() {
    brandProvider.all(onSuccess: (list) {
      brandResponseList = list;
      update();
    }, onError: (err) {
      print("Error Brands List $err");
    });
  }

  ///
  ///get Latest Product
  ///

  void _getLatestProduct() {
    productProvider.paginate(
        limit: 5,
        page: 1,
        filter: "",
        onSuccess: (list) {
          lastestProductList = list;
          // update();
        },
        onError: (err) {
          print("Error Latest Product List $err");
        });
  }

  ///
  /// show or Hide Visible
  ///
  void showHideVisibility() {
    visibility = !visibility;
    update();
  }

  ///
  /// countdownTime
  ///

  void countdownTime(DateTime? dateFree) {
    countdownTimer = Timer.periodic(
        const Duration(seconds: 1), (_) => setCountDown(dateFree));
  }

  ///
  /// showHour
  ///

  String showHour(DateTime? dateFree, {DateTime? day}) {
    return (dateFree!.difference(day!).inSeconds ~/ (60 * 60) % 24)
        .toString()
        .padLeft(2, '0');
  }

  ///
  /// showMinute
  ///
  String showMinute(DateTime? dateFree, {DateTime? day}) {
    return ((dateFree!.difference(day!).inSeconds ~/ 60) % 60)
        .toString()
        .padLeft(2, '0');
  }

  ///
  /// showSecond
  ///
  String showSecond(DateTime? dateFree, {DateTime? day}) {
    return (dateFree!.difference(day!).inSeconds % 60)
        .toString()
        .padLeft(2, '0');
  }

  ///
  /// setCountDown
  ///

  void setCountDown(DateTime? dateFree, {DateTime? day}) {
    const reduceSecondsBy = 1;
    if (!IZIValidate.nullOrEmpty(day)) {
      if (dateFree != day!) {
        final seconds = myDuration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          countdownTimer!.cancel();
        } else {
          myDuration = Duration(seconds: seconds);
        }
      }
    }

    update();
  }

  ///
  /// OnGoToPage
  ///
  void onGotoPage(String page, {ProductResponse? obj}) {
    if (page == DetailPageRoutes.DETAIL_PAGE) {
      Get.toNamed(page, arguments: obj);
    }
    Get.toNamed(page);
  }

///
/// onTap Category
///
  void onTapCategory({required CategoryResponse categoryResponse}) {
    Get.toNamed(CategoryRoutes.CATEGORY, arguments: categoryResponse)?.then(
      (_) {
        // onRefreshData();
      },
    );
  }

  ///
  /// onTapBrand
  ///

    void onTapBrand({required BrandResponse brand}) {
    Get.toNamed(CategoryRoutes.BRANDS, arguments: brand)?.then(
      (_) {
        // onRefreshData();
      },
    );
  }

  ///
  /// get money have promote.
  ///
  double getMoneyHavePromote(ProductResponse productResponse) {
    return productResponse.price! -
        (productResponse.price! * (productResponse.discountPercent! / 100));
  }
}
