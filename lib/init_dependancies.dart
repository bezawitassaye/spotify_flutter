import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:spotify/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:spotify/core/network/conncetion_checker.dart';
import 'package:spotify/core/secrets/app_secrets.dart';
import 'package:spotify/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:spotify/features/auth/data/repositories/auth_repostory_implment.dart';
import 'package:spotify/features/auth/domain/repository/auth_repository.dart';
import 'package:spotify/features/auth/domain/usecase/current_user.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_in.dart';
import 'package:spotify/features/auth/domain/usecase/user_sign_up.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:spotify/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:spotify/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:spotify/features/blog/domain/repositories/blog_repository.dart';
import 'package:spotify/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:spotify/features/blog/domain/usecases/upload_blog.dart';
import 'package:spotify/features/blog/presentation/bloc/blog_bloc_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supbase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
  serviceLocator.registerLazySingleton(() => supbase.client);
  serviceLocator.registerLazySingleton(() => AppUserCubit(),);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImplement(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepostoryImplment(serviceLocator(), serviceLocator()),
  );

  serviceLocator.registerFactory(() => UserSignUp(serviceLocator()));
  serviceLocator.registerFactory(() => UserLogin(serviceLocator()));
  serviceLocator.registerFactory(()=>CurrentUser(serviceLocator()));
  
  
  serviceLocator.registerLazySingleton(
    () => AuthBlocBloc(
      userSignUp: serviceLocator(), 
      userLogin: serviceLocator(),
      currentUser: serviceLocator(),
      appUserCubit: serviceLocator(),
      ),
  );
}

void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImplementation(serviceLocator()),
  );

  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(serviceLocator()),
  );

  serviceLocator.registerFactory(() =>  InternetConnection());

  serviceLocator.registerFactory(() => UploadBlog(serviceLocator()));

  serviceLocator.registerFactory(()=> GetAllBlogs(serviceLocator()));

  serviceLocator.registerFactory<ConnectionChecker>(() => ConnectionCheckerImpl(serviceLocator())); 
  serviceLocator.registerLazySingleton(
    () => BlogBlocBloc(getAllBlogs: serviceLocator(), uploadBlog: serviceLocator()),
  );


}
