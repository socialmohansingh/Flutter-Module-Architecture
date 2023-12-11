import 'package:flutter/material.dart';

class AppPage {
  final String path;
  final Page page;
  final int replacePathIndexCount;
  AppPage({
    required this.page,
    required this.path,
    this.replacePathIndexCount = 0,
  });
}
