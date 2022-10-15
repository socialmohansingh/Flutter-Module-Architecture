import 'package:flutter/material.dart';

class Feature2Page extends StatelessWidget {
  const Feature2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Module2 Feature 2"),
      ),
      body: SafeArea(
        child: Center(
          child: TextButton(
            child: const Text("Module2 Feature 2"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
