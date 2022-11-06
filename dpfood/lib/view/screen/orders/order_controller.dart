import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:template/base_widget/izi_loader_overlay.dart';
import 'package:template/data/model/geocode/distance_request.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/setting/setting_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/hive_box.dart';
import 'package:template/provider/geo_provider.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/product_provider.dart';
import 'package:template/provider/setting_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/provider/voucher_provider.dart';
import 'package:template/routes/route_path/order_routes.dart';
import 'package:template/utils/Loading_state.dart';
import '../../../data/model/transport/transport_response.dart';
import '../../../di_container.dart';
import '../../../sharedpref/shared_preference_helper.dart';

class OrderController extends GetxController
    with
        StateMixin<List<TransportResponse>>,
        LoadingState,
        SingleGetTickerProviderMixin {
  final GeoProvider geoProvider = GetIt.I.get<GeoProvider>();
  final SettingProvider settingProvider = GetIt.I.get<SettingProvider>();
  final VoucherProvider voucherProvider = GetIt.I.get<VoucherProvider>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final ProductProvider productProvider = GetIt.I.get<ProductProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  //List
  RxList<VoucherResponse> vouchers = <VoucherResponse>[].obs;
  Rx<VoucherResponse> voucher = VoucherResponse().obs;

  //variable
  String idUser = '';
  RxBool isExpan = false.obs;
  RxString distance = ''.obs;
  RxDouble distanceFee = 0.0.obs;

  // Response and request
  Rx<UserResponse> userResponse = UserResponse().obs;
  Rx<OrderRequest>? orderRequest;
  SettingResponse? setting;
  RxBool isLoading = true.obs;
  String note = '';
  RxInt payment = 0.obs;
  RxInt distanceValue = 0.obs;
  Box<OrderRequest>? orderBox;
  String idStore = '';
  bool isAdded = false;

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg != null) {
      orderRequest = (arg['order'] as OrderRequest).obs;
      orderRequest!.value.typePayment = payment.value.toString();
      idStore = arg['idStore'].toString().trim();
    }
    initBox();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    getCurrentUser();
    getVoucher();
  }

  Future<void> initBox() async {
    orderBox = await HiveBox<OrderRequest>().getOpenBox(HiveBox.ORDER_BOX_NAME);
  }

  ///
  /// expaned these are products
  ///
  void onExpaned() {
    isExpan.value = !isExpan.value;
  }

  ///
  /// get the logined account
  ///
  void getCurrentUser() {
    userProvider.find(
      id: idUser,
      onSuccess: (user) {
        if (!IZIValidate.nullOrEmpty(user)) {
          userResponse.value = user;
        }
        getSetting();
        // _getCurrentLocation();
      },
      onError: (onError) {
        print("An error occurred while get current user $onError");
      },
    );
  }

  ///
  /// Xem them coupons
  ///
  void onTapMoreCoupons() {
    Get.toNamed(OrderRoutes.COUPONS, arguments: {
      'totalPrice': IZIValidate.nullOrEmpty(orderRequest)
          ? 0
          : orderRequest!.value.totalPrice,
      'voucher': voucher
    })?.then(
      (value) {
        if (value != null) {
          // print('Value: $value');
          // onSelecteVoucher(value as VoucherResponse);
        }
      },
    );
  }

  // void checkActiveProducts() {
  //   for (int i = 0; i < orderRequest!.value.idProducts!.length; i++) {
  //     productProvider.find(
  //       id: orderRequest!.value.idProducts![i].idProduct!.id.toString(),
  //       onSuccess: (data) {
  //         if (data.isActive == null || data.isActive == false) {
  //           IZIAlert.error(message: "Sản phẩm ${orderRequest!.value.idProducts![i].idProduct!.name} đã hết");
  //           return;
  //         }
  //       },
  //       onError: (onError) {
  //         print('Error: $onError');
  //       },
  //     );
  //   }
  // }

  ///
  /// on payment
  ///
  void onPayment() {
    if (payment.value == 0 &&
        (IZINumber.parseInt(orderRequest!.value.finalPrice) >
            userResponse.value.defaultAccount!)) {
      IZIAlert.error(
          message:
              'Số tiền trong ví không đủ. Vui lòng nạp thêm tiền hoặc chọn thanh toán khi nhận hàng');
      return;
    }
    orderRequest!.value.description = note;
    orderRequest!.value.distances = distanceValue.value;
    orderProvider.add(
      data: orderRequest!.value,
      onSuccess: (order) {
        if (orderBox != null) {
          orderBox!.delete(idStore.trim());
          orderBox!.put(idStore, OrderRequest());
        }
        Get.toNamed(
          OrderRoutes.STATUS_ORDER,
          arguments: {
            'idOrder': order.id,
          },
        )?.then((value) {
          Get.back(result: true);
        });
      },
      onError: (onError) {
        print("An error occurred while adding the order $onError ");
      },
    );
  }

  ///
  /// Toppings
  ///
  String getToppings({required OrderProduct orderProduct}) {
    String toppings = '';
    print(orderProduct.optionsSize?.toJson());
    if (!IZIValidate.nullOrEmpty(orderProduct.optionsSize)) {
      toppings = !IZIValidate.nullOrEmpty(orderProduct.optionsTopping) ? 'Size ${orderProduct.optionsSize!.size},' : 'Size ${orderProduct.optionsSize!.size}';
    }
    if (!IZIValidate.nullOrEmpty(orderProduct.optionsTopping)) {
      final dataSet = orderProduct.optionsTopping!.map((e) => e.topping).toSet();
      toppings += dataSet.fold<String>('', (val, e) {
        final amount = orderProduct.optionsTopping?.where((element) => element.topping.toString().contains(e.toString())).length;
        return val += (amount!) > 1 ? ',x$amount $e' : ',$e';
      }).replaceFirst(',', '');
    }

    return toppings;
  }

  ///
  /// Change a payment
  ///
  void changePayment(int val) {
    payment.value = val;
    orderRequest!.value.typePayment = val.toString();
    onSetMoney(0);
  }

  ///
  /// to change address
  ///
  void toChangeAddress() {
    Get.toNamed(OrderRoutes.ADDRESS_ORDER,
        arguments: {'name': userResponse.value.address ?? ''})?.then((val) {
      getCurrentUser();
    });
  }

  ///
  /// Tính số lượng sản phẩm
  ///
  int calculatorFood(OrderRequest order) {
    int amount = 0;
    if (!IZIValidate.nullOrEmpty(order.idProducts)) {
      for (final OrderProduct element in order.idProducts!) {
        amount += element.amount ?? 0;
      }
    }
    return amount;
  }

  ///
  /// Get current
  ///
  Future<void> _getCurrentLocation() async {
    if (isLoading.isTrue) {
      onShowLoaderOverlay();
    }
    // get Delivery address
    final location = await geoProvider.getGeocoderFromAddress(
      address: userResponse.value.address.toString(),
    );

    calulatorDistance(
      lat: location!.lat.toString(),
      long: location.lng.toString(),
    );
  }

  ///
  /// calulator distance
  ///
  void calulatorDistance({required String lat, required String long}) {
    final DistanceRequest distanceRequest = DistanceRequest();
    final Location location = Location();
    // Ví trí shop
    location.startLat = orderRequest!.value.idUserShop!.latLong!.lat;
    location.startLong = orderRequest!.value.idUserShop!.latLong!.long;
    // Vị trí của bạn
    location.endLat = lat;
    location.endLong = long;
    orderRequest!.value.latLong = location;

    distanceRequest.latLongStart = Location(lat: lat, long: long);
    distanceRequest.endLatLong = [
      Location(
          lat: orderRequest!.value.idUserShop!.latLong!.lat,
          long: orderRequest!.value.idUserShop!.latLong!.long)
    ];
    print("Geocoder: ${distanceRequest.toJson()}");
    geoProvider.getDistance(
      distance: distanceRequest,
      onSuccess: (data) {
        distance.value = data.distance.toString();
        distance.refresh();
        if (data.distanceValue != null) {
          distanceValue.value = data.distanceValue!;
          final km = IZINumber.parseInt(data.distanceValue) / 1000;
          if (km < (setting!.km! + 1)) {
            distanceFee.value = setting?.distanceFarFee ?? 0; //16000;
          } else if (km > setting!.km!) {
            distanceFee.value = (setting?.distanceFarFee ?? 0) +
                ((km - setting!.km!) * (setting!.distanceFarFee ?? 1));
          }
        }

        //distanceFee.value = IZINumber.parseDouble(setting!.distanceFee) * (data.distanceValue! / 1000);
        orderRequest!.value.shipPrice = distanceFee.value;
        distanceFee.refresh();
        onSetMoney(0);
        isLoading.value = false;
        update();
      },
      onError: (onError) {
        print('An error occurred while getting the distance $onError');
      },
    );
  }

  ///
  /// get setting
  ///
  void getSetting() {
    settingProvider.all(
      onSuccess: (data) {
        if (data.isNotEmpty) {
          setting = data.first;
          _getCurrentLocation();
        }
      },
      onError: (onError) {
        print("An error occurred while getting the setting $onError");
      },
    );
  }

  ///
  /// on select voucher
  ///
  void onSelecteVoucher(VoucherResponse voucher) {
    print("Ha; ${this.voucher.value.id == voucher.id}");
    if (this.voucher.value.id == voucher.id) {
      this.voucher.value = VoucherResponse();
      onSetMoney(0);
      orderRequest!.value.idVoucher = null;
    } else {
      print('Update');
      this.voucher.value = voucher;
      orderRequest!.value.idVoucher = voucher.id;
      onSetMoney(voucher.discountMoney!);
    }
  }

  ///
  /// set money
  ///
  void onSetMoney(double promotion) {
    // orderRequest!.value.promotionPrice = distanceFee.value +
    //     IZINumber.parseDouble(orderRequest!.value.totalPrice);
    orderRequest!.value.promotionPrice = promotion;
    orderRequest!.value.finalPrice =
        (distanceFee.value + orderRequest!.value.totalPrice!) - promotion;
    if (IZINumber.parseDouble(orderRequest!.value.finalPrice) > 1000000 &&
        orderRequest!.value.typePayment == '1') {
      if (isAdded == false) {
        distanceFee.value += setting!.codFee ?? 0;
        isAdded = true;
      }
    } else {
      if (isAdded) {
        distanceFee.value -= setting!.codFee ?? 0;
        isAdded = false;
      }
    }
    orderRequest!.value.finalPrice =
        (distanceFee.value + orderRequest!.value.totalPrice!) - promotion;
  }

  ///
  /// Voucher
  ///
  void getVoucher() {
    voucherProvider.paginate(
      page: 1,
      limit: 5,
      filter:
          '&populate=idUser,idCategory,idUserShop&filter={"\$and":[{"\$or":[{"voucherOfUser":"$idUser"},{"voucherType":0}]},{"userUsed":{"\$nin":["$idUser"]}}]}&toDate>=${DateTime.now().millisecondsSinceEpoch}', //{"\$or":[{"voucherOfUser":"$idUser"},{"voucherType":0}]}&limit>=1&isEnable=true', //&toDate>=${DateTime.now().millisecondsSinceEpoch}
      onSuccess: (data) {
        vouchers.clear();
        vouchers.addAll(data);
      },
      onError: (onError) {
        print("An error occurred while get voucher $onError");
      },
    );
  }

  @override
  void onClose() {
    distance.close();
    vouchers.close();
    voucher.close();
    distanceFee.close();
    userResponse.close();
    orderRequest?.close();
    // orderBox?.close();
    super.onClose();
  }
}
