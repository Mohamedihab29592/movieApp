import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../utilies/strings.dart';
import '../utilies/toast.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
  Future<void> checkInternet();
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;

  NetworkInfoImpl({ this.connectionChecker});

  @override
  Future<bool> get isConnected => connectionChecker!.hasConnection;

  @override
  Future<void> checkInternet() async {
    bool result = await InternetConnectionChecker.instance.hasConnection;
    if (result == false) {
      showToast(text: AppStrings.noInternet, state: ToastStates.error);
    }
  }
}


