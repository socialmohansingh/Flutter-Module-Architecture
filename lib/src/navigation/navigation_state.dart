import 'package:flutter/material.dart';

abstract class NavigationState {
  List<MaterialPage> pages;
  NavigationState(this.pages);
}

class UpdatePage extends NavigationState {
  UpdatePage(super.pages);
}

class InitialState extends NavigationState {
  InitialState(super.pages);
}
