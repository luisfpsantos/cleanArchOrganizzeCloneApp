import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/login_repository.dart';
import 'package:organizze_app/app/modules/login/domain/usecases/login_usecase/login_usecase.dart';

class LoginUsecaseImp implements LoginUsecase {
  final LoginRepository _loginRepository;

  LoginUsecaseImp(this._loginRepository);

  @override
  Future<Either<LoginErrors, UserEntity>> call(
    String user,
    String password,
  ) async {
    if (user.isEmpty || password.isEmpty) {
      return left(UserOrPasswordInvalid('User or Password is empty'));
    }

    if (user.length <= 3 || password.length <= 3) {
      return left(UserOrPasswordInvalid(
          'User or Password is smaller than 3 characters'));
    }

    return await _loginRepository.logIn(user, password);
  }
}
