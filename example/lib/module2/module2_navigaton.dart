import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/module2/feature1/m_feature1_page.dart';
import 'package:test_package/module2/feature2/feature2_page.dart';

class Module2Navigation extends NavigationRouter {
  Module2Navigation({required super.navigationStack});

  finish() {
    navigationStack.finishModule();
  }

  showFeature1Page() {
    navigationStack.root(
      FeaturePage(
        page: const MaterialPage(
          child: Module1Feature1Page(),
        ),
      ),
    );
  }

  showFeature2Page() {
    navigationStack.push(
      FeaturePage(
        page: const MaterialPage(
          key: ValueKey("m2fp2"),
          child: Feature2Page(),
        ),
      ),
    );
  }
}
