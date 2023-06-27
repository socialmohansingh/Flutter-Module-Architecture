import 'package:flutter_module_architecture/src/navigation/app_page.dart';

abstract class NavigationState {
  List<AppPage> pages;
  NavigationState(this.pages);
}

class UpdatePage extends NavigationState {
  UpdatePage(super.pages);
}

class InitialState extends NavigationState {
  InitialState(super.pages);
}

abstract class NavigationRouteState {
  final String? endPath;
  NavigationRouteState({this.endPath});
}

class DefaultRoute extends NavigationRouteState {
  DefaultRoute({super.endPath});
}
