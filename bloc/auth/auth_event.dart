part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  AuthLoginRequested({
    required this.email,
    required this.password,
  });
}
//Event Triggered when the user requests to logout
final class AuthLogoutRequested extends AuthEvent {}
//Event Triggered when the stay connected checkbox is checked/unchecked
final class ChangeStayConnected extends AuthEvent {
  final bool stayConnected;
  ChangeStayConnected(this.stayConnected);
}
//Event Triggered when the password is shown/hidden
final class ChangePasswordShown extends AuthEvent {
  final bool showPassword;
  ChangePasswordShown(this.showPassword);
}
