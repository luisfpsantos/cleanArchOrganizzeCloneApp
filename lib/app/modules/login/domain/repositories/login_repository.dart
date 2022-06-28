import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';

abstract class LoginRepository {
  Future<Either<LoginErrors, UserEntity>> logIn(String user, String password);
}
