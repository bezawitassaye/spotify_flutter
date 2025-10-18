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
  }) async {
    return  _getUser(
      () async => await remoteDataSource.signInWithEmailPassword(
      email: email,
      password: password,
    ));
    
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(() => remoteDataSource.signUpWithEmailPassword(
      name: name,
      email: email,
      password: password,
    ));
    
  }

  Future<Either<Failures,User>> _getUser(
    Future<User> Function() fn,
  ) async{
    try{
      final user = await fn();
        
        
        return right(user);
    } on ServerException catch(e){
         return left(Failures(e.message));
    }

  }
}
