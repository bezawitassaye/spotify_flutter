import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify/core/common/entities/user.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());
}
