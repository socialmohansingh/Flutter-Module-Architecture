import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';

import 'host_module/host_module.dart';

void main() {
  var module = HostModule(
    key: "host",
    onReceive: ({deepLink}) => {},
    onError: (e) {
      print("Module Error ${e}");
    },
  );

  runAppModule(module, (a, b) {});
}
