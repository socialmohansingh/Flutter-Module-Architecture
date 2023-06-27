import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/src/data_connector/data_connector_cubit.dart';
import 'package:flutter_module_architecture/src/module/dependency_container.dart';
import 'package:flutter_module_architecture/src/navigation/app_page.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_cubit.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';
import 'package:flutter_module_architecture/src/route_parser/url_handler_delegates.dart';
import 'package:flutter_module_architecture/src/route_parser/url_handler_information_parser.dart';

// ignore: must_be_immutable
class RootNavigatorWidget extends StatefulWidget {
  List<AppPage> Function() rootPages;
  final Function(String endPath, BuildContext context)? handleDeepLink;
  final Widget Function(
    RouterDelegate<Object> routerDelegate,
    RouteInformationParser<Object> routeInformationParser,
  ) builder;
  final DependencyContainer? dependencyContainer;
  final Widget? errorWidget;
  final Widget? loadingWidget;
  final Color primaryColor;
  final Color backgroundColor;
  final bool isWeb;
  final Future<bool> Function(NavigationCubit navigation) onWillPop;

  RootNavigatorWidget({
    required this.rootPages,
    required this.builder,
    required this.onWillPop,
    this.handleDeepLink,
    this.dependencyContainer,
    this.errorWidget,
    this.loadingWidget,
    this.isWeb = false,
    this.primaryColor = Colors.black,
    this.backgroundColor = Colors.white,
    super.key,
  });

  @override
  State<RootNavigatorWidget> createState() => _RootNavigatorWidgetState();
}

class _RootNavigatorWidgetState extends State<RootNavigatorWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: widget.dependencyContainer?.init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return widget.errorWidget ??
                  Container(
                    color: widget.backgroundColor,
                    child: Center(
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
                  create: (context) => NavigationCubit(
                    InitialState(widget.rootPages()),
                  ),
                ),
                BlocProvider(
                  create: (context) => GlobalConnector.data,
                )
              ],
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  List<AppPage> pages = state.pages;
                  final endPath = pages
                      .map((e) => e.path)
                      .toList()
                      .where((element) => element.isNotEmpty)
                      .join("/");
                  return widget.builder(
                      UrlHandlerRouterDelegate(
                        onWillPop: (BuildContext context) {
                          return widget
                              .onWillPop(context.read<NavigationCubit>());
                        },
                        initialPages: pages,
                        endPaths: endPath,
                        updatePath: (configuration) async {
                          if (widget.handleDeepLink != null &&
                              configuration.endPath != null) {
                            widget.handleDeepLink!(
                              configuration.endPath!,
                              context,
                            );
                          }
                        },
                      ),
                      UrlHandlerInformationParser());
                },
              ),
            );
          } else {
            return widget.loadingWidget ??
                Container(
                  color: widget.backgroundColor,
                  child: Center(
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

class GlobalConnector {
  static final data = DataConnectorCubit();
}
