import 'package:observe_internet_connectivity/observe_internet_connectivity.dart';

/// A mixin for checking internet connectivity status.
mixin ConnectionState {
  /// Returns `true` if the device has internet connectivity, `false` otherwise.
  Future<bool> hasInternet() async {
    final connectivityResult =
        await InternetConnectivity().hasInternetConnection;
    return connectivityResult;
  }
}
