part of 'auth_bloc.dart';

@immutable
class AuthState {
  final User? user;

  const AuthState({this.user});
}

// Initial state of the authentication process
final class AuthInitial extends AuthState {
  const AuthInitial({User? user}) : super(user: user);
}

// State when authentication is successful
final class AuthSuccess extends AuthState {
  get props => user;

  const AuthSuccess({required User uid}) : super(user: uid);
}

// State when authentication fails
final class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);
}

// State when authentication is in progress
final class AuthLoading extends AuthState {}

// State for "stay connected" checkbox
final class StayConnected extends AuthState {
  final bool stayConnected;

  const StayConnected(this.stayConnected);
}

// State for showing/hiding password
final class PasswordShown extends AuthState {
  final bool showPassword;

  const PasswordShown(this.showPassword);
}
