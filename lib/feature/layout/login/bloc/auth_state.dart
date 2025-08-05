enum AuthStatus { initial, loading, success, error }

class AuthState {
  final AuthStatus status;
  final String? username;
  final String? errorMessage;

  AuthState({
    this.status = AuthStatus.initial,
    this.username,
    this.errorMessage,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? username,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      username: username ?? this.username,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}