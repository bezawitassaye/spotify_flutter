import 'package:spotify/core/error/exceptions.dart';
import 'package:spotify/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session? get currentSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel?> getCurrentUserData();
}

class AuthRemoteDataSourceImplement implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImplement(this.supabaseClient);

  @override
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
     try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
        
      );

      // If user is null, likely email confirmation required
      if (response.user == null) {
        throw ServerException('User is null');
      }

      // Successful signup
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      // Catch all other exceptions
      throw ServerException(e.toString());
    }
    
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signUp(
        email: email,
        password: password,
        data: {'name': name},
      );

      // If user is null, likely email confirmation required
      if (response.user == null) {
        throw ServerException('User is null');
      }

      // Successful signup
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      // Catch all other exceptions
      throw ServerException(e.toString());
    }
  }
  
  @override
  
  Session? get currentSession => supabaseClient.auth.currentSession;
  
  @override
  Future<UserModel?> getCurrentUserData() async {
    try{
      if (currentSession != null) {
        final userData = await supabaseClient.from('profiles').select().eq(
        'id', currentSession!.user.id);
        return UserModel.fromJson(userData.first);
      }
      return null;
      
    }catch(e){
      throw ServerException(e.toString());
    }
    
  }
}
