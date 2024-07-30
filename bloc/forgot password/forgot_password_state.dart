part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState {
   final String? email;

  const ForgotPasswordState({this.email});

}

class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial() ;
}

class ForgotPasswordLoading extends ForgotPasswordState {
  ForgotPasswordLoading() ;
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;
  ForgotPasswordSuccess(this.email) : super(email: email);
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;
  ForgotPasswordFailure(this.error);
}

class ForgotPasswordSelectionUpdated extends ForgotPasswordState {
  final Set<String> selection;
  ForgotPasswordSelectionUpdated(this.selection);
}

class VerificationSuccess extends ForgotPasswordState {

}