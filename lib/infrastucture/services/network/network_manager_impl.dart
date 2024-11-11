import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_final_test/application/services/network/network_manager.dart';

class NetworkManagerImpl extends INetworkManager {
  final Connectivity connectivity;

  NetworkManagerImpl({required this.connectivity});

  @override
  Stream<bool> checkConnectionStream() {
    return connectivity.onConnectivityChanged.map((event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        return true;
      } else {
        return false;
      }
    });
  }

  @override
  Future<bool> checkInitialConnection() async {
    final connection = await connectivity.checkConnectivity();
    if (connection == ConnectivityResult.wifi ||
        connection == ConnectivityResult.mobile) {
      return true;
    } else {
      return false;
    }
  }
}
