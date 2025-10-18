import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/core/common/entities/user.dart';
import 'package:spotify/features/auth/domain/usecase/current_user.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_in.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_up.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBlocBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthBlocInitial()) {
    on<AuthBlocEvent>((_,emit) => emit(AuthLoading()));    
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthBlocState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold((l) => emit(AuthFailure(l.message)), (r) {
      print(r.name);
      emit(AuthSuccess(r));
    });
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
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }

  void _onAuthLogin(AuthLogin event, Emitter<AuthBlocState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (user) => _emitAuthSuccess(user,emit),
    );
  }
  
  void _emitAuthSuccess(
    User user,
    Emitter<AuthBlocState> emit,

  ){
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }

}
