import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/auth/domain/entities/user.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failures, User?>> currentUser();
}
