import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/otp/otp_request.dart';

class OTPRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  OTPRepository();

  ///
  /// Send OTP
  ///
  Future<ApiResponse> sendOTP(OTPRequest data) async {
    try {
      final response = await dioClient!.post('/otps/send-otp-phone', data: data.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }


}
