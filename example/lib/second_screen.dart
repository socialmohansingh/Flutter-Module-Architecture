import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:test_package/main.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.navigationCubit.pop();
        },
      )),
      body: Container(
        child: Center(
          child: TextButton(
            onPressed: () {
              context.navigationCubit.push(
                AppPage(
                  page: const MaterialPage(
                    child: FirstPage(),
                  ),
                  path: "first",
                ),
              );
            },
            child: Text("third"),
          ),
        ),
      ),
    );
  }
}
