import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/login/infra/datasources/get_user_in_database_datasource.dart';
import 'package:organizze_app/app/login/infra/dtos/logged_user_dto.dart';
import 'package:organizze_app/app/login/infra/repositories/get_user_in_database_repository_imp.dart';

class DatasourceMock extends Mock implements GetUserInDatabaseDatasource {}

void main() {
  final datasourceMock = DatasourceMock();
  final repository = GetUserInDatabaseRepositoryImp(datasourceMock);

  test('should return LoggedUserEntity', () async {
    when(() => datasourceMock(any())).thenAnswer((_) async =>
        LoggedUserDto(name: 'name', user: 'user', authenticated: true));

    var result = await repository('luis');

    expect(result.fold(id, id), isA<LoggedUserEntity>());
  });

  test('should return error UserNotAuthenticated when authenticated is false',
      () async {
    when(() => datasourceMock(any())).thenAnswer((_) async =>
        LoggedUserDto(name: 'name', user: 'user', authenticated: false));

    var result = await repository('luis');

    expect(result.fold(id, id), isA<UserNotAuthenticated>());
  });

  test(
      'should return error UserNotFound when datasource does not found the user',
      () async {
    when(() => datasourceMock(any())).thenThrow(UserNotFound('test'));

    var result = await repository('luis');

    expect(result.fold(id, id), isA<UserNotFound>());
  });
}