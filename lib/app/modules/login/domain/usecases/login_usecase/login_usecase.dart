import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';

abstract class LoginUsecase {
  Future<Either<LoginErrors, UserEntity>> call(String user, String password);
}
