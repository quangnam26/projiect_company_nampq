import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/auth/auth_request.dart';
import 'package:template/data/model/auth/auth_response.dart';
import 'package:template/data/model/auth/login_request.dart';
import 'package:template/data/model/auth/otp_response.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/district/district_response.dart';
import 'package:template/data/model/district/district_resquest.dart';
import 'package:template/data/model/provider/url_constanst.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/transport/transport_resquest.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/model/vehicle/vehicle_response.dart';
import 'package:template/data/model/village/vilage_response.dart';
import 'package:template/data/model/village/vilage_resquest.dart';
import 'package:template/helper/izi_validate.dart';
import 'package:template/utils/app_constants.dart';
import '../images/image_response.dart';
import '../province/province_resquest.dart';
import '../transport/transport_response.dart';
import '../vehicle/vehicle_request.dart';

enum IZIMethod {
  GET,
  ADD,
  UPDATE,
  DELETE,
  PAGINATE,
  FIND,
}

class Provider<T> {
  final DioClient? dioClient = GetIt.I.get<DioClient>();

  dynamic getModel(dynamic typeModel, {required dynamic data}) {
    switch (typeModel.runtimeType) {
      case ImageResponse:
        return ImageResponse.fromMap(data as Map<String, dynamic>);
      case ProvinceResponse:
        return ProvinceResponse.fromMap(data as Map<String, dynamic>);
      case ProvinceRequest:
        return ProvinceRequest.fromMap(data as Map<String, dynamic>);
      case DistrictResponse:
        return DistrictResponse.fromMap(data as Map<String, dynamic>);
      case DistrictRequest:
        return DistrictRequest.fromMap(data as Map<String, dynamic>);
      case VillageRequest:
        return VillageRequest.fromMap(data as Map<String, dynamic>);
      case VillageResponse:
        return VillageResponse.fromMap(data as Map<String, dynamic>);
      case UserResponse:
        return UserResponse.fromMap(data as Map<String, dynamic>);
      case UserRequest:
        return UserRequest.fromMap(data as Map<String, dynamic>);
      case TransportResponse:
        return TransportResponse.fromMap(data as Map<String, dynamic>);
      case TransportRequest:
        return TransportRequest.fromMap(data as Map<String, dynamic>);
      case VehicleResponse:
        return VehicleResponse.fromMap(data as Map<String, dynamic>);
      case VehicleRequest:
        return VehicleRequest.fromMap(data as Map<String, dynamic>);
      case LoginRequest:
        return AuthResponse.fromMap(data as Map<String, dynamic>);
      case AuthRequest:
        return AuthResponse.fromMap(data as Map<String, dynamic>);
      case AuthResponse:
        return AuthResponse.fromMap(data as Map<String, dynamic>);
      case OTPResponse:
        return OTPResponse.fromMap(data as Map<String, dynamic>);
      default:
        return T;
    }
  }

  ///
  /// endPoint
  ///
  String getEndPoint(dynamic typeModel) {
    switch (typeModel.runtimeType) {
      case ImageResponse:
        return UPLOAD;
      case ProvinceResponse:
        return PROVINCES;
      case ProvinceRequest:
        return PROVINCES;
      case DistrictResponse:
        return DISTRICTS;
      case DistrictRequest:
        return DISTRICTS;
      case VillageRequest:
        return VILLAGES;
      case VillageResponse:
        return VILLAGES;
      case UserResponse:
        return USERS;
      case UserRequest:
        return USERS;
      case TransportResponse:
        return TRANSPORTS;
      case TransportRequest:
        return TRANSPORTS;
      case VehicleRequest:
        return VEHICLES;
      case VehicleResponse:
        return VEHICLES;
      case LoginRequest:
        return AUTH_LOGIN;
      case AuthRequest:
        return AUTH_SINGUP;
      case AuthResponse:
        return AUTH_LOGIN;
      case OTPResponse:
        return OTP;
      default:
        return LOGOUT;
    }
  }

