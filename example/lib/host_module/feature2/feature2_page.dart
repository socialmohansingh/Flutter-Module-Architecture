import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/host_module/host_navigation_router.dart';

class Feature2Page extends StatelessWidget {
  const Feature2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Host Feature 2"),
        actions: [
          TextButton(
              onPressed: () {
                GetIt.I.get<HostNavigation>().startModule1Plugin();
              },
              child: const Text("M1")),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(
            child: const Text("Host Feature 2"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
