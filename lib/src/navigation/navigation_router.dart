import 'package:flutter_module_architecture/src/base/base_navigation_service.dart';

abstract class NavigationRouter {
  NavigationService navigationStack;

  NavigationRouter({required this.navigationStack});
}
