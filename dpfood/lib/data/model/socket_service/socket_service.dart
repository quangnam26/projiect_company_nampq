import 'package:socket_io_client/socket_io_client.dart' as IO;

class IZISocket {
  IO.Socket socket = IO.io('ws://s21haqua.izisoft.io', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true
  });
  IZISocket() {
    _init();
  }

  ///
  /// _init
  ///
  void _init() {
    if (socket.disconnected) {
      socket.connect();
      socket.onConnect(
        (_) {
          print('socket connect');
        },
      );
    }
  }
}
