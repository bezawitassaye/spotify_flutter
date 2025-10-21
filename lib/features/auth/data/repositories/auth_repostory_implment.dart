import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/core/error/failures.dart';
import 'package:spotify/core/network/conncetion_checker.dart';
import 'package:spotify/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:spotify/core/common/entities/user.dart';
import 'package:spotify/features/auth/data/models/user_model.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepostoryImplment implements AuthRepository {
  final ConnectionChecker connectionChecker;
  final AuthRemoteDataSource remoteDataSource;
  const AuthRepostoryImplment(this.remoteDataSource, this.connectionChecker);

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
      if(!await connectionChecker.isConnected){
        return left(Failures('No internet connection'));
      }
      final user = await fn();
      return right(user);
    } on sb.AuthException catch(e){
         return left(Failures(e.message));
    }
    
    on ServerException catch(e){
         return left(Failures(e.message));
    }

  }
  
  @override
  Future<Either<Failures, User>> currentUser() async {
    try{
      if (!await (connectionChecker.isConnected)) {
        final session = remoteDataSource.currentSession;

        if (session == null) {
          return left(Failures('User not logged in!'));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSource.getCurrentUserData();
      if (user == null) {
        return left(Failures('user not logged in'));
      }
      return right(user);
    } on ServerException catch(e){
         return left(Failures(e.message));
    }
   
  }
}
