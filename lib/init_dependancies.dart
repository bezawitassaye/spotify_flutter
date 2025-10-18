import 'package:get_it/get_it.dart';
import 'package:spotify/core/secrets/app_secrets.dart';
import 'package:spotify/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:spotify/features/auth/data/repositories/auth_repostory_implment.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_in.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_up.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supbase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supbase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplement(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepostoryImplment(serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));

  serviceLocator.registerLazySingleton(
    () => AuthBlocBloc(userSignUp: serviceLocator(), userLogin: serviceLocator()),
  );
}
