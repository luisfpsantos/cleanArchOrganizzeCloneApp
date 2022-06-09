import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_local_errors.dart';

abstract class GetUserLocalUsecase {
  Future<Either<GetUserLocalErrors, LoginEntity>> call();
}
