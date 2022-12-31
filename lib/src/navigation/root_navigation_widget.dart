import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_module_architecture/src/module/dependency_container.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_cubit.dart';
import 'package:flutter_module_architecture/src/navigation/navigation_state.dart';

// ignore: must_be_immutable
class RootNavigatorWidget extends StatefulWidget {
  List<MaterialPage<dynamic>> initialPages;
  final DependencyContainer? dependencyContainer;

  RootNavigatorWidget({
    required this.initialPages,
    this.dependencyContainer,
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
            return BlocProvider(
              create: (context) =>
                  NavigationCubit(InitialState(widget.initialPages)),
              child: BlocBuilder<NavigationCubit, NavigationState>(
                builder: (context, state) {
                  List<Page<dynamic>> pages = state.pages;
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
          } else {
            return const Center(
              child: SizedBox(
                height: 55,
                width: 55,
                child: CircularProgressIndicator(),
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
}
