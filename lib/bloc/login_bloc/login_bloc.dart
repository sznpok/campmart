import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repo/auth_repo.dart';
import 'login_event.dart'; // replace with the correct path to your LoginEvent
import 'login_state.dart'; // replace with the correct path to your LoginState

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginUserEvent>(_onLoginUser);
  }

  Future<void> _onLoginUser(
    LoginUserEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await authRepository.loginUser(
        email: event.email,
        password: event.password,
      );
      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
