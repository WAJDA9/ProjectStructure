part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent {}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordEmailChanged(this.email);
}

class ForgotPasswordSelectionChanged extends ForgotPasswordEvent {
  final Set<String> selection;
  ForgotPasswordSelectionChanged(this.selection);
}

class ForgotPasswordSubmit extends ForgotPasswordEvent {
  final String email;
  ForgotPasswordSubmit(this.email);
}

class ForgotPasswordTransition extends ForgotPasswordEvent {
  
}

class VerificationRequested extends ForgotPasswordEvent {
  final String code;
  VerificationRequested(this.code);
}
