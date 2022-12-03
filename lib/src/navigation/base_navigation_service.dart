import 'package:flutter/material.dart';

abstract class NavigationService {
  bool push(MaterialPage page);
  bool pushPages(List<MaterialPage> pages);
  bool resetPages(List<MaterialPage> pages);
  bool root(MaterialPage page);
  bool pop({dynamic argument});
  bool popPage(String key);
  bool popToPage(String key, {dynamic argument});
  bool popPages(List<String> keys);
  bool popToRoot({dynamic argument});
}
