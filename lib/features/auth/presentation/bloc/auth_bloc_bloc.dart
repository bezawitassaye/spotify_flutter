import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/auth/domain/entities/user.dart';
import 'package:spotify/features/auth/domain/usecase/current_user.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_in.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  AuthBlocBloc(
    {required UserSignUp userSignUp, required UserLogin userLogin,required CurrentUser currentUser})
    : _userSignUp = userSignUp,
      _userLogin = userLogin,
      _currentUser = currentUser,
      super(AuthBlocInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(AuthIsUserLoggedIn event,Emitter<AuthBlocState> emit) async{
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(l.message)),
    (r) => emit(AuthSuccess(r)));
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSuccess(user)));
  }

  void _onAuthLogin(
      AuthLogin event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSuccess(user)));
  }

}


