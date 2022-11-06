import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/voucher/voucher_request.dart';

class VoucherReponsitory {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  VoucherReponsitory();

  ///
  /// Get all categorys
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/vouchers');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert bang-bang-cap to database
  ///
  Future<ApiResponse> add(VoucherRequest data) async {
    try {
      final response = await dioClient!.post('/vouchers', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
  // find
  //

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> update(VoucherRequest data, String id) async {
    try {
      final response = await dioClient!.put('/vouchers', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update bang-bang-cap to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/vouchers/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate categorys "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    //&idPronce= fdsafsadfs&fdfadf&fdafsdf&populate=
    try {
      String uri = '/vouchers/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/vouchers/paginate?page=$page&limit=$limit$filter';
      }

      print("voucherfilter $filter");

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find bang-bang-cap by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/vouchers/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  ///save voucher
  ///
  Future<ApiResponse> saveVoucher(VoucherRequest data) async {
    try {
      final response = await dioClient!
          .post('/vouchers/addVoucherForUser', data: data.toJson());
      print("aaaa $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
