import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/domain/repositories/verify_login_repository.dart';
import 'package:organizze_app/app/login/domain/usecases/verify_login_usecase/verify_login_usecase.dart';

class VerifyLoginUsecaseImp implements VerifyLoginUsecase {
  final VerifyLoginRepository _verifyLoginRepository;

  VerifyLoginUsecaseImp(this._verifyLoginRepository);

  @override
  Future<Either<VerifyLoginErrors, bool>> call(
      String user, String password) async {
    if (user.isEmpty || password.isEmpty) {
      return left(UserOrPasswordInvalid('User or Password is empty'));
    }

    if (user.length <= 3 || password.length <= 3) {
      return left(UserOrPasswordInvalid(
          'User or Password is smaller than 3 characters'));
    }

    return await _verifyLoginRepository(user, password);
  }
}
