import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/geocode/distance_request.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/product/product_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/hive_box.dart';
import 'package:template/main.dart';
import 'package:template/provider/geo_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/utils/Loading_state.dart';
import 'package:template/utils/color_resources.dart';
import '../../../di_container.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../routes/route_path/home_routes.dart';
import '../../../routes/route_path/order_routes.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../components/cart_bottom_sheet.dart';
import '../components/product_bottom_sheet.dart';
import 'components/scroll_controller_for_animation.dart';

class StoreController extends GetxController
    with
        StateMixin<Map<String, List<ProductResponse>>>,
        LoadingState,
        SingleGetTickerProviderMixin {
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final GeoProvider geoProvider = GetIt.I.get<GeoProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  final RefreshController refreshController = RefreshController();
  RxMap<String, List<ProductResponse>> productsMap =
      <String, List<ProductResponse>>{}.obs;
  //Scroll animated
  ScrollController? scrollController;
  AnimationController? hideFabAnimController;

  RxList<OrderProduct> orderProductList = <OrderProduct>[].obs;
  OrderRequest? orderRequest;
  RxString distance = ''.obs;

  Box<OrderRequest>? orderBox;

  //variable
  int limit = 5;
  int page = 1;
  String idUser = '';
  UserResponse? store;
  int saled = 0;
  RxInt totalSaled = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      store = arg['store'] as UserResponse;
      countProductsOfStore();
    }

    idUser = sl<SharedPreferenceHelper>().getProfile;
    initOrderBox();
    _getCurrentLocation();
    getProduct(isRefresh: true);
    _initScroll();
  }

  ///
  /// init order box
  ///
  Future<void> initOrderBox() async {
    orderBox = await HiveBox<OrderRequest>().getOpenBox(HiveBox.ORDER_BOX_NAME);
    if (orderBox != null) {
      final data = orderBox!.get('${store!.id}$idUser');
      if (data != null) {
        orderRequest = data;

        if (orderRequest != null ||
            IZIValidate.nullOrEmpty(orderRequest!.idProducts)) {
          orderProductList.clear();
          orderProductList.value = orderRequest!.idProducts ?? [];
        }
      }
    }
  }

  void _initScroll() {
    hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );

    scrollController = useScrollControllerForAnimation(hideFabAnimController!);
  }

  ///
  /// Thêm sản phẩm giỏ hàng
  ///
  void onAddProduct(BuildContext context, {required ProductResponse product}) {
    showModelBottomSheetAddProduct(context, product: product);
  }

  ///
  /// on go to rating store
  ///
  void onGoToRatingStore() {
    Get.toNamed(HomeRoutes.RATING_STORE, arguments: {
      'store': store,
    });
  }

  ///
  /// Get transport
  ///
  void getProduct({required bool isRefresh}) {
    if (isRefresh) {
      productsMap.clear();
      page = 1;
    } else {
      page++;
    }
    productProvider.paginate(
      page: page,
      limit: limit,
      filter:
          '&populate=idUser,idCategory,idGroup.idUser&isActive=true&idUser=${store!.id}&sort=-idGroup',
      onSuccess: (data) {
        print(data.length);
        for (int i = 0; i < data.length; i++) {
          if (productsMap.containsKey(data[i].idGroup!.name)) {
            productsMap[data[i].idGroup!.name.toString()]!.add(data[i]);
          } else {
            productsMap[data[i].idGroup!.name.toString()] = [];
            productsMap[data[i].idGroup!.name.toString()]!.add(data[i]);
          }
        }

        if (isRefresh) {
          refreshController.resetNoData();
          refreshController.refreshCompleted();
        } else {
          refreshController.loadComplete();
        }
        if (productsMap.isEmpty) {
          change(productsMap, status: RxStatus.empty());
        } else {
          change(productsMap, status: RxStatus.success());
        }
        update();
      },
      onError: (onError) {
        print("An error occurred while getting productsNearBy $onError");
      },
    );
  }

  ///
  /// loadmore
  ///
  void onLoading() {
    // change(null, status: RxStatus.loading());
    getProduct(isRefresh: false);
  }

  ///
  /// refresh
  ///
  void onRefresh() {
    change(null, status: RxStatus.loading());
    getProduct(isRefresh: true);
  }

  ///
  ///  Hiển thị bottom sheet thêm sản phẩm
  ///
  void showModelBottomSheetAddProduct(BuildContext context,
      {required ProductResponse product}) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            IZIDimensions.BLUR_RADIUS_4X,
          ),
          topRight: Radius.circular(
            IZIDimensions.BLUR_RADIUS_4X,
          ),
        ),
      ),
      backgroundColor: ColorResources.NEUTRALS_7,
      isScrollControlled: true,
      enableDrag: false,
      context: context,
      builder: (context) {
        return ProductBottomSheet(
          product: product,
          desription: product.description ?? '',
          image: product.thumbnail ?? '',
          name: product.name ?? '',
          numberOfSale: saled.toString(),
          onTap: (val) {
            Get.back();
            if (orderRequest == null ||
                IZIValidate.nullOrEmpty(orderRequest!.idProducts)) {
              orderRequest = val;
              orderRequest!.idUser = idUser;
              orderRequest!.idUserShop = product.idUser;
            } else {
              orderRequest!.totalPrice =
                  orderRequest!.totalPrice! + val.totalPrice!;
              orderRequest!.idUser = idUser;
              orderRequest!.idUserShop = product.idUser;
              orderRequest!.idProducts!.addAll(val.idProducts!);
            }
            orderProductList.value = [...orderRequest!.idProducts!];
          },
          optionsSize: product.optionsSize ?? [],
          optionsTopping: product.optionsTopping ?? [],
        );
      },
    );
  }

  ///
  /// Count the product
  ///
  void countProducts(BuildContext context, {required ProductResponse product}) {
    orderProvider.countTheProduct(
      id: product.id.toString(),
      onSuccess: (data) {
        saled = data;
        showModelBottomSheetAddProduct(context, product: product);
      },
      onError: (onError) {
        print("An error occurred while getting countTheProduct $onError");
      },
    );
  }

  ///
  /// Count products of store
  ///
  void countProductsOfStore() {
    orderProvider.countTheProductsOfStore(
      id: store!.id.toString(),
      onSuccess: (data) {
        totalSaled.value = data;
      },
      onError: (onError) {
        print("An error occurred while getting countTheProduct $onError");
      },
    );
  }

  ///
  ///  Hiển thị bottom sheet sản phẩm đã thêm
  ///
  void showModelBottomCart(BuildContext context) {
    if (store!.isGetOpen!) {
      orderProvider.paginateHistory(
          page: 1,
          limit: 10,
          filter:
              '&idUser=$idUser&status!=6&status!=7&status!=8&populate=idUser,idUserShop,idVoucher,idProducts.idProduct',
          onSuccess: (data) {
            if (data.isEmpty) {
              if (IZIValidate.nullOrEmpty(orderRequest) ||
                  IZIValidate.nullOrEmpty(orderRequest!.idProducts)) {
                IZIAlert.info(message: "Vui lòng thêm sản phẩm vào giỏ hàng");
                return;
              }
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      IZIDimensions.BLUR_RADIUS_4X,
                    ),
                    topRight: Radius.circular(
                      IZIDimensions.BLUR_RADIUS_4X,
                    ),
                  ),
                ),
                backgroundColor: ColorResources.NEUTRALS_7,
                isScrollControlled: true,
                enableDrag: false,
                context: context,
                builder: (context) {
                  return CartBottomSheet(
                    onClearCart: () {
                      onClearCart(isBack: true);
                    },
                    orderRequest: orderRequest!,
                    onUpdateCart: (index) {
                      orderRequest!.idProducts!.removeAt(index);
                      orderProductList.value = [...orderRequest!.idProducts!];
                      if (IZIValidate.nullOrEmpty(orderRequest!.idProducts)) {
                        Get.back();
                      }
                      return;
                    },
                    onTap: () {
                      Get.back();
                      orderRequest!.finalPrice = orderRequest!.totalPrice;
                      orderRequest!.promotionPrice = orderRequest!.totalPrice;
                      // orderBox!.delete('${store!.id}$idUser'.trim());
                      Get.toNamed(
                        OrderRoutes.ORDER,
                        arguments: {
                          'order': orderRequest,
                          'idStore': '${store!.id}$idUser'.trim(),
                        },
                      )?.then((value) async {
                        if (value == true) {
                          onClearCart(isBack: false);
                        }
                      });
                    },
                  );
                },
              );
            } else {
              IZIAlert.error(
                  message:
                      'Bạn đang có đơn hàng đang đặt, vui lòng hoàn thành đơn hàng trước khi đặt đơn mới');
            }
          },
          onError: (err) => print(err));
    } else {
      IZIAlert.info(
          message: 'Cửa hàng hiện đang đóng cửa, vui lòng đặt đơn lại sau.');
    }
  }

  ///
  /// Clear cart
  ///
  void onClearCart({required bool isBack}) {
    orderRequest = null;
    orderProductList.value = [];
    if (isBack) {
      Get.back();
    }
  }

  ///
  /// Get current
  ///
  Future<void> _getCurrentLocation() async {
    // final permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
    //   Geolocator.getCurrentPosition().then((Position position) {
    //     calulatorDistance(position);
    //   }).catchError((e) {
    //     print(e);
    //   });
    // } else {
    //   Geolocator.openLocationSettings();
    // }
    calulatorDistance(currentLocation!);
  }

  ///
  /// calulator distance
  ///
  void calulatorDistance(Position latLongStart) {
    final DistanceRequest distanceRequest = DistanceRequest();
    distanceRequest.latLongStart = Location(
        lat: latLongStart.latitude.toString(),
        long: latLongStart.longitude.toString());
    distanceRequest.endLatLong = [
      Location(lat: store!.latLong!.lat, long: store!.latLong!.long)
    ];
    geoProvider.getDistance(
      distance: distanceRequest,
      onSuccess: (data) {
        distance.value = data.distance.toString();
      },
      onError: (onError) {
        print('An error occurred while getting the distance $onError');
      },
    );
  }

  ///
  /// on back
  ///
  void onBack() {
    if (orderBox != null) {
      orderBox!.delete('${store!.id}$idUser'.trim());
      if (orderRequest != null) {
        orderBox!.put('${store!.id}$idUser'.trim(), orderRequest!);
        // đã lưu
      }
    }
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
    refreshController.dispose();
    scrollController?.dispose();
    hideFabAnimController?.dispose();
    productsMap.close();
    orderProductList.close();
    distance.close();
    totalSaled.close();
    // orderBox?.close();
    // listener.close();
  }
}
