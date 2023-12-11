import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/src/navigation/app_page.dart';

abstract class NavigationService {
  List<AppPage> pages();
  AppPage? topPage();
  AppPage? rootPage();
  bool push(AppPage page);
  bool pushPages(List<AppPage> pages);
  bool resetPages(List<AppPage> pages);
  bool root(AppPage page);
  bool pop({dynamic argument});
  bool popPage(String key);
  bool popToPage(String key, {dynamic argument});
  bool popPages(List<String> keys);
  bool popToRoot({dynamic argument});
  bool clearCachePages();
}
