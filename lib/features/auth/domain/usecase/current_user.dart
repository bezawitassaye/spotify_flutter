import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/auth/domain/entities/user.dart';


class CurrentUser implements UseCase<User, NoParams> {
  @override
  Future<Either<Failures, User>> call(NoParams params) {
    
  }
}

