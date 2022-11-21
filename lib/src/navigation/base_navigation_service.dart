import 'package:flutter_module_architecture/src/page/feature_page.dart';

abstract class NavigationService {
  bool push(FeaturePage page);
  bool pushPages(List<FeaturePage> pages);
  bool resetPages(List<FeaturePage> pages);
  bool root(FeaturePage page);
  bool pop({dynamic argument});
  bool popPage(String key);
  bool popToPage(String key, {dynamic argument});
  bool popPages(List<String> keys);
  bool popToRoot({dynamic argument});
}
