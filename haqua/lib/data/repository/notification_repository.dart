import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/notification/notification_request.dart';

class NotificationRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  NotificationRepository();

  //
  //get all notifications
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/notifications');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add notification to database
  ///
  Future<ApiResponse> add(NotificationRequest data) async {
    try {
      final response = await dioClient!.post('/notifications', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update notification to database
  ///
  Future<ApiResponse> update(NotificationRequest data, String id) async {
    try {
      final response = await dioClient!.put('/notifications', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Delete notifications to database
  ///
  Future<ApiResponse> delete(String id, NotificationRequest data) async {
    try {
      final response = await dioClient!.delete('/notifications/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate notification "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/notifications/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/notifications/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find notification by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/notifications/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Read notification by id
  ///
  Future<ApiResponse> readNotice(String id, NotificationRequest data) async {
    try {
      final String uri = '/notifications/$id/markAsRead';
      final response = await dioClient!.put(uri, data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //
  //Count all notifications
  //
  Future<ApiResponse> countNotice(String id) async {
    try {
      final response = await dioClient!.get('/notifications?reads!=$id&idUsers=$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// readNoticeWithSelected
  ///
  Future<ApiResponse> readNoticeWithSelected(NotificationRequest data) async {
    try {
      const String uri = '/notifications/mark-as-read-ids';
      final response = await dioClient!.put(uri, data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Real all notices.
  ///
  Future<ApiResponse> readAllNotices() async {
    try {
      const String uri = '/notifications/mark-as-read-all';
      final response = await dioClient!.put(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
