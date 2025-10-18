part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}


final class AuthLoading extends AuthBlocState{}

final class AuthSuccess extends AuthBlocState{
  final User user;
  AuthSuccess(this.user);
}

final class AuthFailure extends AuthBlocState{
  final String message ;
  AuthFailure(this.message);
}