import 'package:flutter_module_architecture/src/page/feature_page.dart';

abstract class NavigationState {
  List<FeaturePage> pages;
  NavigationState(this.pages);
}

class UpdatePage extends NavigationState {
  UpdatePage(super.pages);
}

class InitialState extends NavigationState {
  InitialState(super.pages);
}
