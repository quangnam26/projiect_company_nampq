// ignore_for_file: library_prefixes

import 'package:template/utils/app_constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  IO.Socket? _socket;
  SocketService() {
    initSocket();
  }

  void initSocket() {
    _socket = IO.io(
        socket_url,
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            // .disableAutoConnect() // disable auto-connection
            .build());
    connect();
  }

  ///
  /// connect socket to sever
  ///
  void connect() {
    _socket?.connect();
    _socket?.onConnect((data) {
      print("Hello, Toan. Socket connected");
    });
  }

  ///
  /// get instance socket
  ///
  IO.Socket getSocket() {
    return _socket!;
  }

  ///
  /// Override `emit`.
  /// If the event is in `events`, it's emitted normally.
  ///
  /// @param {String} event name
  /// @return {Socket} self
  /// @api public
  ///
  void emit(String event, [dynamic data]) {
    _socket?.emit(event, data);
  }

  void on(String event, dynamic Function(dynamic) handler) {
    _socket?.on(event, handler);
  }



  bool hasListeners(String event) {
    return _socket?.hasListeners(event) ?? false;
  }

  void clearListener() {
    _socket?.clearListeners();
  }

  ///
  /// disconnect
  ///
  void disconnect() {
    _socket?.disconnect();
  }

  bool? isConnected() {
    return _socket?.connected;
  }

  bool? isDisconnected() {
    return _socket?.disconnected;
  }
}
