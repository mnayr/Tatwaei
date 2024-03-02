import 'package:connectivity_plus/connectivity_plus.dart';

class InternetServices {
  // <==========  CHECK INTERNET CONNECTION  ==========???

  Future<bool> checkConnection() async {
    bool isConectionAvailabel = false;
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult != ConnectivityResult.none) {
      isConectionAvailabel = true;
    } else {
      isConectionAvailabel = false;
    }

    return isConectionAvailabel;
  }
}
