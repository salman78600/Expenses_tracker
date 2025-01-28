import 'package:expenses_tracker/bloc/splash/splash_bloc_bloc.dart';
import 'package:expenses_tracker/presentation/screens/main_screen.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:expenses_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(StartSplashTimer()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashNavigated) {
            // Navigate to Home Screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );
          }
        },
        child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  applogo,
                  width: 60,
                  height: 60,
                ),
                SizedBox(
                  height: 15,
                ),
                Text('Expense Tracker', style: appNameText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
