import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/src/base/deep_link.dart';

class FeaturePage {
  final MaterialPage page;
  Function({
    DeepLink? deepLink,
  })? received;

  FeaturePage({
    required this.page,
    this.received,
  });
}
