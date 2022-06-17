import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/entities/login_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/save_login_local_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/save_login_local_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/save_login_local_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/save_login_local_repository_imp.dart';

class DatasourceMock extends Mock implements SaveLoginLocalDatasource {}

void main() {
  late DatasourceMock datasource;
  late SaveLoginLocalRepository repository;

  setUpAll(() {
    registerFallbackValue(
      LoginEntity(password: 'password', user: 'user', rememberMe: false),
    );
  });

  setUp(() {
    datasource = DatasourceMock();
    repository = SaveLoginLocalRepositoryImp(datasource);
  });

  test('should return true, user saved locally', () async {
    when(() => datasource(any())).thenAnswer((_) async => true);

    var result = await repository(
      LoginEntity(password: 'password', user: 'user', rememberMe: false),
    );

    expect(result.fold(id, id), true);
  });

  test('should return save error', () async {
    when(() => datasource(any())).thenThrow(UnableToSaveLoginLocal('test'));

    var result = await repository(
      LoginEntity(password: 'password', user: 'user', rememberMe: false),
    );

    expect(result.fold(id, id), isA<UnableToSaveLoginLocal>());
  });

  test('should return unknown repository error', () async {
    when(() => datasource(any())).thenThrow(Exception('test'));

    var result = await repository(
      LoginEntity(password: 'password', user: 'user', rememberMe: false),
    );

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
