import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:async';

import 'package:template/helper/izi_number.dart';

class SimpleWebSocket {
  final String _url;
  var _socket;
  Function()? onOpen;
  Function(dynamic msg)? onMessage;
  Function(int? code, String? reaso)? onClose;
  SimpleWebSocket(this._url);

  ///
  ///connect
  ///
  Future<void> connect() async {
    try {
      //_socket = await WebSocket.connect(_url);
      _socket = await _connectForSelfSignedCert(_url);
      onOpen?.call();
      _socket.listen((data) {
        onMessage?.call(data);
      }, onDone: () {
        onClose?.call(IZINumber.parseInt(_socket.closeCode), _socket.closeReason.toString());
      });
    } catch (e) {
      onClose?.call(500, e.toString());
    }
  }

  ///
  ///send
  ///
  void send(data) {
    if (_socket != null) {
      _socket.add(data);
      print('send: $data');
    }
  }

  ///
  ///close
  ///
  void close() {
    if (_socket != null) _socket.close();
  }

  ///
  ///_connectForSelfSignedCert
  ///
  Future<WebSocket> _connectForSelfSignedCert(url) async {
    try {
      final Random r = Random();
      final String key = base64.encode(List<int>.generate(8, (_) => r.nextInt(255)));
      final HttpClient client = HttpClient(context: SecurityContext());
      client.badCertificateCallback = (X509Certificate cert, String host, int port) {
        return true;
      };

      final HttpClientRequest request = await client.getUrl(Uri.parse(url.toString())); // form the correct url here
      request.headers.add('Connection', 'Upgrade');
      request.headers.add('Upgrade', 'websocket');
      request.headers.add('Sec-WebSocket-Version', '13'); // insert the correct version here
      request.headers.add('Sec-WebSocket-Key', key.toLowerCase());

      final HttpClientResponse response = await request.close();
      // ignore: close_sinks
      final Socket socket = await response.detachSocket();
      final webSocket = WebSocket.fromUpgradedSocket(
        socket,
        protocol: 'signaling',
        serverSide: false,
      );

      return webSocket;
    } catch (e) {
      rethrow;
    }
  }
}
