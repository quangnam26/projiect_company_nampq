import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/notification/notification_request.dart';
import 'package:template/data/model/notification/notification_response.dart';
import 'package:template/data/repository/notification_repository.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class NotificationProvider {
  NotificationRepository? regionRepo = GetIt.I.get<NotificationRepository>();

  NotificationProvider();

  ///
  /// Get all Notification
  ///
  Future<void> all({
    required Function(List<NotificationResponse> notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.get();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      print("TYPE: ${apiResponse.response.data.runtimeType}");
      print(apiResponse.response.data);
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Add notification to database
  ///
  Future<void> add({
    required NotificationRequest data,
    required Function(NotificationRequest notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.add(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update notification to database
  ///
  Future<void> update({
    required String id,
    required NotificationRequest data,
    required Function(NotificationRequest notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(data, id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete notification to database
  ///
  Future<void> delete({
    required String id,
    required NotificationRequest data,
    required Function(NotificationRequest notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.delete(id, data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate notification "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<NotificationResponse> notification) onSuccess,
    required Function(dynamic error) onError,
    Function(int count)? onCountNotice,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.paginate(page, limit, filter);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data['results'] as List<dynamic>;
      onSuccess(results.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>)).toList());
      if (!IZIValidate.nullOrEmpty(onCountNotice)) {
        onCountNotice!(IZINumber.parseInt(apiResponse.response.data['totalResults'].toString()));
      }
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// find notification to database
  ///
  Future<void> find({
    required String id,
    required Function(NotificationResponse notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.find(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Read Notice
  ///
  Future<void> readNotice({
    required String id,
    required NotificationRequest data,
    required Function(NotificationResponse notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.readNotice(id, data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Count Notification
  ///
  Future<void> countNotice({
    required String id,
    required Function(List<NotificationResponse> notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.countNotice(id);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>)).toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Read Notice
  ///
  Future<void> readNoticeWithSelected({
    required NotificationRequest data,
    required Function(NotificationResponse notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.readNoticeWithSelected(data);
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Read All Notice.
  ///
  Future<void> readALlNotices({
    required Function(NotificationResponse notification) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.readAllNotices();
    if (apiResponse.response.statusCode! >= 200 && apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(NotificationResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
