import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/login/infra/repositories/save_login_local_repository_imp.dart';

class DatasourceMock extends Mock implements SaveLoginLocalDatasource {}

void main() {
  final datasource = DatasourceMock();
  final repository = SaveLoginLocalRepositoryImp(datasource);

  test('should return true, user saved locally', () async {
    LoginEntity login =
        LoginEntity(password: 'password', user: 'user', rememberMe: false);

    when(() => datasource(login)).thenAnswer((_) async => true);

    var result = await repository(login);

    expect(result.fold(id, id), true);
  });

  test('should return save error', () async {
    LoginEntity login =
        LoginEntity(password: 'password', user: 'user', rememberMe: false);

    when(() => datasource(login)).thenThrow(UnableToSaveLoginLocal('test'));

    var result = await repository(login);

    expect(result.fold(id, id), isA<UnableToSaveLoginLocal>());
  });

  test('should return unknown repository error', () async {
    LoginEntity login =
        LoginEntity(password: 'password', user: 'user', rememberMe: false);

    when(() => datasource(login)).thenThrow(Exception('test'));

    var result = await repository(login);

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
