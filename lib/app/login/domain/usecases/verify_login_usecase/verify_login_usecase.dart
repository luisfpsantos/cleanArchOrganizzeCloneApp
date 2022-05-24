import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';

abstract class VerifyLoginUsecase {
  Future<Either<VerifyLoginErrors, bool>> call(String user, String password);
}
