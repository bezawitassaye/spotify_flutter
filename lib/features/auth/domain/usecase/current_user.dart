import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/core/usecase/usecase.dart';
import 'package:spotify/features/auth/domain/entities/user.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';


class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepostory;
  CurrentUser(this.authRepostory);
  @override
  Future<Either<Failures, User>> call(NoParams params) async {
    return await authRepostory.currentUser();
    
  }
}

