import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/add_account_repository.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/repositories/add_account_repository_imp.dart';

class DatasourceMock extends Mock implements AddAccountDatasource {}

void main() {
  late AddAccountDatasource datasource;
  late AddAccountRepository repository;

  setUpAll(() {
    registerFallbackValue(AccountEntity(balance: 1, iconPath: '', name: ''));
  });

  setUp(() {
    datasource = DatasourceMock();
    repository = AddAccountRepositoryImp(datasource);
  });

  test('should return true when account is added', () async {
    when(() => datasource(any(), any())).thenAnswer((_) async => true);

    final result = await repository(
        AccountEntity(name: '', balance: 1, iconPath: ''), 'userId');

    expect(result.fold(id, id), true);
  });

  test('should return addError when datasource is incapable to add', () async {
    when(() => datasource(any(), any())).thenThrow(AddError('test'));

    final result = await repository(
        AccountEntity(name: '', balance: 1, iconPath: ''), 'userId');

    expect(result.fold(id, id), isA<AddError>());
  });

  test('should return account already exists', () async {
    when(() => datasource(any(), any()))
        .thenThrow(AccountAlreadyExists('test'));

    final result = await repository(
        AccountEntity(name: '', balance: 1, iconPath: ''), 'userId');

    expect(result.fold(id, id), isA<AccountAlreadyExists>());
  });

  test('should return RepositoryError when datasource throw unknown error',
      () async {
    when(() => datasource(any(), any())).thenThrow(Exception('asdfasdf'));

    final result = await repository(
        AccountEntity(name: '', balance: 1, iconPath: ''), 'userId');

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
