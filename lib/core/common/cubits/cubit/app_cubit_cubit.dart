import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'app_cubit_state.dart';

class AppCubitCubit extends Cubit<AppCubitState> {
  AppCubitCubit() : super(AppCubitInitial());
}
