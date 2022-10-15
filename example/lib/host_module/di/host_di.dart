import 'package:get_it/get_it.dart';
import 'package:test_package/host_module/host_navigation_router.dart';

class HostDI {
  final getIt = GetIt.instance;
  Future<void> init(HostNavigation nav) async {
    getIt.registerSingleton(nav);
  }

  Future<void> dispose() async {
    GetIt.I.unregister(instance: getIt.get<HostNavigation>());
  }
}
