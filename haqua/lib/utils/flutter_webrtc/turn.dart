import 'dart:convert';
import 'dart:async';
import 'dart:io';

Future<Map> getTurnCredential(String host, int port) async {
  final HttpClient client = HttpClient(context: SecurityContext());
  client.badCertificateCallback = (X509Certificate cert, String host, int port) {
    return true;
  };
  // final url = 'https://$host:$port/api/turn?service=turn&username=flutter-webrtc';
  final url = 'https://$host/api/turn?service=turn&username=flutter-webrtc';
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();
  final responseBody = await response.transform(const Utf8Decoder()).join();
  final Map data = const JsonDecoder().convert(responseBody) as Map;
  return data;
}
