import 'package:get_it/get_it.dart';
import 'package:spotify/core/secrets/app_secrets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
final serviceLocator= GetIt.instance;

Future<void> initDependencies() async {
  final supbase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.anonKey,
  );
}
