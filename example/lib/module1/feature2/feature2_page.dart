import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/module1/module1_navigaton.dart';

class Feature2Page extends StatelessWidget {
  const Feature2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Module1 Feature 2"),
        actions: [
          TextButton(
              onPressed: () {
                GetIt.instance.get<Module1Navigation>().startModule2Plugin();
              },
              child: const Text("M1")),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(
            child: const Text("Module1 Feature 2"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
