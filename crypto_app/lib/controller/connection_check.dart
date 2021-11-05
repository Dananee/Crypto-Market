import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';

class DataConnectvityServer {
  StreamController<DataConnectionStatus> dataConnectionStatus =
      StreamController<DataConnectionStatus>();

  DataConnectvityServer() {
    DataConnectionChecker().onStatusChange.listen((result) {
      dataConnectionStatus.add(result);
    });
  }
}
