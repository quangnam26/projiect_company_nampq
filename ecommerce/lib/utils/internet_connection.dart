import 'dart:async';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

// ignore: camel_case_types
enum CONNECTION_STATUS {
  CONNECTED,
  DISCONNECTED,
}

class InternetConnection  {
  StreamSubscription<InternetConnectionStatus>? _listener;
  Rx<CONNECTION_STATUS> _connecteStatus = CONNECTION_STATUS.CONNECTED.obs;
  InternetConnection() {
    _onListenerStatus();
    _initState();
  }

  Future<void> _initState() async {
    _connecteStatus.value = await InternetConnectionChecker().hasConnection ? CONNECTION_STATUS.CONNECTED : CONNECTION_STATUS.DISCONNECTED;
  }

  CONNECTION_STATUS get internetConnectedStatus => _connecteStatus.value;
  // ignore: use_setters_to_change_properties
  void setConnectionChecker({required Rx<CONNECTION_STATUS> status}) {
    _connecteStatus = status;
  }

  Future<void> _onListenerStatus() async {
    _listener = InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            _connecteStatus.value = CONNECTION_STATUS.CONNECTED;
            break;
          case InternetConnectionStatus.disconnected:
            _connecteStatus.value = CONNECTION_STATUS.DISCONNECTED;
            break;
        }
      },
    );
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   super.didChangeAppLifecycleState(state);
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //       print("Đóng app");
  //       SystemChannels.textInput.invokeMethod('TextInput.hide');
  //       onCancel();
  //       break;
  //     case AppLifecycleState.paused:
  //       print("paused app");
  //       break;
  //     case AppLifecycleState.resumed:
  //       print("resumed app");
  //       WidgetsBinding.instance.addObserver(this);
  //       _onListenerStatus();
  //       _initState();
  //       break;
  //     default:
  //       break;
  //   }
  // }

  ///
  /// dispose
  ///
  void onCancel() {
    _listener?.cancel();
    // WidgetsBinding.instance.removeObserver(this);
  }
}
