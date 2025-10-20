import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:spotify/core/common/cubits/app_user_cubit/app_user_cubit.dart';
import 'package:spotify/core/theme/theme.dart';
import 'package:spotify/features/auth/presentation/bloc/auth_bloc_bloc.dart';
import 'package:spotify/features/auth/presentation/pages/signin_page.dart';
import 'package:spotify/features/blog/presentation/pages/blog_page.dart';
import 'package:spotify/init_dependancies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<AppUserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBlocBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBlocBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, Isloggedin) {
          if(Isloggedin){
            return BlogPage();
            
          }
          return const SignInPage();
        },
      ),
    );
  }
}
