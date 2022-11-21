import 'package:flutter/material.dart';

class FeaturePage {
  final MaterialPage page;
  Function({
    dynamic argument,
  })? onReceive;

  FeaturePage({
    required this.page,
    this.onReceive,
  });
}
