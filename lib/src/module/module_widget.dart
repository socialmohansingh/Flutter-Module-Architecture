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
class FlutterModule extends StatefulWidget {
  Future<List<AppPage>> Function()? rootPages;
  final Function(
          String endPath, BuildContext context, NavigationCubit navigation)?
      handleDeepLink;
  final Widget Function(
    BuildContext context, {
    RouterDelegate<Object>? routerDelegate,
    RouteInformationParser<Object>? routeInformationParser,
  }) builder;
  final DependencyContainer? dependencyContainer;
  final Future<bool> Function(NavigationCubit navigation)? onWillPop;
  final Widget Function(String error)? errorWidget;
  final Widget Function()? loadingWidget;
  final bool isRoot;

  factory FlutterModule.buildRootRouter({
    required Widget Function(
      RouterDelegate<Object> routerDelegate,
      RouteInformationParser<Object> routeInformationParser,
      BuildContext context,
    ) builder,
    required Future<bool> Function(NavigationCubit navigation) onWillPop,
    required Future<List<AppPage>> Function() rootPages,
    DependencyContainer? dependencyContainer,
    Function(String endPath, BuildContext context, NavigationCubit navigation)?
        handleDeepLink,
    Widget Function(String error)? errorWidget,
    Widget Function()? loadingWidget,
  }) {
    return FlutterModule._(
      rootPages: rootPages,
      builder: (context, {routeInformationParser, routerDelegate}) {
        return builder(routerDelegate!, routeInformationParser!, context);
      },
      onWillPop: onWillPop,
      handleDeepLink: handleDeepLink,
      dependencyContainer: dependencyContainer,
      errorWidget: errorWidget,
      loadingWidget: loadingWidget,
      isRoot: true,
    );
  }

  factory FlutterModule.build({
    required Widget Function(BuildContext context) builder,
    DependencyContainer? dependencyContainer,
    Widget Function(String error)? errorWidget,
    Widget Function()? loadingWidget,
  }) {
    return FlutterModule._(
      builder: (cotext, {routerDelegate, routeInformationParser}) {
        return builder(cotext);
      },
      dependencyContainer: dependencyContainer,
      errorWidget: errorWidget,
      loadingWidget: loadingWidget,
      isRoot: false,
    );
  }

  FlutterModule._({
    required this.builder,
    required this.isRoot,
    this.onWillPop,
    this.rootPages,
    this.handleDeepLink,
    this.dependencyContainer,
    this.errorWidget,
    this.loadingWidget,
  });

  @override
  State<FlutterModule> createState() => _FlutterModuleState();
}

class _FlutterModuleState extends State<FlutterModule> {
  List<AppPage> _pages = [];
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadAsyncFunctions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return widget.errorWidget == null
                ? Container()
                : widget.errorWidget!("");
          }
          return !widget.isRoot
              ? getBuilder(context)
              : MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) =>
                          NavigationCubit(InitialState(_pages)),
                    ),
                    BlocProvider(
                      create: (context) => GlobalConnector.data,
                    )
                  ],
                  child: BlocBuilder<NavigationCubit, NavigationState>(
                    builder: (context, state) {
                      List<String> pages = generateWebPath(state.pages);
                      final endPath = pages
                          .where((element) => element.isNotEmpty)
                          .join("/");
                      return getBuilder(context,
                          pages: state.pages, endPath: endPath);
                    },
                  ),
                );
        } else {
          return widget.loadingWidget == null
              ? Container()
              : widget.loadingWidget!();
        }
      },
    );
  }

  List<String> generateWebPath(List<AppPage> pages) {
    List<String> newPaths = [];

    for (AppPage page in pages) {
      for (int i = 0; i < page.replacePathIndexCount; i++) {
        newPaths.removeLast();
      }

      if (!(page.path.trim().isEmpty || page.path.isEmpty)) {
        String path = page.path;
        if (path[0] == "/") {
          path.replaceFirst("/", "");
        }
        newPaths.add(path);
      }
    }

    return newPaths;
  }

  Future<void> loadAsyncFunctions() async {
    await widget.dependencyContainer?.init();
    if (widget.rootPages != null) {
      _pages = cachePages.isEmpty ? await widget.rootPages!() : cachePages;
    }
  }

  Widget getBuilder(BuildContext context,
      {List<AppPage> pages = const [], String endPath = ""}) {
    return widget.builder(
      context,
      routerDelegate: !widget.isRoot
          ? null
          : UrlHandlerRouterDelegate(
              onWillPop: (BuildContext context) {
                return widget.onWillPop!(context.read<NavigationCubit>());
              },
              initialPages: cachePages.isEmpty ? pages : cachePages,
              endPaths: endPath,
              updatePath: (configuration) async {
                if (widget.handleDeepLink != null &&
                    configuration.endPath != null) {
                  widget.handleDeepLink!(
                    configuration.endPath!,
                    context,
                    context.read<NavigationCubit>(),
                  );
                }
              },
            ),
      routeInformationParser:
          !widget.isRoot ? null : UrlHandlerInformationParser(),
    );
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
