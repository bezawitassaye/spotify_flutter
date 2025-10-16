import 'package:flutter/material.dart';
import 'package:spotify/core/secrets/app_secrets.dart';
import 'package:spotify/core/theme/theme.dart';
import 'package:spotify/features/auth/presentation/pages/signup_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 final supbase = await Supabase.initialize(url:AppSecrets.supabaseUrl,anonKey:AppSecrets.anonKey );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog App',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
