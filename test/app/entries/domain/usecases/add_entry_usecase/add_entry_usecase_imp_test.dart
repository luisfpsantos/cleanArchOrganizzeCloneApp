import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/add_entry_errors.dart';
import 'package:organizze_app/app/entries/domain/repositories/add_entry_repository.dart';
import 'package:organizze_app/app/entries/domain/usecases/add_entry_usecase/add_entry_usecase.dart';
import 'package:organizze_app/app/entries/domain/usecases/add_entry_usecase/add_entry_usecase_imp.dart';

class RepositoryMock extends Mock implements AddEntryRepository {}

void main() {
  late AddEntryRepository repository;
  late AddEntryUsecase usecase;

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
    repository = RepositoryMock();
    usecase = AddEntryUsecaseImp(repository);
  });

  test('should return true when add success', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
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

  test('should return error when amount is negative', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
      EntryEntity(
        date: DateTime.now(),
        amount: -1,
        category: 'a',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'amount is invalid');
  });

  test('should return error when amount is zero', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
      EntryEntity(
        date: DateTime.now(),
        amount: 0,
        category: 'a',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'amount is invalid');
  });

  test('should return error when category is empty', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
      EntryEntity(
        date: DateTime.now(),
        amount: 2,
        category: '',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'category is necessary');
  });

  test('should return error when description is empty', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
      EntryEntity(
        date: DateTime.now(),
        amount: 2,
        category: 's',
        description: '',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'desciption is necessary');
  });

  test('should return error when entry type is empty', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
      EntryEntity(
        date: DateTime.now(),
        amount: 2,
        category: 's',
        description: 's',
        entryType: '',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'entry type is necessary');
  });

  test('should return error when status is empty', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    final result = await usecase(
      EntryEntity(
        date: DateTime.now(),
        amount: 2,
        category: 's',
        description: 's',
        entryType: 'sd',
        status: '',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'status is necessary');
  });
}
