import 'package:flutter_module_architecture/src/navigation/app_page.dart';

abstract class ModuleFeaturePage {
  const ModuleFeaturePage();
}

class DefaultRootPage extends ModuleFeaturePage {
  const DefaultRootPage();
}

abstract class BaseModuleBridge {
  AppPage getRootWidget({
    ModuleFeaturePage displayPage = const DefaultRootPage(),
    String? deepLink,
  });
}
