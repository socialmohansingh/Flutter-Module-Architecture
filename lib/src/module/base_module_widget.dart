import 'package:flutter/material.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';

class BaseModuleWidget extends StatefulWidget {
  final Widget child;
  final DependencyContainer? dependencyContainer;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Color primaryColor;
  final Color backgroundColor;

  const BaseModuleWidget({
    required this.child,
    this.dependencyContainer,
    this.errorWidget,
    this.loadingWidget,
    this.primaryColor = Colors.black,
    this.backgroundColor = Colors.white,
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
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.errorWidget ??
                Scaffold(
                  backgroundColor: widget.backgroundColor,
                  body: Center(
                    child: SizedBox(
                      height: 55,
                      width: 55,
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                          color: widget.primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
          }
          return widget.child;
        } else {
          return widget.loadingWidget ??
              Scaffold(
                backgroundColor: widget.backgroundColor,
                body: Center(
                  child: SizedBox(
                    height: 55,
                    width: 55,
                    child: CircularProgressIndicator(
                      color: widget.primaryColor,
                      backgroundColor: widget.backgroundColor,
                    ),
                  ),
                ),
              );
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.dependencyContainer?.dispose();
  }
}
