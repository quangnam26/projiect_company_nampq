import 'package:flutter/material.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/helper/izi_toast.dart';

mixin IZIApiChecker {
  static void checkApi(BuildContext context, ApiResponse apiResponse) {
    if (apiResponse.error is! String && apiResponse.error.errors[0].message == 'Unauthorized.') {
      // Provider.of<AuthProvider>(context,listen: false).clearSharedData();
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const AuthScreen()), (route) => false);
    } else {
      String _errorMessage;
      if (apiResponse.error is String) {
        _errorMessage = apiResponse.error.toString();
      } else {
        _errorMessage = apiResponse.error.errors[0].message.toString();
      }
      print(_errorMessage);
      IZIToast().error(message: _errorMessage);
    }
  }
}
