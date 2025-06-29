import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';





class ConnectionService extends GetxService {

  
  RxBool isConnected = true.obs;
  StreamSubscription<InternetConnectionStatus>? _subscription;


  void _initializeConnectionChecker() {
    // Emit the current connection status immediately
    InternetConnectionChecker().hasConnection.then((status) {
      _updateConnectionStatus(status);
    });

    // Listen to connection changes with throttling
    _subscription = InternetConnectionChecker().onStatusChange.listen((status) {
      _updateConnectionStatus(status == InternetConnectionStatus.connected);
    });
  }

  void _updateConnectionStatus(bool status) {
    // Optionally, perform an additional check before updating
    if (!status) {
      _performDoubleCheck().then((confirmedStatus) {
        isConnected.value = confirmedStatus;
        log("is internet connected: ${isConnected.value}");
      });
    } else {
      isConnected.value = status;
      log("is internet connected: ${isConnected.value}");
    }
  }

  Future<bool> _performDoubleCheck() async {
    // Example of an additional check - trying to reach a reliable endpoint
    try {
      final response = await InternetConnectionChecker().hasConnection;
      return response;
    } catch (e) {
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeConnectionChecker();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
