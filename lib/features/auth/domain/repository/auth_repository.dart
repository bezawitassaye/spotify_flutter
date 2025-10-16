import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';

abstract interface class AuthRepository {
  Either<Failures,String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password
  });
}
