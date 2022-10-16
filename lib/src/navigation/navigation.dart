import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module_architecture/src/base/base_module.dart';
import 'package:flutter_module_architecture/src/base/base_navigation_service.dart';
import 'package:flutter_module_architecture/src/base/deep_link.dart';
import 'package:flutter_module_architecture/src/page/feature_page.dart';

abstract class _NavigationState {
  List<FeaturePage> pages;
  _NavigationState(this.pages);
}

class _UpdatePage extends _NavigationState {
  _UpdatePage(super.pages);
}

class InitialState extends _NavigationState {
  InitialState(super.pages);
}

// ignore: must_be_immutable
class NavigationFlowCubit extends Cubit<_NavigationState>
    implements NavigationService {
  final List<FeaturePage> _pages = [];
  NavigationService? _parentNavigationStack;
  final BaseModule _module;

  // ignore: library_private_types_in_public_api
  NavigationFlowCubit(
    this._module,
    this._parentNavigationStack,
    // ignore: library_private_types_in_public_api
    super.initialState,
  );

  @override
  void pop({DeepLink? deepLink}) {
    if (_pages.length > 1) {
      _pages.removeLast();
      if (_pages.last.received != null) {
        _pages.last.received!(deepLink: deepLink);
      }
      emit(_UpdatePage(_pages));
    } else {
      finishModule(deepLink: deepLink);
    }
  }

  @override
  void push(FeaturePage page, {DeepLink? deepLink}) {
    _pages.add(page);
    emit(_UpdatePage(_pages));
  }

  @override
  void popToRoot({DeepLink? deepLink}) {
    if (_pages.isNotEmpty) {
      FeaturePage page = _pages.first;
      _pages.clear();
      _pages.add(page);
      if (page.received != null) {
        page.received!(deepLink: deepLink);
      }
      emit(_UpdatePage(_pages));
    }
  }

  @override
  Future<void> startModule(BaseModule newModule, {DeepLink? deepLink}) async {
    var curentNavigationStack = NavigationFlowCubit(
      newModule,
      this,
      InitialState([]),
    );
    var navRouter =
        await newModule.init(curentNavigationStack, deepLink: deepLink);
    FeaturePage page = await newModule.pageWrapper(
      RootNavigatorWidget(
        navigationFlow: curentNavigationStack,
      ),
    );
    await newModule.setRootPage(navRouter, deepLink: deepLink);
    push(page);
  }

  @override
  Future<void> finishModule({DeepLink? deepLink}) async {
    if (_parentNavigationStack != null) {
      _parentNavigationStack!.pop(deepLink: deepLink);
      await _dispose(deepLink: deepLink);
    }
  }

  Future<void> _dispose({DeepLink? deepLink}) async {
    if (_parentNavigationStack != null) {
      await _module.dispose(deepLink: deepLink);
      _module.onReceive(deepLink: deepLink);
    }
    _parentNavigationStack = null;
  }

  @override
  void root(FeaturePage page, {DeepLink? deepLink}) {
    _pages.clear();
    _pages.add(page);
    emit(_UpdatePage(_pages));
  }

  @override
  bool shouldPop() {
    return true;
  }

  @override
  bool shouldPush() {
    return true;
  }

  @override
  Future<void> onSend({DeepLink? deepLink}) async {
    _module.onReceive(deepLink: deepLink);
  }
}

class RootNavigatorWidget extends StatefulWidget {
  final NavigationFlowCubit navigationFlow;

  const RootNavigatorWidget({
    required this.navigationFlow,
    super.key,
  });

  @override
  State<RootNavigatorWidget> createState() => _RootNavigatorWidgetState();
}

class _RootNavigatorWidgetState extends State<RootNavigatorWidget> {
  final heroController = HeroController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => widget.navigationFlow,
      child: BlocBuilder<NavigationFlowCubit, _NavigationState>(
        builder: (context, state) {
          List<Page<dynamic>> pages = state.pages.map((e) => e.page).toList();
          return Navigator(
            pages: List.unmodifiable(pages),
            observers: [heroController],
            onPopPage: (route, result) {
              final didPop = route.didPop(result);
              if (!didPop) {
                return false;
              }
              widget.navigationFlow.pop();
              return true;
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    widget.navigationFlow._dispose();
    super.dispose();
  }
}
