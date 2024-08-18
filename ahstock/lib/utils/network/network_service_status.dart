import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { Online, Offline }

class NetworkStatusService {
  static NetworkStatus currentStatus = NetworkStatus.Online;
  static StreamController<NetworkStatus> networkStatusController =
      StreamController<NetworkStatus>.broadcast();

  NetworkStatusService() {
    checkInternetAccess().then((NetworkStatus stat) {
      currentStatus = stat;
      Connectivity().onConnectivityChanged.listen((status) {
        NetworkStatus stat = _getNetworkStatus(status[0]);
        if (currentStatus != stat) {
          currentStatus = stat;
          networkStatusController.add(stat);
        }
      });
    });
  }

  static Future<NetworkStatus> checkInternetAccess({String? domain}) async {
    try {
      final result = await InternetAddress.lookup(domain ?? 'google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return NetworkStatus.Online;
      }
      return NetworkStatus.Online;
    } on SocketException catch (_) {
      return NetworkStatus.Offline;
    }
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult status) {
    return (status == ConnectivityResult.mobile ||
            status == ConnectivityResult.wifi)
        ? NetworkStatus.Online
        : NetworkStatus.Offline;
  }
}
