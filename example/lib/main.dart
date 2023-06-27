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
    return RootNavigatorWidget(
      rootPages: () => [
        AppPage(
          page: const MaterialPage(
            key: ValueKey(""),
            child: FirstPage(),
          ),
          path: "",
        ),
      ],
      onWillPop: (navigation) async {
        print("willPopScope");
        navigation.pop();
        return true;
      },
      dependencyContainer: AppDependencyContainer(),
      builder: (RouterDelegate<Object> routerDelegate,
          RouteInformationParser<Object> routeInformationParser) {
        return MaterialApp.router(
          routerDelegate: routerDelegate,
          routeInformationParser: routeInformationParser,
        );
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
  Future<void> init() async {}

  @override
  Future<void> dispose() async {}
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
            context.navigationCubit.push(
              AppPage(
                page: const MaterialPage(
                  child: SecondPage(),
                ),
                path: "s",
              ),
            );
          },
          child: Text("second"),
        ),
      ),
    ));
  }
}
