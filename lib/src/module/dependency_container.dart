import 'package:flutter_module_architecture/src/navigation/navigation_cubit.dart';

abstract class DependencyContainer {
  Future<void> init(NavigationCubit rootNavigationCubit);
  Future<void> dispose();
}
