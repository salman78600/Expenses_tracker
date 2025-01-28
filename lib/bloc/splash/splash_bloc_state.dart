part of 'splash_bloc_bloc.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {}

final class SplashNavigated extends SplashState {}