  Future<void> call({
    required IZIMethod method,
    required T typeModel,
    String? endPoint,
    int? page = 1,
    int? limit = 10,
    String? filter = '',
    String? id = '',
    T? data,
    required Function(List<T> data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: method,
      endPoint: endPoint ?? getEndPoint(typeModel),
      page: page,
      limit: limit,
      filter: filter,
      id: id,
      data: data,
    );
    if (apiResponse.response.statusCode == null) {
      onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      List<dynamic> results = [];
      if (method == IZIMethod.PAGINATE) {
        results = apiResponse.response.data['results'] as List<dynamic>;
      } else {
        if (apiResponse.response.data.runtimeType == List) {
          results = apiResponse.response.data as List<dynamic>;
        } else {
          results = [apiResponse.response.data as Map<String, dynamic>];
        }
      }
      onSuccess(results.map((e) => getModel(typeModel, data: e)).toList().cast<T>());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get all data
  ///
  Future<void> all(
    T typeModel, {
    required Function(List<T> data) onSuccess,
    required Function(dynamic error) onError,
    String? endPoint,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.GET,
      endPoint: getEndPoint(typeModel) + (IZIValidate.nullOrEmpty(endPoint) ? '' : endPoint!),
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      List<dynamic> results = [];
      if (apiResponse.response.data.runtimeType == List) {
        results = apiResponse.response.data as List;
      } else {
        results = [apiResponse.response.data as Map<String, dynamic>];
      }
      onSuccess(results.map((e) => getModel(typeModel, data: e)).toList().cast<T>());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert
  ///
  Future<void> add(
    T typeModel, {
    required T requestBody,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
    String? endPoint,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.ADD,
      endPoint: getEndPoint(typeModel) + (IZIValidate.nullOrEmpty(endPoint) ? '' : endPoint!),
      data: requestBody,
    );
    if (IZIValidate.nullOrEmpty(apiResponse.response.statusCode)) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel, data: results) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update
  ///
  Future<void> update(
    T typeModel, {
    required String id,
    required T requestBody,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.UPDATE,
      endPoint: getEndPoint(typeModel),
      data: requestBody,
      id: id,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel, data: results) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete
  ///
  Future<void> delete(
    T typeModel, {
    required String id,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.DELETE,
      endPoint: getEndPoint(typeModel),
      id: id,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel, data: results) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate
  ///
  Future<void> paginate(
    T typeModel, {
    required int page,
    required int limit,
    required String filter,
    required Function(List<T> bangGiaDonHangs) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.PAGINATE,
      endPoint: getEndPoint(typeModel),
      page: page,
      limit: limit,
      filter: filter,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'].toString() != '[]' ? apiResponse.response.data['results'] as List<dynamic> : [];
      
      onSuccess(results.map((e) => getModel(typeModel, data: e)).toList().cast<T>());
    } else {
      onError(apiResponse.error);
    }
  }



  ///
  /// Find one by id
  ///
  Future<void> findOne(
    T typeModel, {
    required String id,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.FIND,
      endPoint: getEndPoint(typeModel),
      id: id,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel, data: results) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  Future<void> uploadImage({
    required List<File> files,
    required Function(ImageResponse data) onSuccess,
    required Function(dynamic error) onError,
    String? endPoint,
    IZIMethod? method,
  }) async {
    final List<MultipartFile> arrayFiles = [];
    for (var i = 0; i < files.length; i++) {
      arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
    }
    final FormData formData = FormData.fromMap({'files': arrayFiles});
    final ApiResponse apiResponse = await getReponstory(
      method: method ?? IZIMethod.ADD,
      endPoint: endPoint ?? 'upload',
      data: formData,
    );
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['data'] as dynamic;
      // Type model là image response
      onSuccess(getModel(ImageResponse(), data: results) as ImageResponse);
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Auth
  ///
  ///
  /// Insert
  ///
  Future<void> auth(
    T typeModel, {
    required T requestBody,
    required Function(T data) onSuccess,
    required Function(dynamic error) onError,
    String? endPoint,
  }) async {
    final ApiResponse apiResponse = await getReponstory(
      method: IZIMethod.ADD,
      endPoint: endPoint ?? getEndPoint(typeModel),
      data: requestBody,
    );
    if (IZIValidate.nullOrEmpty(apiResponse.response.statusCode)) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(getModel(typeModel, data: results) as T);
    } else {
      onError(apiResponse.error);
    }
  }

  Future<ApiResponse> getReponstory({
    required IZIMethod method,
    required String endPoint,
    dynamic data,
    int? page,
    int? limit,
    String? filter,
    String? id,
    List<File>? files,
  }) async {
    Response<dynamic>? response;
    String url = '$BASE_URL/$endPoint';
    if (method == IZIMethod.PAGINATE) {
      if (filter!.isEmpty) {
        // url += 'paginate?page=$page&limit=$limit';
        url += '/paginate?page=$page&limit=$limit';
      } else {
        // url += 'paginate?page=$page&limit=$limit$filter';
        url += '/paginate?page=$page&limit=$limit$filter';
      }
    } else if (method == IZIMethod.DELETE || method == IZIMethod.FIND || method == IZIMethod.UPDATE) {
      if (id!.isNotEmpty) {
        url += '/$id';
      }
    }
    print("API: $url");
    try {
      if (method == IZIMethod.GET) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.get(url);
        }
      } else if (method == IZIMethod.ADD) {
        if (!IZIValidate.nullOrEmpty(dioClient) && !IZIValidate.nullOrEmpty(data)) {
          response = await dioClient!.post(url, data: data.runtimeType == FormData ? data : data!.toJson());
        }
      } else if (method == IZIMethod.UPDATE) {
        if (!IZIValidate.nullOrEmpty(dioClient) && !IZIValidate.nullOrEmpty(data)) {
          response = await dioClient!.put(url, data: data.toJson());
        }
      } else if (method == IZIMethod.DELETE) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.delete(url);
        }
      } else if (method == IZIMethod.PAGINATE) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.get(url);
        }
      } else if (method == IZIMethod.FIND) {
        if (!IZIValidate.nullOrEmpty(dioClient)) {
          response = await dioClient!.get(url);
        }
      }

      if (!IZIValidate.nullOrEmpty(response)) {
        return ApiResponse.withSuccess(response!);
      }

      return ApiResponse.withError("No value");
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
