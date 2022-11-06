import 'package:get_it/get_it.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/data/repository/withdraw_money_respository.dart';

class WithDrawMoneyProvider {
  WithDrawMoneyRespository? regionRepo =
      GetIt.I.get<WithDrawMoneyRespository>();

  WithDrawMoneyProvider();

  ///
  /// Update user to database
  ///
  Future<void> update({
    required Map<String,dynamic> money,
    required Function(UserResponse user) onSuccess,
    required Function(dynamic error) onError,
  }) async {
    final ApiResponse apiResponse = await regionRepo!.update(money);
    print('object ${apiResponse.response}');
    if (apiResponse.response.statusCode! >= 200 &&
        apiResponse.response.statusCode! <= 300) {
      // call back data success
      final results = apiResponse.response.data as dynamic;
      onSuccess(UserResponse.fromJson(results as Map<String, dynamic>));
    } else {
      onError(apiResponse.error);
      print('object ${apiResponse.error}');
    }
  }


  
}
