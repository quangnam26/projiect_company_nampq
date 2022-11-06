import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/geocode/distance_request.dart';
import 'package:template/utils/app_constants.dart';

class GeoRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();
  GeoRepository();

  ///
  /// Get geocoder from address
  ///
  Future<ApiResponse> getGeocoderFromAddress(String address) async {
    try {
      final response = await dioClient!.get('$GOONG_URL/geocode?address=$address&api_key=$GOONG_KEY');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  ///
  /// Get geocoder from address
  ///
  Future<ApiResponse> getAddressFromLocation(String location) async {
    try {
      final response = await dioClient!.get('$GOONG_URL/geocode?latlng=$location&api_key=$GOONG_KEY');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get Distance
  ///
  Future<ApiResponse> getDistance(DistanceRequest distance) async {
    try {
      print('JSON: ${distance.toMap()}');
      final response = await dioClient!.post('/users/distances',data: distance.toMap());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
