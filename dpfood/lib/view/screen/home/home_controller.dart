import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/banner/banner_response.dart';
import 'package:template/data/model/category/category_response.dart';
import 'package:template/data/model/order/order_history_response.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/order/order_response.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/main.dart';
import 'package:template/provider/banner_provider.dart';
import 'package:template/provider/category_provider.dart';
import 'package:template/provider/geo_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/routes/route_path/order_routes.dart';
import 'package:template/routes/route_path/personal_routers.dart';
import '../../../di_container.dart';
import '../../../routes/route_path/home_routes.dart';
import '../../../routes/route_path/notification_routers.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class HomeController extends GetxController {
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final CategoryProvider categoryProvider = GetIt.I.get<CategoryProvider>();
  final BannerProvider bannerProvider = GetIt.I.get<BannerProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final GeoProvider geoProvider = GetIt.I.get<GeoProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  final RefreshController refreshController = RefreshController();
  final RefreshController refreshControllerTop = RefreshController();

  OrderHistoryResponse orderResponse = OrderHistoryResponse();

  //List
  RxList<CategoryResponse> categories = <CategoryResponse>[].obs;
  RxList<ProductResponse> productsNearBy = <ProductResponse>[].obs;
  RxList<UserResponse> storeHot = <UserResponse>[].obs;
  RxList<BannerResponse> banners = <BannerResponse>[].obs;

  ///
  /// Categories
  ///
  // List<Map<String, dynamic>> categories = [
  //   {
  //     'title': 'Cơm',
  //     'icon': ImagesPath.rice,
  //     'bg': ColorResources.PRIMARY_1,
  //   },
  //   {
  //     'title': 'Bún/Phở',
  //     'icon': ImagesPath.noodle,
  //     'bg': ColorResources.PRIMARY_3,
  //   },
  //   {
  //     'title': 'Đồ uống',
  //     'icon': ImagesPath.drink,
  //     'bg': ColorResources.PINK,
  //   },
  //   {
  //     'title': 'Ăn vặt',
  //     'icon': ImagesPath.snacks,
  //     'bg': ColorResources.MY_ORDER_LABEL,
  //   },
  //   {
  //     'title': 'Đồ ăn nhanh',
  //     'icon': ImagesPath.fastfood,
  //     'bg': ColorResources.RED,
  //   },
  //   {
  //     'title': 'Đặc sản',
  //     'icon': ImagesPath.soup,
  //     'bg': ColorResources.GREEN,
  //   },
  //   {
  //     'title': 'Trà sữa',
  //     'icon': ImagesPath.milktea,
  //     'bg': ColorResources.PINK,
  //   },
  // ];

  //variable
  int limit = 7;
  int page = 1;
  Rx<UserResponse> currentUser = UserResponse().obs;
  RxString searchTerm = ''.obs;
  RxString addressCurrrent = ''.obs;
  String? idUser;
  bool isCheckOrder = false;
  bool isLoading = true;

  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getAccount();
    // getAllBanner();
    // getAllCategores();
    // getProduct(isRefresh: true);
    // getStores(isRefresh: true);
    // getCurrentPosition();
    // onCheckOrderCurrent();
  }

  ///
  ///onCheckOrderCurrent
  ///
  void onCheckOrderCurrent() {
    orderProvider.paginateHistory(
        page: 1,
        limit: 1,
        filter:
            '&idUser=$idUser&status!=6&status!=7&status!=8&populate=idUser,idUserShop,idVoucher,idProducts.idProduct',
        onSuccess: (data) {
          if (data.isNotEmpty) {
            orderResponse = data.first;
            isCheckOrder = true;
            isLoading = false;
            update();
          } else {
            isCheckOrder = false;
            isLoading = false;
            update();
          }
        },
        onError: (error) {
          isCheckOrder = false;
          isLoading = false;
          update();
          print(error);
        });
  }

  ///
  /// Get products
  ///
  void getProduct({required bool isRefresh}) {
    if (isRefresh) {
      productsNearBy.clear();
      page = 1;
    } else {
      page++;
    }
    productProvider.search(
      page: page,
      limit: limit,
      filter:
          '&lat=${currentLocation!.latitude}&long=${currentLocation!.longitude}', //'&populate=idUser,idCategory,idGroup.idUser&isActive=true',
      onSuccess: (data) {
        productsNearBy.addAll(data);

        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        getStores(isRefresh: true);
      },
      onError: (onError) {
        print("An error occurred while getting productsNearBy $onError");
      },
    );
  }

  Future<void> getCurrentPosition() async {
    final String? address = await geoProvider.getAddressFromLocation(
        location: '${currentLocation!.latitude},${currentLocation!.longitude}');
    addressCurrrent.value = address.toString();
    onCheckOrderCurrent();
  }

  ///
  /// Get stores
  ///
  void getStores({required bool isRefresh}) {
    if (isRefresh) {
      storeHot.clear();
      page = 1;
    } else {
      page++;
    }
    userProvider.paginate(
      page: page,
      limit: limit,
      filter: '&sort=-rankPoint', //'&isHot=true',
      onSuccess: (data) {
        storeHot.addAll(data);
        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
      },
      onError: (onError) {
        print("An error occurred while getting productsNearBy $onError");
      },
    );
    getCurrentPosition();
  }

  ///
  /// get all banner
  ///
  void getAllBanner() {
    bannerProvider.paginate(
      limit: 50,
      page: 1,
      filter: '&isActive=true',
      onSuccess: (data) {
        banners.clear();
        banners.addAll(data);
      },
      onError: (onError) {
        print("An error occurred while getting the category $onError");
      },
    );
    getAllCategores();
  }

  ///
  /// get all category
  ///
  void getAllCategores() {
    categoryProvider.all(
      onSuccess: (data) {
        categories.clear();
        categories.addAll(data);
      },
      onError: (onError) {
        print("An error occurred while getting the category $onError");
      },
    );
    getProduct(isRefresh: true);
  }

  ///
  ///clear search
  ///
  void clearSearch() {
    searchTerm.value = '';
    getProduct(isRefresh: true);
    getStores(isRefresh: true);
  }

  ///
  ///get user
  ///
  void getAccount() {
    userProvider.find(
      id: sl<SharedPreferenceHelper>().getProfile,
      onSuccess: (data) {
        print(data);
        if (!IZIValidate.nullOrEmpty(data)) {
          currentUser.value = data;
        }
        update();
      },
      onError: (onError) {
        print("An error occurred while getting the user $onError");
      },
    );
    getAllBanner();
  }

  ///
  /// loading
  ///
  void onLoading({required bool store}) {
    if (store == true) {
      getStores(isRefresh: false);
    } else {
      getProduct(isRefresh: false);
    }
  }

  ///
  /// onRefesh
  ///
  void onRefresh() {
    getProduct(isRefresh: true);
  }

  ///
  /// On tap transport
  ///
  void onTapToStore({required UserResponse store}) {
    Get.toNamed(HomeRoutes.STORE, arguments: {
      'store': store,
    })?.then((value) {
      onRefresh();
      getStores(isRefresh: true);
      onCheckOrderCurrent();
    });
  }

  ///
  /// On tap onToAddressPage
  ///
  void onToAddressPage() {
    Get.toNamed(
      OrderRoutes.ADDRESS_ORDER,
    )?.then((value) {
      onRefresh();
      getStores(isRefresh: true);
      onCheckOrderCurrent();
    });
  }

  ///
  /// On tap onTapCategory
  ///
  void onTapCategory(CategoryResponse categoryResponse) {
    Get.toNamed(HomeRoutes.SEARCH, arguments: {
      'group': categoryResponse,
    })?.then((value) {
      onRefresh();
      getStores(isRefresh: true);
      onCheckOrderCurrent();
    });
  }

  ///
  /// Đi đến màn hình thông báo
  ///
  void onGoToNotification() {
    Get.toNamed(NotificationRoutes.NOTIFY)
        ?.then((value) => onCheckOrderCurrent());
  }

  ///
  /// Đi đến màn hình trạng thái đơn hàng
  ///
  void onToStatusOrder() {
    final text = orderResponse.distances! >= 1000
        ? '${(orderResponse.distances! / 1000).toStringAsFixed(2)} km'
        : '${orderResponse.distances} m';
    Get.toNamed(
      OrderRoutes.STATUS_ORDER,
      arguments: {
        'idOrder': orderResponse.id,
      },
    )?.then((value) => onCheckOrderCurrent());
  }

  ///
  /// Đi đến màn hình menu tài khoản
  ///
  void goToAccount() {
    Get.toNamed(PersonalRoutes.PERSONAL)
        ?.then((value) => onCheckOrderCurrent());
  }

  ///
  /// xem thêm and search
  ///
  void onToSearch(String value) {
    Get.toNamed(HomeRoutes.SEARCH, arguments: {
      'term': value,
    })?.then((value) {
      searchTerm.value = '';
      onCheckOrderCurrent();
    });
  }

  ///
  /// xem thêm and search
  ///
  void onToSeeMore(int value) {
    // 1 Gần đây
    // 2 Nổi bật
    Get.toNamed(HomeRoutes.SEARCH, arguments: {'sort': value})
        ?.then((value) => onCheckOrderCurrent());
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    refreshControllerTop.dispose();
    categories.close();
    productsNearBy.close();
    storeHot.close();
    banners.close();
    currentUser.close();
    searchTerm.close();
    addressCurrrent.close();
  }
}
