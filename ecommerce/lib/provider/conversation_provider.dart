import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/conversation/conversation_request.dart';
import 'package:template/data/model/conversation/conversation_response.dart';
import 'package:template/data/repositories/conversation_reponsitory.dart';

class ConversationProvider {
  ConversationRepository? repository = GetIt.I.get<ConversationRepository>();

  ConversationProvider();

  ///
  /// Get all Banners
  ///
  Future<void> all({
    required Function(List<ConversationResponse> categorys) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.get();
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as List<dynamic>;
      onSuccess(results
          .map((e) => ConversationResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert Banner to database
  ///
  Future<void> add({
    required ConversationRequest data,
    required Function(ConversationRequest category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    
    final ApiResponse apiResponse = await repository!.add(data);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ConversationRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update Banner to database
  ///
  Future<void> update({
    required ConversationRequest data,
    required String id,
    required Function(ConversationRequest category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data,id);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ConversationRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Banner to database
  ///
  Future<void> delete({
    required String id,
    required Function(ConversationRequest category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.delete(id);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ConversationRequest.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Banners "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<ConversationResponse> conversations) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse =
        await repository!.paginate(page, limit, filter);
        if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data.toString() != '[]'
          ? apiResponse.response.data['results'] as List<dynamic>
          : [];
      onSuccess(results
          .map((e) => ConversationResponse.fromJson(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete Banner to database
  ///
  Future<void> find({
    required String id,
    required Function(ConversationResponse category) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.find(id);
    if(apiResponse.response.statusCode == null){
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(ConversationResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
}
