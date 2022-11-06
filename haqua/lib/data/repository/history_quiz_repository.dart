import 'package:get_it/get_it.dart';
import '../datasource/remote/dio/dio_client.dart';
import '../datasource/remote/exception/api_error_handler.dart';
import '../model/base/api_response.dart';
import '../model/history_quiz/history_quiz_request.dart';

class HistoryQuizRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  HistoryQuizRepository();

  ///
  /// Get all History quiz.
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/history-quizzes');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add History quiz to database
  ///
  Future<ApiResponse> add(HistoryQuizRequest data) async {
    try {
      final response = await dioClient!.post('/history-quizzes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update History quiz to database
  ///
  Future<ApiResponse> update(String id, HistoryQuizRequest data) async {
    try {
      final response = await dioClient!.put('/history-quizzes/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update History quiz to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/history-quizzes/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate History quiz "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/history-quizzes/paginate?page=$page&limit=$limit'.toString();

      // add specializes filter
      if (filter != '') {
        uri = '/history-quizzes/paginate?page=$page&limit=$limit$filter';
      }

      print('History quiz $uri');

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find History quiz by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/history-quizzes/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
