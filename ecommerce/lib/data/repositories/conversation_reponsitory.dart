import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/conversation/conversation_request.dart';

class ConversationRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ConversationRepository();

  ///
  /// Get all conversations.
  ///
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/conversations');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert conversation to database.
  ///
  Future<ApiResponse> add(ConversationRequest data) async {
    try {
      final response = await dioClient!.post('/conversations', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update conversation to database.
  ///
  Future<ApiResponse> update(ConversationRequest data, String id) async {
    try {
      final response = await dioClient!.put('/conversations/$id', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update conversation to database.
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/conversations/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate conversations "page": 1, "limit": 10, filter .
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/conversations/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/conversations/paginate?page=$page&limit=$limit$filter';
      }
      final response = await dioClient!.get(uri);

      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find conversation by id.
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/conversations/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
