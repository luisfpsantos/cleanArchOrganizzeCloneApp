import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/entities/user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/login_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/login_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/login_repository.dart';

class LoginDatasourceMock extends Mock implements LoginDatasource {}

void main() {
  late LoginRepository loginRepository;
  late LoginDatasource loginDatasource;

  setUp(() {
    loginDatasource = LoginDatasourceMock();
    loginRepository = LoginRepositoryImp(loginDatasource);
  });

  test('Should return UserEntity when login success', () async {
    when(() => loginDatasource(any(), any())).thenAnswer(
      (_) async => {
        'userID': 'id',
        'user': {
          'name': 'name',
          'user': 'user',
          'authenticated': true,
          'userId': 'userId',
          'accessGroup': 'accessLevel'
        }
      },
    );

    final result = await loginRepository.logIn('user', 'password');

    expect(result.fold(id, id), isA<UserEntity>());
  });

  test('should return UserOrPasswordInvalid when user is not found', () async {
    when(() => loginDatasource(any(), any())).thenThrow(
      UserOrPasswordInvalid('error'),
    );

    final result = await loginRepository.logIn('user', 'password');

    expect(result.fold(id, id), isA<UserOrPasswordInvalid>());
  });
}
