import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/question/question_request.dart';

class QuestionRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  QuestionRepository();

  //
  //get all questions
  //
  Future<ApiResponse> get() async {
    try {
      final response = await dioClient!.get('/questions');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert question to database
  ///
  Future<ApiResponse> add(QuestionRequest data) async {
    try {
      final response = await dioClient!.post('/questions', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update question to database
  ///
  Future<ApiResponse> update(QuestionRequest data, String id, {bool isOnlyAddAnswerer = false}) async {
    String filter = '';
    if (isOnlyAddAnswerer == false) {
      filter = '/questions/$id';
    } else {
      filter = '/questions/$id/add-answerer';
    }
    print("Insert Answer List $filter");
    try {
      final response = await dioClient!.put(filter, data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Selected answerer
  ///
  Future<ApiResponse> selectAnswerer(String idQuestion, String idUser, QuestionRequest data) async {
    try {
      final response = await dioClient!.put("/questions/$idQuestion/answerList/$idUser", data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Update questions to database
  ///
  Future<ApiResponse> delete(String id) async {
    try {
      final response = await dioClient!.delete('/questions/$id');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Get paginate question "page": 1, "limit": 10, filter
  ///
  Future<ApiResponse> paginate(int page, int limit, String filter) async {
    try {
      String uri = '/questions/paginate?page=$page&limit=$limit'.toString();

      // add condition filter
      if (filter != '') {
        uri = '/questions/paginate?page=$page&limit=$limit$filter';
      }

      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find question by id
  ///
  Future<ApiResponse> find(String id, String? filterPopulate) async {
    try {
      final String uri = '/questions/$id?populate=idUser,idSubSpecialize,$filterPopulate';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// deleteUserInAnswerList
  ///
  Future<ApiResponse> deleteUserInAnswerList(String idQuestion, String idUser) async {
    try {
      final response = await dioClient!.put('/questions/$idQuestion/answerer/$idUser');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// changeStatusPayment
  ///
  Future<ApiResponse> changeStatusPayment(
    QuestionRequest data,
    String id,
  ) async {
    try {
      final response = await dioClient!.put("/questions/$id/status-payment", data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// changeStatusQuestion
  ///
  Future<ApiResponse> changeStatusQuestion(
    QuestionRequest data,
    String id,
  ) async {
    try {
      final response = await dioClient!.put("/questions/$id/status-question", data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// changeStatusStartCall
  ///
  Future<ApiResponse> changeStatusStartCall(
    String id,
  ) async {
    try {
      final response = await dioClient!.put("/questions/$id/startCall");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// changeStatusEndCall
  ///
  Future<ApiResponse> changeStatusEndCall(
    String id,
  ) async {
    try {
      final response = await dioClient!.put("/questions/$id/endCall");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// shareVideo
  ///
  Future<ApiResponse> shareVideo(QuestionRequest data, String id) async {
    try {
      final response = await dioClient!.put("/questions/$id/share-video", data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
