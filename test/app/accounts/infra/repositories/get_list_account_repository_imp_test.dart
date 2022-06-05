import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_account_repository.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/accounts/infra/repositories/get_list_account_repository_imp.dart';

class DatasourceMock extends Mock implements GetListAccountDatasource {}

void main() {
  late GetListAccountDatasource datasource;
  late GetListAccountRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = GetListAccountRepositoryImp(datasource);
  });

  test('should return list of AccountEntity', () async {
    when(() => datasource(any())).thenAnswer((_) async => <AccountEntity>[]);

    final result = await repository('userId');

    expect(result.fold(id, id), isA<List<AccountEntity>>());
  });

  test('should return error when not found any account', () async {
    when(() => datasource(any())).thenThrow(NoAccountsFound('test'));

    final result = await repository('userId');

    expect(result.fold(id, id), isA<NoAccountsFound>());
  });

  test('should return repository error when data source throw unknown error',
      () async {
    when(() => datasource(any())).thenThrow(Exception('test'));

    final result = await repository('userId');

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
