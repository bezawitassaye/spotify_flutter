import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';

class AuthRepostoryImplment implements AuthRepository {
  @override
  Future<Either<Failures, String>> signInWithEmailPassword({required String email, required String password}) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, String>> signUpWithEmailPassword({required String name, required String email, required String password}) {
    // TODO: implement signUpWithEmailPassword
    throw UnimplementedError();
  }
}