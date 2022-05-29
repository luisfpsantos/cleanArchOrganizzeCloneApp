import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/accounts/domain/repositories/add_account_repository.dart';
import 'package:organizze_app/app/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';
import 'package:organizze_app/app/accounts/domain/usecases/add_account_usecase/add_account_usecase_imp.dart';

class RepositoryMock extends Mock implements AddAccountRepository {}

void main() {
  late AddAccountRepository repository;
  late AddAccountUsecase usecase;

  setUpAll(() {
    registerFallbackValue(AccountEntity(balance: 1, iconPath: '', name: ''));
  });

  setUp(() {
    repository = RepositoryMock();
    usecase = AddAccountUsecaseImp(repository);
  });

  test('should return true when account is added', () async {
    when(() => repository(any())).thenAnswer((_) async => right(true));

    final result = await usecase(
        AccountEntity(balance: 1, iconPath: '/a/a', name: 'name'));

    expect(result.fold(id, id), true);
  });

  test('should return invalid argument when name is not provided', () async {
    final result =
        await usecase(AccountEntity(balance: 1, iconPath: '/a/a', name: ''));

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'name account is necessary');
  });

  test('should return invalid argument when icon is not provided', () async {
    final result =
        await usecase(AccountEntity(balance: 1, iconPath: '', name: 'test'));

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'icon is necessary');
  });
}
