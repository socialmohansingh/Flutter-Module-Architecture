import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/second_screen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return FlutterModule.buildRootRouter(
      builder: (routerDelegate, routeInformationParser, context) {
        return MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: routeInformationParser,
        );
      },
      rootPages: () async {
        return [
          AppPage(
            page: const MaterialPage(
              key: ValueKey(""),
              child: FirstPage(),
            ),
            path: "",
          ),
        ];
      },
      dependencyContainer: AppDependencyContainer(),
      onWillPop: (navigation) async {
        navigation.pop();
        return true;
      },
      handleDeepLink: (String endPath, context) {
        context.navigationCubit.push(
          AppPage(
            page: const MaterialPage(
              child: SecondPage(),
            ),
            path: "s",
          ),
        );
      },
    );
  }
}

class AppDependencyContainer extends DependencyContainer {
  @override
  Future<void> init() async {
    print("init");
  }

  @override
  Future<void> dispose() async {
    print("dispose");
  }
}

class AppDependencyModuleContainer extends DependencyContainer {
  @override
  Future<void> init() async {
    print("init module");
  }

  @override
  Future<void> dispose() async {
    print("dispose module");
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: TextButton(
          onPressed: () {
            context.navigationCubit.push(SecondModuleBridget().getRootWidget());
          },
          child: Text("second"),
        ),
      ),
    ));
  }
}

class SecondModule extends StatelessWidget {
  const SecondModule({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterModule.build(
      builder: (context) {
        return SecondPage();
      },
      dependencyContainer: AppDependencyModuleContainer(),
    );
  }
}

class SecondModuleBridget extends BaseModuleBridge {
  @override
  AppPage getRootWidget({
    ModuleFeaturePage displayPage = const DefaultRootPage(),
    String? deepLink,
  }) {
    return AppPage(
        page: const MaterialPage(key: ValueKey("s"), child: SecondModule()),
        path: "s");
  }
}
