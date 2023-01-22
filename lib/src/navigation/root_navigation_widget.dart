import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/src/data_connector/data_connector_cubit.dart';
import 'package:flutter_module_architecture/src/module/dependency_container.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_cubit.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

final GlobalKey<NavigatorState> moduleNavigatorKey =
    GlobalKey<NavigatorState>();

// ignore: must_be_immutable
class RootNavigatorWidget extends StatefulWidget {
  List<MaterialPage<dynamic>> Function() initialPages;
  final DependencyContainer? dependencyContainer;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Color primaryColor;
  final Color backgroundColor;
  final GlobalKey<NavigatorState>? navigatorKey;

  RootNavigatorWidget({
    required this.initialPages,
    this.navigatorKey,
    this.dependencyContainer,
    this.errorWidget,
    this.loadingWidget,
    this.primaryColor = Colors.black,
    this.backgroundColor = Colors.white,
    super.key,
  });

  @override
  State<RootNavigatorWidget> createState() => _RootNavigatorWidgetState();
}

class _RootNavigatorWidgetState extends State<RootNavigatorWidget> {
  final heroController = HeroController();

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
                      child: Text(
                        snapshot.error.toString(),
                        style: TextStyle(
                          color: widget.primaryColor,
                        ),
                      ),
                    ),
                  );
            }
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      NavigationCubit(InitialState(widget.initialPages())),
                ),
                BlocProvider(
                  create: (context) => DataConnectorCubit(),
                )
              ],
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  List<Page<dynamic>> pages = state.pages;
                  return Navigator(
                    key: widget.navigatorKey ?? moduleNavigatorKey,
                    pages: List.unmodifiable(pages),
                    observers: [heroController],
                    onPopPage: (route, result) {
                      final didPop = route.didPop(result);
                      if (!didPop) {
                        return false;
                      }
                      context.read<NavigationCubit>().pop();
                      return true;
                    },
                  );
                },
              ),
            );
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
        });
  }

  @override
  void dispose() {
    super.dispose();
    widget.dependencyContainer?.dispose();
  }
}

extension BuildContextNavigation on BuildContext {
  NavigationCubit get navigationCubit {
    return read<NavigationCubit>();
  }

  DataConnectorCubit get dataConnectorCubit {
    return read<DataConnectorCubit>();
  }
}
