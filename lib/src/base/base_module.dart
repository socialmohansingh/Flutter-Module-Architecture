import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/src/base/base_navigation_service.dart';
import 'package:flutter_module_architecture/src/base/deep_link.dart';
import 'package:flutter_module_architecture/src/navigation/navigation.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_router.dart';
import 'package:flutter_module_architecture/src/page/feature_page.dart';

abstract class BaseModule<T extends NavigationRouter> {
  final String key;
  Function({
    DeepLink? deepLink,
  }) onReceive;
  Function(Object error) onError;

  BaseModule({
    required this.key,
    required this.onReceive,
    required this.onError,
  });

  Future<NavigationRouter> init(
    NavigationService navigationStack, {
    DeepLink? deepLink,
  });

  Future<void> setRootPage(
    T navigationRouter, {
    DeepLink? deepLink,
  });

  Future<FeaturePage> pageWrapper(
    Widget child, {
    DeepLink? deepLink,
  }) async {
    return FeaturePage(page: MaterialPage(child: child));
  }

  Future<void> dispose({
    DeepLink? deepLink,
  });

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
      T navRouter = await init(navigationStack, deepLink: deepLink) as T;
      FeaturePage page = await pageWrapper(
        RootNavigatorWidget(
          navigationFlow: navigationStack,
        ),
      );
      await setRootPage(navRouter, deepLink: deepLink);
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
  module._run(
    onRunAppError,
    deepLink: deepLink,
    zoneValues: zoneValues,
    zoneSpecification: zoneSpecification,
  );
}
