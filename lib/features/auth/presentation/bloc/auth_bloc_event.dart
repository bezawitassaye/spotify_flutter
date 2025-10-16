part of 'auth_bloc_bloc.dart';

@immutable
sealed class AuthBlocEvent {}

final class AuthSignUp extends AuthBlocEvent{
  final String email;
  final String password;
  final String name;

  AuthSignUp(
    this.email, 
    this.password, 
    this.name);
  
}
