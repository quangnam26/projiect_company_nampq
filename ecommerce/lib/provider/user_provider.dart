import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/user/user_request.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/repositories/user_reponsitory.dart';


class UserProvider {
  UserRepository? repository = GetIt.I.get<UserRepository>();

  UserProvider();

  ///
  /// Get all Users
  ///
  Future<void> all({
    required Function(List<UserResponse> users) onSuccess,
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
          .map((e) => UserResponse.fromMap(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Insert User to database
  ///
  Future<void> add({
    required UserRequest data,
    required Function(UserRequest user) onSuccess,
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
      onSuccess(UserRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Update User to database
  ///
  // Future<void> update({
  //     required String id,
  //   required UserRequest data,
  //   required Function(UserRequest userRequest) onSuccess,
  //   required Function(dynamic error) onError,
  // }) async {
  //    final ApiResponse apiResponse = await repository!.update(data,id);
  //   if(apiResponse.response.statusCode == null){
  //     return onError(apiResponse.error);
  //   }
  //   if (apiResponse.response.statusCode! >= 200 &&
  //       apiResponse.response.statusCode! <= 300) {
  //     // call back data success
  //     final results = apiResponse.response.data as dynamic;
  //     onSuccess(UserRequest.fromMap(results as Map<String, dynamic>));
  //   } else {
  //     onError(apiResponse.error);
  //   }
  // }

  // /
  // / Update Category to database
  // /
  Future<void> update({
    required UserRequest data,
    required String id,
    required Function(UserRequest cart) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.update(data,id);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
   final results = apiResponse.response.data as dynamic;
      onSuccess(UserRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete User to database
  ///
  Future<void> delete({
    required String id,
    required Function(UserRequest user) onSuccess,
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
      onSuccess(UserRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Get paginate Users "page": 1, "limit": 10
  ///
  Future<void> paginate({
    required int page,
    required int limit,
    required String filter,
    required Function(List<UserResponse> users) onSuccess,
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
          .map((e) => UserResponse.fromMap(e as Map<String, dynamic>))
          .toList());
    } else {
      onError(apiResponse.error);
    }
  }

  ///
  /// Delete User to database
  ///
  Future<void> find({
    required String id,
    required Function(UserResponse user) onSuccess,
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
      onSuccess(UserResponse.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }



  Future<void> checkPassword({
    // required String data,
    required String idUser, required String password,
    required Function(String result) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.checkPassword(idUser,password);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(results as String);
    } else {
      onError(apiResponse.error);
    }
  }


  Future<void> updatePassword({
    required UserRequest data,
    required Function(UserRequest user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.updatePassword(data);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }
    Future<void> updatePasswordbyPhone({
    required UserRequest data,
    required Function(UserRequest user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await repository!.updatePasswordbyPhone(data);
    if (apiResponse.response.statusCode == null) {
      return onError(apiResponse.error);
    }
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserRequest.fromMap(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
    }
  }

}
