import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module_architecture/src/navigation/base_navigation_service.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';
import 'package:flutter_module_architecture/src/page/feature_page.dart';

class NavigationCubit extends Cubit<NavigationState>
    implements NavigationService {
  final List<FeaturePage> _pages = [];

  NavigationCubit(
    super.initialState,
  );

  @override
  bool pop({argument}) {
    if (_pages.length > 1) {
      _pages.removeLast();
      if (_pages.last.onReceive != null) {
        _pages.last.onReceive!(argument: argument);
      }
      emit(UpdatePage(_pages));
    }
    return true;
  }

  @override
  bool push(FeaturePage page) {
    _pages.add(page);
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool popToRoot({argument}) {
    if (_pages.isNotEmpty) {
      FeaturePage page = _pages.first;
      _pages.clear();
      _pages.add(page);
      if (page.onReceive != null) {
        page.onReceive!(argument: argument);
      }
      emit(UpdatePage(_pages));
    }
    return true;
  }

  @override
  bool root(FeaturePage page) {
    _pages.clear();
    _pages.add(page);
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool popPage(String key) {
    var index = _pages.indexWhere((page) => page.page.key == ValueKey(key));
    if (index >= 0) {
      _pages.removeAt(index);
    }
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
    if (_pages.last.onReceive != null) {
      _pages.last.onReceive!(argument: argument);
    }
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool pushPages(List<FeaturePage> pages, {argument}) {
    _pages.addAll(pages);
    emit(UpdatePage(_pages));
    return true;
  }

  @override
  bool resetPages(List<FeaturePage> pages, {argument}) {
    _pages.clear();
    _pages.addAll(pages);
    emit(UpdatePage(_pages));
    return true;
  }
}
