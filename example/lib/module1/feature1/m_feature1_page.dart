import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/module1/module1_navigaton.dart';

class Module1Feature1Page extends StatelessWidget {
  const Module1Feature1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            GetIt.instance.get<Module1Navigation>().finish();
          },
        ),
        title: const Text("Module1 Feature 1"),
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(
            child: const Text("Module1 Feature 1"),
            onPressed: () {
              GetIt.instance.get<Module1Navigation>().showFeature2Page();
            },
          ),
        ),
      ),
    );
  }
}
