import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/modules/login/domain/repositories/verify_login_repository.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/verify_login_datasource.dart';
import 'package:organizze_app/app/modules/login/infra/repositories/verify_login_repository_imp.dart';

class DatasourceMock extends Mock implements VerifyLoginDatasource {}

void main() {
  late DatasourceMock datasource;
  late VerifyLoginRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = VerifyLoginRepositoryImp(datasource);
  });

  test('should return true, user authenticated', () async {
    when(() => datasource(any(), any())).thenAnswer((_) async => true);

    var result = await repository('luis', '1212');

    expect(result.fold(id, id), true);
  });

  test('should return UserOrPasswordInvalid', () async {
    when(() => datasource(any(), any())).thenThrow(
      UserOrPasswordInvalid('user not found'),
    );

    var result = await repository('luis', '1212');

    expect(result.fold(id, id), isA<UserOrPasswordInvalid>());
  });

  test('should return a unknown error', () async {
    when(() => datasource(any(), any())).thenThrow(Exception());

    var result = await repository('luis', '1212');

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
