import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
  Future<ConnectivityResult> get connectivityType;
  Stream<ConnectivityResult> get onConnectivityChanged;
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity _connectivity;
  NetworkInfoImpl(
    this._connectivity,
  );
  @override
  Future<bool> isConnected() async {
    if (await _connectivity.checkConnectivity() == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Future<ConnectivityResult> get connectivityType async {
    return await _connectivity.checkConnectivity();
  }

  @override
  Stream<ConnectivityResult> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }
}
