import 'base_module.dart';
import 'deep_link.dart';
import '../page/feature_page.dart';

// ignore: must_be_immutable
abstract class BaseNavigationService {
  bool shouldPop();
  bool shouldPush();

  Future<void> startModule(BaseModule newModule, {DeepLink? deepLink});
  Future<void> finishModule({DeepLink? deepLink});

  void push(FeaturePage page, {DeepLink? deepLink});
  void root(FeaturePage page, {DeepLink? deepLink});
  void pop({DeepLink? deepLink});
  void popToRoot({DeepLink? deepLink});
}
