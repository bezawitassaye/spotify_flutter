import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository authrepostory;
  const UserSignUp(this.authrepostory);

  @override
  Future<Either<Failures, String>> call(UserSignUpParams params) async {
    return await authrepostory.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String name;

  UserSignUpParams(this.email, this.password, this.name);
}
