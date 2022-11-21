import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module_architecture/src/navigation/navigation.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

class RootNavigatorWidget extends StatefulWidget {
  const RootNavigatorWidget({
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
          List<Page<dynamic>> pages = state.pages.map((e) => e.page).toList();
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
