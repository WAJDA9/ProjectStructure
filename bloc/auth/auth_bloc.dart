import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:physio_app/Repositories/user_repository.dart';
import 'package:physio_app/models/user.dart';

// Parts for Auth events and states
part 'auth_event.dart';
part 'auth_state.dart';

// Authentication Bloc handling authentication-related events and states
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository userRepository;
  AuthBloc(this.userRepository) : super(const AuthInitial()) {
    // Registering event handlers
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<ChangeStayConnected>(_onStayConnected);
    on<ChangePasswordShown>(_onPasswordShown);
  }

  // Handler for stay connected checkbox state change
  void _onStayConnected(
    ChangeStayConnected event,
    Emitter<AuthState> emit,
  ) {
    emit(StayConnected(event.stayConnected));
  }

  // Handler for login request event
  void _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final email = event.email;
      final password = event.password;

      // Email validation regex
      final emailRegex = RegExp(
          r'^[\w-]+([._]?[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
      if (!emailRegex.hasMatch(email)) {
        return emit(const AuthFailure('Invalid email format!'));
      }

      if (password.length < 6) {
        return emit(const AuthFailure('Please enter a valid password!'));
      }

      // API Call   
      try{
        final user = await userRepository.login(email, password);
        userRepository.saveUser(user);
        return emit(AuthSuccess(uid:user));
      }
      catch(e){
        return emit(AuthFailure(e.toString()));
      }
    } catch (e) {
      return emit(AuthFailure(e.toString()));
    }
  }

  // Handler for logout request event
  void _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // logout API call
      await userRepository.logout();
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // Handler for showing/hiding password
  void _onPasswordShown(ChangePasswordShown event, Emitter<AuthState> emit) {
    emit(PasswordShown(event.showPassword));
  }
}
