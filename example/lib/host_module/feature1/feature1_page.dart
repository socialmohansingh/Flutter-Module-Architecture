import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:test_package/host_module/host_navigation_router.dart';

class Feature1Page extends StatelessWidget {
  const Feature1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Host Feature 1"),
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(
            child: const Text("Host Feature 1"),
            onPressed: () {
              GetIt.I.get<HostNavigation>().showFeature2Page();
            },
          ),
        ),
      ),
    );
  }
}
