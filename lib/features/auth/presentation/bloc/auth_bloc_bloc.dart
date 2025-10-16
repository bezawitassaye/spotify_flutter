import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  AuthBlocBloc({required UserSignUp userSignUp})
    : _userSignUp = userSignUp,
      super(AuthBlocInitial()) {
    on<AuthSignUp>((event, emit) => {});
  }
}
