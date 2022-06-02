import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/get_list_entry_errors.dart';
import 'package:organizze_app/app/entries/domain/repositories/get_list_entry_repository.dart';
import 'package:organizze_app/app/entries/infra/datasources/get_list_entry_datasource.dart';
import 'package:organizze_app/app/entries/infra/dtos/entry_dto.dart';
import 'package:organizze_app/app/entries/infra/repositories/get_list_entry_repository_imp.dart';

class DatasourceMock extends Mock implements GetListEntryDatasource {}

void main() {
  late GetListEntryDatasource datasource;
  late GetListEntryRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = GetListEntryRepositoryImp(datasource);
  });

  test('should return List of EntryEntity', () async {
    when(() => datasource()).thenAnswer((_) async => <EntryDto>[]);

    final result = await repository();

    expect(result.fold(id, id), isA<List<EntryEntity>>());
  });

  test('should return error when datasource not found any entry', () async {
    when(() => datasource()).thenThrow(NoEntryFound('test'));

    final result = await repository();

    expect(result.fold(id, id), isA<NoEntryFound>());
  });

  test('should return error when datasource return unknown error', () async {
    when(() => datasource()).thenThrow(Exception('test'));

    final result = await repository();

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
