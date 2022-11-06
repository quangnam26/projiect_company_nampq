import 'package:dio/dio.dart';

class LoggingInterceptor extends InterceptorsWrapper {
  int maxCharactersPerLine = 200;

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    final String responseAsString = response.data.toString();

    if (responseAsString.length > maxCharactersPerLine) {
      final int iterations = (responseAsString.length / maxCharactersPerLine).floor();
      for (int i = 0; i <= iterations; i++) {
        int endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
        if (endingIndex > responseAsString.length) {
          endingIndex = responseAsString.length;
        }
        // print( responseAsString.substring(i * maxCharactersPerLine, endingIndex));
      }
    } else {
      // print('Data ${response.data}');
    }
    return super.onResponse(response, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    print('ERROR [${err.response?.statusCode}] Message[${err.response?.data}] => PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}
