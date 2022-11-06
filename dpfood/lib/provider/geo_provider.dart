import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/geocode/distance.dart';
import 'package:template/data/model/geocode/distance_request.dart';
import 'package:template/data/model/geocode/location.dart';
import 'package:template/data/repositories/geo_reponsitory.dart';

class GeoProvider {
  GeoRepository? repository = GetIt.I.get<GeoRepository>();

  GeoProvider();

  ///
  /// Get geocoder from address
  ///
  Future<Location?> getGeocoderFromAddress({
    required String address,
  }) async {
    final ApiResponse apiResponse = await repository!.getGeocoderFromAddress(address);
    try {
      final results = apiResponse.response.data['results'][0]['geometry']['location'] as Map<String, dynamic>;
      return Location.fromMap(results);
    } catch (e) {
      return throw e;
    }
  }
  ///
  /// Get get address from position
  ///
  Future<String?> getAddressFromLocation({
    required String location,
  }) async {
    final ApiResponse apiResponse = await repository!.getAddressFromLocation(location);
    try {
      final result = apiResponse.response.data['results'][0]['formatted_address'] as String;
      return result;
    } catch (e) {
      return throw e;
    }
  }


  Future<void> getDistance({
    required DistanceRequest distance,
    required Function(Distance distance) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.getDistance(distance);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      Map<String, dynamic> distanceData = {};
      final results = apiResponse.response.data['rows'] as List<dynamic>;
      if (results.isNotEmpty) {
        final val = results[0]['elements'] as List<dynamic>;
        if (val.isNotEmpty) {
          distanceData = val[0] as Map<String, dynamic>;
        }
      }
      onSuccess(Distance.fromMap(distanceData));
    } else {
      onError(apiResponse.error);
    }
  }
}
