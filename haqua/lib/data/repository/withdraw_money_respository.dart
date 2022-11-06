import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/user/user_request.dart';

class WithDrawMoneyRespository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  WithDrawMoneyRespository();

  //
  //get all subspecialize
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/users/withdraw-money');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add user-specializes to database
  ///
  Future<ApiResponse> add(UserRequest data) async {
    try {
      final response =
          await dioClient!.post('/users/withdraw-money', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update user-specializes to database
  ///
  // Future<ApiResponse> update(int money) async {
  //   try {
  //     final response =
  //         await dioClient!.put('/users/withdraw-money', data: 1000);
  //     print('object aa $response');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  Future<ApiResponse> update(Map<String, dynamic> money) async {
    try {
      final response =
          await dioClient!.put('/users/withdraw-money', data: money);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
