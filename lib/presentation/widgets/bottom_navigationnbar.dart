import 'package:expenses_tracker/bloc/navigationbar/bottom_navigation_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      fit: StackFit.loose,
      children: [
        BlocBuilder<NavigationBloc, NavigationState>(
          builder: (context, state) {
            return BottomNavigationBar(
              currentIndex: _getCurrentIndex(state),
              onTap: (index) {
                final bloc = BlocProvider.of<NavigationBloc>(context);
                if (index == 0) bloc.add(NavigateToHome());
                if (index == 1) bloc.add(NavigateToSummary());
              },
              items: const [
                BottomNavigationBarItem(
                  tooltip: 'Home',
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  tooltip: 'Summary',
                  icon: Icon(Icons.bar_chart_outlined),
                  label: 'Summary',
                ),
              ],
            );
          },
        ),
        Positioned(
          bottom: 40, // Adjust to fit above the BottomNavigationBar
          child: FloatingActionButton.small(
            onPressed: () {
              final bloc = BlocProvider.of<NavigationBloc>(context);
              bloc.add(NavigateToAddExpense());
            },
            backgroundColor: Colors.black, // Button background color
            child: const Icon(
              Icons.add,
              color: Colors.white, // Icon color
            ),
          ),
        ),
      ],
    );
  }

  int _getCurrentIndex(NavigationState state) {
    if (state is HomeState) return 0;
    if (state is SummaryState) return 1;
    return 0;
  }
}
