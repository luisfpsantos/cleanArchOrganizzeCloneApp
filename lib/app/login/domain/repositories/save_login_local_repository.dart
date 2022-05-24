import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/save_login_local_errors.dart';

abstract class SaveLoginLocalRepository {
  Future<Either<SaveLoginLocalErrors, bool>> call(LoginEntity login);
}
