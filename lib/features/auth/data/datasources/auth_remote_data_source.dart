import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImplement implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourceImplement(this.supabaseClient);
  @override
  Future<String> signInWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement signInWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try{
     final response = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data:
        {'name':name },
        );
        
        if(response.user == null){

        }
        return response.user!.id;

    }catch(e){

    }
   
  }
}
