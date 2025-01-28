import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_bloc_event.dart';
part 'splash_bloc_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<StartSplashTimer>(_onStartSplashTimer);
  }
  // This method will be called when StartSplashTimer event is added
  Future<void> _onStartSplashTimer(
      StartSplashTimer event, Emitter<SplashState> emit) async {
    await Future.delayed(const Duration(seconds: 3)); // Wait for 3 seconds
    emit(SplashNavigated()); // Emit navigation state
  }
}
