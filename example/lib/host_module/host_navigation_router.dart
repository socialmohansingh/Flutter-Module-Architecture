import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/host_module/feature1/feature1_page.dart';
import 'package:test_package/host_module/feature2/feature2_page.dart';

import '../module1/module1.dart';

class HostNavigation extends NavigationRouter {
  HostNavigation({required super.navigationStack});

  showFeature1Page() {
    navigationStack.root(
      FeaturePage(
        page: const MaterialPage(
          key: ValueKey("fp1"),
          child: Feature1Page(),
        ),
      ),
    );
  }

  showFeature2Page() {
    navigationStack.push(
      FeaturePage(
        page: const MaterialPage(
          key: ValueKey("fp2"),
          child: Feature2Page(),
        ),
      ),
    );
  }

  startModule1Plugin() {
    var module1 = Modile1(
      key: "md1",
      onReceive: ({deepLink}) {},
      onError: (error) {
        print("Module1 Error ${error}");
      },
    );
    navigationStack.startModule(module1);
  }
}
