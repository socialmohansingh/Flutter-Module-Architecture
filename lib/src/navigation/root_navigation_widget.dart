import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_cubit.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

// ignore: must_be_immutable
class RootNavigatorWidget extends StatefulWidget {
  List<MaterialPage<dynamic>> initialPages;
  RootNavigatorWidget({
    required this.initialPages,
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
      create: (context) => NavigationCubit(InitialState([])),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          List<Page<dynamic>> pages =
              state.pages.isEmpty ? widget.initialPages : state.pages;
          if (pages.isEmpty) {
            context.read<NavigationCubit>().pushPages(widget.initialPages);
          }
          return Navigator(
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
  }

  @override
  void dispose() {
    super.dispose();
  }
}
