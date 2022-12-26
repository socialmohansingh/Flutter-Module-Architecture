import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';

class BaseModuleWidget extends StatefulWidget {
  final Widget child;
  final DependencyContainer? dependencyContainer;

  const BaseModuleWidget({
    required this.child,
    this.dependencyContainer,
    super.key,
  });

  @override
  State<BaseModuleWidget> createState() => _BaseModuleWidgetState();
}

class _BaseModuleWidgetState extends State<BaseModuleWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.dependencyContainer?.init(),
      builder: (context, as) {
        return widget.child;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.dependencyContainer?.dispose();
  }
}
