import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/get_user_local_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/get_user_local_repository_imp.dart';

class DatasourceMock extends Mock implements GetUserLocalDatasource {}

void main() {
  late DatasourceMock datasource;
  late GetUserLocalRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = GetUserLocalRepositoryImp(datasource);
  });

  test('should return LoginEntity', () async {
    when(() => datasource()).thenAnswer((_) async =>
        LoginEntity(password: 'password', user: 'user', rememberMe: true));

    var result = await repository();

    expect(result.fold(id, id), isA<LoginEntity>());
  });

  test('should return error type GetUserLocalErrors', () async {
    when(() => datasource()).thenThrow(LocalUserNotFound('msg'));

    var result = await repository();

    expect(result.fold(id, id), isA<LocalUserNotFound>());
  });

  test('should return repositoryError when the error is unknown', () async {
    when(() => datasource()).thenThrow(Exception('msg'));

    var result = await repository();

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
