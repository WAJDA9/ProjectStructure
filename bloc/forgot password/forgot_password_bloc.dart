import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physio_app/bloc/cubit/selection_cubit.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailChanged>(_onEmailChanged);
    on<ForgotPasswordSelectionChanged>(_onSelectionChanged);
    on<ForgotPasswordSubmit>(_onSubmit);
    on<ForgotPasswordTransition>(_onTransition);
    on<VerificationRequested>(_onVerificationRequested);
  }

  void _onEmailChanged(
    ForgotPasswordEmailChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(ForgotPasswordSelectionUpdated({event.email}));
  }

  void _onSelectionChanged(
    ForgotPasswordSelectionChanged event,
    Emitter<ForgotPasswordState> emit,
  ) {
    emit(ForgotPasswordSelectionUpdated(event.selection));
  }

  void _onSubmit(
    ForgotPasswordSubmit event,
    Emitter<ForgotPasswordState> emit,
  ) {
    // emit(ForgotPasswordLoading());
    
    final email = event.email;
    final emailRegex =
      RegExp(r'^[\w-]+([._]?[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
      
    if (emailRegex.hasMatch(email) || double.tryParse(event.email) != null) {
      emit(ForgotPasswordSuccess(event.email));
    } 
    
    else if (email.startsWith(RegExp(r'^\d')) && int.tryParse(event.email) == null) {
      emit(ForgotPasswordFailure('Invalid phone number'));
    }
    else {
      emit(ForgotPasswordFailure('Invalid email format!'));
    }
    



   
  }

  FutureOr<void> _onTransition(ForgotPasswordTransition event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordSuccess(super.state.email!));
  }

  FutureOr<void> _onVerificationRequested(VerificationRequested event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    
    await Future.delayed(const Duration(seconds: 2), () {
     
    });
    if (event.code =='1234') {
      emit(VerificationSuccess());
    } else {
      emit(ForgotPasswordFailure('Invalid code'));
    }
  }
}
