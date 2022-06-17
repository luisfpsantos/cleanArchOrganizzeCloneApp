import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/errors/verify_login_errors.dart';

abstract class VerifyLoginRepository {
  Future<Either<VerifyLoginErrors, bool>> call(String user, String password);
}
