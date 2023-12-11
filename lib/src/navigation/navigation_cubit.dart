import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_module_architecture/flutter_module_architecture.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

List<AppPage> cachePages = [];

class NavigationCubit extends Cubit<NavigationState>
    implements NavigationService {
  final List<AppPage> _pages = [];

  NavigationCubit(
    NavigationState initialState,
  ) : super(initialState) {
    _pages.addAll(initialState.pages);
    emit(UpdatePage(_pages));
  }

  @override
  bool pop({argument}) {
    if (_pages.length > 1) {
      _pages.removeLast();
      _updatePaths();
      cachePages = _pages;
      emit(UpdatePage(_pages));
    }
    return true;
  }

  @override
  bool push(AppPage page) {
    _pages.add(page);
    _updatePaths();
    cachePages = _pages;
    print(cachePages);
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool popToRoot({argument}) {
    if (_pages.isNotEmpty) {
      AppPage page = _pages.first;
      _pages.clear();
      _pages.add(page);
      _updatePaths();
      cachePages = _pages;
      emit(UpdatePage(_pages));
    }
    return true;
  }

  @override
  bool root(AppPage page) {
    _pages.clear();
    _pages.add(page);
    _updatePaths();
    cachePages = _pages;
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool popPage(String key) {
    var index = _pages.indexWhere((page) => page.page.key == ValueKey(key));
    if (index >= 0) {
      _pages.removeAt(index);
    }
    _updatePaths();
    cachePages = _pages;
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool popPages(List<String> keys) {
    for (var key in keys) {
      var index = _pages.indexWhere((page) => page.page.key == ValueKey(key));
      if (index >= 0) {
        _pages.removeAt(index);
      }
    }
    _updatePaths();
    cachePages = _pages;
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool popToPage(String key, {argument}) {
    var index = _pages.indexWhere((page) => page.page.key == ValueKey(key));
    if (index >= 0) {
      while (index < _pages.length) {
        index++;
        _pages.removeAt(index);
      }
    }
    _updatePaths();
    cachePages = _pages;
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool pushPages(List<AppPage> pages, {argument}) {
    _pages.addAll(pages);
    _updatePaths();
    cachePages = _pages;
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool resetPages(List<AppPage> pages, {argument}) {
    _pages.clear();
    _pages.addAll(pages);
    _updatePaths();
    cachePages = _pages;
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  List<AppPage> pages() {
    return _pages;
  }

  @override
  AppPage? topPage() {
    return _pages.isNotEmpty ? _pages.last : null;
  }

  @override
  AppPage? rootPage() {
    return _pages.isNotEmpty ? _pages.first : null;
  }

  @override
  bool clearCachePages() {
    print("clear");
    cachePages.clear();
    cachePages = [];
    return true;
  }

  _updatePaths() {}
}
