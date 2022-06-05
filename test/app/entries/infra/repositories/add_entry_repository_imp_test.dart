import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/add_entry_errors.dart';
import 'package:organizze_app/app/entries/domain/repositories/add_entry_repository.dart';
import 'package:organizze_app/app/entries/infra/datasources/add_entry_datasource.dart';
import 'package:organizze_app/app/entries/infra/repositories/add_entry_repository_imp.dart';

class DatasourceMock extends Mock implements AddEntryDatasource {}

void main() {
  late AddEntryDatasource datasource;
  late AddEntryRepository repository;

  setUpAll(() {
    registerFallbackValue(EntryEntity(
      date: DateTime.now(),
      amount: 1,
      category: '',
      description: '',
      entryType: '',
      status: '',
      accountType: '',
    ));
  });

  setUp(() {
    datasource = DatasourceMock();
    repository = AddEntryRepositoryImp(datasource);
  });

  test('should return true when add sucess', () async {
    when(() => datasource(any(), any())).thenAnswer((_) async => true);

    final result = await repository(
      EntryEntity(
        date: DateTime.now(),
        amount: 1,
        category: 'a',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), true);
  });

  test('should return error when datasource is incapable to add', () async {
    when(() => datasource(any(), any())).thenThrow(AddError('test'));

    final result = await repository(
      EntryEntity(
        date: DateTime.now(),
        amount: 1,
        category: 'a',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<AddError>());
  });

  test('should return repository error when datasource throw a unknown error',
      () async {
    when(() => datasource(any(), any())).thenThrow(Exception('test'));

    final result = await repository(
      EntryEntity(
        date: DateTime.now(),
        amount: 1,
        category: 'a',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
