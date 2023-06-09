import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/second_screen.dart';

void main() {
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
    return MaterialApp(
      home: RootNavigatorWidget(
        initialPages: () => [
          MaterialPage(
            key: ValueKey("ff"),
            child: FirstPage(),
          ),
        ],
        onWillPop: (navigation) async {
          print("willPopScope");
          navigation.pop();
          return false;
        },
        dependencyContainer: AppDependencyContainer(),
        navigatorKey: GlobalKey<NavigatorState>(),
      ),
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
    return Scaffold(body: Container(child: Center(child: TextButton(onPressed: (){
      context.navigationCubit.push(MaterialPage(key: ValueKey("s"), child: SecondPage()));
    },child: Text("second"),),),));
  }
}
