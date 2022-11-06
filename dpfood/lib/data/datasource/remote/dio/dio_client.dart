import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:template/sharedpref/shared_preference_helper.dart';
import 'package:template/utils/app_constants.dart' as app_constants;
import 'package:template/utils/refresh_token.dart';

class DioClient {
  GetIt sl = GetIt.instance;
  Dio? dio;
  String? token;
  LoggingInterceptor? loggingInterceptor;
  // final RefreshTokenUtil refreshTokenUtil = RefreshTokenUtil();

  DioClient() {
    _init();
  }

  Future<void> _init() async {
    final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;
    print("Token: $jwtToken");
    dio = Dio();
    dio!
      ..options.baseUrl = app_constants.BASE_URL
      ..options.connectTimeout = 60 * 1000
      ..options.receiveTimeout = 60 * 1000
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $jwtToken'};
    dio!.interceptors.add(sl.get<LoggingInterceptor>());
  }

  Future<void> refreshToken({String? url}) async {
    final String jwtToken = sl.get<SharedPreferenceHelper>().getJwtToken;
    dio = Dio();
    dio!
      ..options.baseUrl = url ?? app_constants.BASE_URL
      ..options.connectTimeout = 60 * 1000
      ..options.receiveTimeout = 60 * 1000
      ..httpClientAdapter
      ..options.headers = {'Content-Type': 'application/json; charset=UTF-8', 'Authorization': 'Bearer $jwtToken'};
    dio!.interceptors.add(sl.get<LoggingInterceptor>());
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (RefreshTokenUtil.isExpired()) {
        await RefreshTokenUtil.refreshTokens();
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      }
      final response = await dio!.get(
        uri,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print(response);
      return response;
    } on SocketException catch (e) {
      throw SocketException(e.toString());
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      // if (RefreshTokenUtil.isExpired()) {
      //   await RefreshTokenUtil.refreshTokens();
      //   await Future.delayed(
      //     const Duration(
      //       milliseconds: 500,
      //     ),
      //   );
      // }
      final response = await dio!.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      if (RefreshTokenUtil.isExpired()) {
        await RefreshTokenUtil.refreshTokens();
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      }
      final response = await dio!.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      if (RefreshTokenUtil.isExpired()) {
        await RefreshTokenUtil.refreshTokens();
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      }
      final response = await dio!.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> uploadImages(
    String uri, {
    required List<File> files,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      if (RefreshTokenUtil.isExpired()) {
        await RefreshTokenUtil.refreshTokens();
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      }
      final arrayFiles = [];
      for (var i = 0; i < files.length; i++) {
        arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      }

      final FormData formData = FormData.fromMap({'files': arrayFiles});
      final response = await dio!.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      print("Upload image");
      rethrow;
    }
  }

  Future<Response> uploadFiles(
    String uri, {
    required List<PlatformFile> files,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      if (RefreshTokenUtil.isExpired()) {
        await RefreshTokenUtil.refreshTokens();
        await Future.delayed(
          const Duration(
            milliseconds: 500,
          ),
        );
      }
      final arrayFiles = [];
      for (var i = 0; i < files.length; i++) {
        arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
      }

      final FormData formData = FormData.fromMap({'files': arrayFiles});

      final response = await dio!.post(
        uri,
        data: formData,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      return response;
    } on FormatException catch (_) {
      throw const FormatException('Unable to process the data');
    } catch (e) {
      rethrow;
    }
  }
}
