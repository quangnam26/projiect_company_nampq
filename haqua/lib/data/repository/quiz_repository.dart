import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/quiz/quiz_request.dart';

class QuizReposository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  QuizReposository();

  //
  //get all quiz
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/quizzes');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Add quizzes to database
  ///
  Future<ApiResponse> add(QuizRequest data) async {
    try {
      final response = await dioClient!.post('/quizzes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update quizzes to database
  ///
  Future<ApiResponse> update(QuizRequest data) async {
    try {
      final response = await dioClient!.put('/quizzes', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Delete quizzes to database
  ///
  Future<ApiResponse> delete(String id, QuizRequest data) async {
    try {
      final response = await dioClient!.delete('/quizzes/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate quizzes "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/quizzes/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/quizzes/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find subject by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/quizzes/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
