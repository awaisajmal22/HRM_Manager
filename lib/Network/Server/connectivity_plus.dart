import 'dart:async';


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class CheckConnectivityServices {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  bool internetStatus = false;

  initiateConnectivity({required Function callBack}) {
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((event) {
      _updateConnectionStatus(event as ConnectivityResult, (isInternet) {
        internetStatus = isInternet;
        callBack(isInternet);
      });
    }) as StreamSubscription<ConnectivityResult>;
  }

  disposeConnectivity() {
    _connectivitySubscription.cancel();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = (await _connectivity.checkConnectivity()) as ConnectivityResult;
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if () {
    //   return Future.value(null);
    // }

    return _updateConnectionStatus(result, (isInternet) {});
  }

  Future<void> _updateConnectionStatus(
      ConnectivityResult result, Function callBack) async {
    switch (result) {
      case ConnectivityResult.wifi:
        callBack(true);
        break;
      case ConnectivityResult.mobile:
        callBack(true);
        break;
      case ConnectivityResult.none:
        callBack(false);
        // setState(() => _connectionStatus = result.toString());
        break;
      default:
        callBack(true);
        // setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }

  Future<bool> onConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      // ShowMessage().showConnectivitySnackBar(connectivityResult, context);
      return true;
    } else {
      // ShowMessage().showErrorMessage(connectivityResult, context);
      return false;
    }
  }
}