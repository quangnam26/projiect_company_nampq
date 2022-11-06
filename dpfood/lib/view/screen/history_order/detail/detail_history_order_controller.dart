import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/model/geocode/distance_request.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/model/order/order_history_response.dart';
import 'package:template/data/model/product/options/options_size.dart';
import 'package:template/data/model/product/options/options_topping.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/provider/geo_provider.dart';

import '../../../../routes/route_path/history_order.dart';

class DetailHistoryOrderController extends GetxController {
  Rx<OrderHistoryResponse> orderResponse = OrderHistoryResponse().obs;
  final GeoProvider geoProvider = GetIt.I.get<GeoProvider>();

  RxString distance = ''.obs;

  @override
  void onInit() {
    super.onInit();
    orderResponse.value = Get.arguments as OrderHistoryResponse;

    calulatorDistance(orderResponse.value.latLong!);

    update();
  }

  void onToReview() {
    Get.toNamed(HistoryOrderRoutes.REVIEWER, arguments: orderResponse.value);
  }

  ///
  ///onGetNameOptionSize
  ///
  String onGetNameOptionSize(List<OptionsSize> optionsSize) {
    String text = '';

    if (!IZIValidate.nullOrEmpty(optionsSize)) {
      text = 'Size: ';
      for (final item in optionsSize) {
        if (!IZIValidate.nullOrEmpty(item.size)) {
          text += '${item.size!} ,';
        }
      }
    }
    return text;
  }

  ///
  ///onGetNameOptionTopping
  ///
  String onGetNameOptionTopping(List<OptionsTopping> optionsTopping) {
    String text = '';

    if (!IZIValidate.nullOrEmpty(optionsTopping)) {
      text = 'Topping: ';
      for (final item in optionsTopping) {
        if (!IZIValidate.nullOrEmpty(item.topping)) {
          text += '${item.topping!} ,';
        }
      }
    }
    return text;
  }

  ///
  ///calulatorDistance
  ///
  void calulatorDistance(Location latLongStart) {
    final DistanceRequest distanceRequest = DistanceRequest();
    distanceRequest.latLongStart = Location(
        lat: latLongStart.startLat.toString(),
        long: latLongStart.startLong.toString());
    distanceRequest.endLatLong = [
      Location(lat: latLongStart.endLat, long: latLongStart.endLong)
    ];
    geoProvider.getDistance(
      distance: distanceRequest,
      onSuccess: (data) {
        distance.value = data.distance.toString();
        update();
      },
      onError: (onError) {
        print('An error occurred while getting the distance $onError');
      },
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
