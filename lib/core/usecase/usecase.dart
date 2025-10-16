import 'package:fpdart/fpdart.dart';
import 'package:spotify/core/error/failures.dart';

abstract interface class UseCase<SuccessType,Params> {
  
  Future<Either<Failures,SuccessType>> call(Params params);

}