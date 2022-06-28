import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/login_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/dtos/user_dto.dart';

class LoginRepositoryImp implements LoginRepository {
  final LoginDatasource _loginDatasource;

  LoginRepositoryImp(
    this._loginDatasource,
  );

  @override
  Future<Either<LoginErrors, UserEntity>> logIn(
    String user,
    String password,
  ) async {
    try {
      final result = await _loginDatasource(user, password);

      if (result['user']['authenticated']) {
        return right(
          UserDto.fromMap({
            'name': result['user']['name'],
            'user': result['user']['user'],
            'authenticated': result['user']['authenticated'],
            'accessGroup': result['user']['accessGroup'],
            'userId': result['userID']
          }),
        );
      } else {
        return left(UserNotAuthenticated('user is not authenticated'));
      }
    } on UserOrPasswordInvalid catch (e) {
      return left(e);
    }
  }
}
