import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:spotify/features/auth/domain/entities/user.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';

class AuthRepostoryImplment implements AuthRepository {
  
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepostoryImplment(this.remoteDataSource);

  @override
  Future<Either<Failures, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try{
      final userId = await remoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,);
        
        return right(userId);
    } on ServerException catch(e){
         return left(Failures(e.message));
    }
  }
}
