import 'package:template/data/model/auth/auth_response.dart';

class AuthRequest extends AuthResponse {
  int? money;
  int? bornRequest;
  AuthRequest();

  @override
  AuthRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
