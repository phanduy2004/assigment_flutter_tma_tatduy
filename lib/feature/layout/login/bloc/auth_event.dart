abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  LoginEvent({required this.username, required this.password});
}
class RegisterUserEvent extends AuthEvent {
  final String username;
  final String password;
  final String fullname;
  final String email;
  final String confirmPassword;

  RegisterUserEvent({required this.username, required this.password, required this.fullname, required this.email, required this.confirmPassword});
}


