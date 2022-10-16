import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/module1/feature1/m_feature1_page.dart';
import 'package:test_package/module1/feature2/feature2_page.dart';
import 'package:test_package/module2/module2.dart';

class Module1Navigation extends NavigationRouter {
  Module1Navigation({required super.navigationStack});

  finish() {
    navigationStack.finishModule();
  }

  showFeature1Page() {
    navigationStack.root(
      FeaturePage(
        page: const MaterialPage(
          key: ValueKey("mfp1"),
          child: Module1Feature1Page(),
        ),
      ),
    );
  }

  showFeature2Page() {
    navigationStack.push(
      FeaturePage(
        page: const MaterialPage(
          key: ValueKey("mfp2"),
          child: Feature2Page(),
        ),
      ),
    );
  }

  startModule2Plugin() {
    var module2 = Modile2(
      key: "md2",
      onReceive: ({deepLink}) {},
      onError: (error) {},
    );
    navigationStack.startModule(module2);
  }
}
