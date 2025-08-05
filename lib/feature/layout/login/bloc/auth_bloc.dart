import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repository/auth_reporsitory.dart';
import 'auth_state.dart';
import 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthState()) {
    on<LoginEvent>(_onLoginEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStatus.loading));
    try {
      final user = await authRepository.login(
        username: event.username,
        password: event.password,
      );
      emit(state.copyWith(status: AuthStatus.success, username: user['username']));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error, errorMessage: e.toString()));
    }
  }
}