import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:template/data/model/order/order_history_response.dart';
import 'package:template/data/model/order/order_product/order_history_product.dart';
import 'package:template/data/model/order/order_product/order_product.dart';
import 'package:template/data/model/order/order_product/order_product_request.dart';
import 'package:template/data/model/order/order_request.dart';
import 'package:template/data/model/order/order_response.dart';
import 'package:template/data/model/socket_service/socket_service.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_alert.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/order_provider.dart';
import 'package:template/provider/user_provider.dart';
import 'package:template/utils/Loading_state.dart';
import 'package:template/utils/socket_service.dart';
import 'package:template/utils/subscribe_message_socket.dart';
import '../../../data/model/provider/provider.dart';
import '../../../data/model/transport/transport_response.dart';
import '../../../di_container.dart';
import '../../../helper/izi_dimensions.dart';
import '../../../sharedpref/shared_preference_helper.dart';
import '../../../utils/color_resources.dart';
import '../components/preview_order_bottom_sheet.dart';
import '../store/components/scroll_controller_for_animation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum StatusOrderEnum {
  START,
  DRIVER_ONCOMING,
  DELIVERING,
  DONE,
}

class StatusOrderController extends GetxController
    with
        StateMixin<List<TransportResponse>>,
        LoadingState,
        SingleGetTickerProviderMixin {
  final Provider provider = Provider();
  final IZISocket iZISocket = GetIt.I.get<IZISocket>();
  final UserProvider userProvider = GetIt.I.get<UserProvider>();
  final OrderProvider orderProvider = GetIt.I.get<OrderProvider>();

  UserResponse userResponseShipper = UserResponse();
  // final connection = GetIt.I<InternetConnection>();
  final RefreshController refreshController = RefreshController();
  ScrollController? scrollController;
  AnimationController? hideFabAnimController;

  RxInt processIndex = (-1).obs;
  RxBool isLoading = true.obs;

  List<Map<String, dynamic>> statusOrder = [
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.START,
      'title': "Xác nhận"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DRIVER_ONCOMING,
      'title': "Tài xế đang đến"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DELIVERING,
      'title': "Đang giao hàng"
    },
    {
      'icon': Icons.play_circle,
      'status': StatusOrderEnum.DONE,
      'title': "Đã đến nơi"
    },
  ];

  //List
  OrderHistoryResponse? orderResponse;
  VoucherResponse? voucher;

  //variable
  int limit = 7;
  int page = 1;
  String idUser = '';
  String distance = '';
  RxBool isExpan = false.obs;
  String? idUserShipper;
  String? idOrder;
  bool isFinish = false;
  int statusSocket = 0;

  @override
  void onInit() {
    super.onInit();
    idUser = sl<SharedPreferenceHelper>().getProfile;
    final arg = Get.arguments;
    if (arg != null) {
      idOrder = arg['idOrder'] as String;
      // voucher = arg['voucher'] as VoucherResponse;
      // distance = arg['distance'] as String;
      onGetDataOrder(idOrder!);
    }
    // onEventOrder();
    _initScroll();
    //socket
    onCheckSocket();
  }

  ///
  ///onGetDataOrder
  ///
  void onGetDataOrder(String idOrder) {
    orderProvider.paginateHistory(
        page: 1,
        limit: 1,
        filter:
            '&_id=$idOrder&populate=idUser,idUserShop,idVoucher,idProducts.idProduct',
        onSuccess: (data) {
          if (data.isNotEmpty) {
            orderResponse = data.first;
            print('orderResponse');
            print(orderResponse!.toJson());
            print(orderResponse!.idUserShipper);

            statusSocket = IZINumber.parseInt(orderResponse!.status);
            if (statusSocket == 1) {
              processIndex.value = 0;
            } else if (statusSocket == 2 || statusSocket == 3) {
              processIndex.value = 1;
            } else if (statusSocket == 4) {
              processIndex.value = 2;
            } else if (statusSocket == 5) {
              processIndex.value = 3;
            } else if (statusSocket == 6) {
              IZIAlert.success(message: 'Đã hoàn thành đơn hàng');
              isFinish = true;
              update();
            }

            if (statusSocket >= 1) {
              idUserShipper = orderResponse!.idUserShipper.toString();
              getDataUserShipper(idUserShipper!);
            }
            update();
            isLoading.value = false;
          }
          update();
        },
        onError: (err) => print(err));
  }

  ///
  ///onCheckSocket
  ///
  void onCheckSocket() {
    print(!iZISocket.socket.hasListeners('dpfood_socket'));
    if (!iZISocket.socket.hasListeners('dpfood_socket')) {
      iZISocket.socket.on('dpfood_socket', (data) {
        print('data socket');
        print(data);

        final idUserSocket = data['idUser'].toString();
        print('idUserSocket $idUserSocket $idUser');
        if (idUserSocket == idUser) {
          statusSocket = IZINumber.parseInt(data['status']);
          print('statusSocket $statusSocket');
          if (statusSocket == 1) {
            processIndex.value = 0;
            idUserShipper = data['idUserShipper'].toString();
            getDataUserShipper(idUserShipper!);
            update();
          } else if (statusSocket == 2 || statusSocket == 3) {
            processIndex.value = 1;
            update();
          } else if (statusSocket == 4) {
            processIndex.value = 2;
            update();
          } else if (statusSocket == 5) {
            processIndex.value = 3;
            update();
          } else if (statusSocket == 6) {
            IZIAlert.success(message: 'Đã hoàn thành đơn hàng');
            isFinish = true;
            update();
          } else if (statusSocket == 7) {
            IZIAlert.info(message: 'Đơn hàng đã bị huỷ');
            isFinish = true;
            update();
          }
        }
      });
    }
  }

  ///
  ///iZISocket
  ///
  void _initScroll() {
    hideFabAnimController = AnimationController(
      vsync: this,
      duration: kThemeAnimationDuration,
      value: 1, // initially visible
    );

    scrollController = useScrollControllerForAnimation(hideFabAnimController!);
  }

  ///
  ///getDataUserShipper
  ///
  void getDataUserShipper(String idUser) {
    userProvider.find(
        id: idUser,
        onSuccess: (data) {
          userResponseShipper = data;
          isLoading.value = false;
          update();
        },
        onError: (err) => print(err));
  }

  ///
  /// Tính số lượng sản phẩm
  ///
  int calculatorFood(OrderHistoryResponse order) {
    int amount = 0;
    if (!IZIValidate.nullOrEmpty(order.idProducts)) {
      for (final element in order.idProducts!) {
        amount += element.amount ?? 0;
      }
    }
    return amount;
  }

  ///
  /// Toppings
  ///
  String getToppings({required OrderHistoryProduct orderProduct}) {
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

  void onExpaned(BuildContext context) {
    final text = orderResponse!.distances! >= 1000
        ? '${(orderResponse!.distances! / 1000).toStringAsFixed(2)} km'
        : '${orderResponse!.distances} m';
    // isExpan.value = !isExpan.value;
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
        return PreviewOrderBottomSheet(
          orderRequest: orderResponse!,
          amount: calculatorFood(orderResponse!),
          distance: text,
          promotion: IZIValidate.nullOrEmpty(orderResponse!.promotionPrice)
              ? 0
              : orderResponse!.promotionPrice,
          name: orderResponse!.idUserShop!.fullName ?? '',
        );
      },
    );
  }

  void onBack() {
    Get.back(result: true);
  }

  @override
  void onClose() {
    super.onClose();
    isLoading.close();
    refreshController.dispose();
    scrollController?.dispose();
    hideFabAnimController?.dispose();
    isExpan.close();
    iZISocket.socket.off('dpfood_socket');
  }
}
