import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';

import '../navigation/navigation.dart';

abstract class ModuleMethod {
  Function({DeepLink? deepLink}) onReceive;
  Function(Object error) onError;

  ModuleMethod({required this.onReceive, required this.onError});

  Future<void> init(BaseNavigationService navigationRouter,
      {DeepLink? deepLink});
  Future<void> setRootPage({DeepLink? deepLink});
  Future<FeaturePage> pageWraper(Widget child, {DeepLink? deepLink});
  Future<void> dispose({DeepLink? deepLink});
}

abstract class BaseModule extends ModuleMethod {
  final String key;
  BaseModule({
    required this.key,
    required super.onReceive,
    required super.onError,
  });

  @override
  Future<FeaturePage> pageWraper(Widget child, {DeepLink? deepLink}) async {
    return FeaturePage(page: MaterialPage(child: child));
  }

  void _run(
    void Function(Object, StackTrace) onRunAppError, {
    DeepLink? deepLink,
    Map<Object?, Object?>? zoneValues,
    ZoneSpecification? zoneSpecification,
  }) async {
    try {
      var navigationStack = NavigationFlowCubit(
        this,
        null,
        InitialState([]),
      );
      await init(navigationStack, deepLink: deepLink);
      FeaturePage page = await pageWraper(
        RootNavigatorWidget(
          navigationFlow: navigationStack,
        ),
      );
      await setRootPage(deepLink: deepLink);
      runZonedGuarded(() => runApp(page.page.child), onRunAppError);
    } catch (e) {
      onError(e);
    }
  }
}

runAppModule(
  BaseModule module,
  Function(Object, StackTrace) onRunAppError, {
  DeepLink? deepLink,
  Map<Object?, Object?>? zoneValues,
  ZoneSpecification? zoneSpecification,
}) {
  module._run(onRunAppError,
      deepLink: deepLink,
      zoneValues: zoneValues,
      zoneSpecification: zoneSpecification);
}
