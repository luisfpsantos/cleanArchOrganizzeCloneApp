import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/repositories/get_list_entry_repository.dart';
import 'package:organizze_app/app/entries/domain/usecases/get_list_entry_usecase/get_list_entry_usecase.dart';
import 'package:organizze_app/app/entries/domain/usecases/get_list_entry_usecase/get_list_entry_usecase_imp.dart';
import 'package:organizze_app/app/entries/infra/dtos/entry_dto.dart';

class RepositoryMock extends Mock implements GetListEntryRepository {}

void main() {
  late GetListEntryRepository repository;
  late GetListEntryUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = GetListEntryUsecaseImp(repository);
  });

  test('should return list of entryEntity', () async {
    when(() => repository()).thenAnswer((_) async => right(<EntryDto>[]));

    final result = await usecase();

    expect(result.fold(id, id), isA<List<EntryEntity>>());
  });
}
