import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase_imp.dart';

class RepositoryMock extends Mock implements AccountsRepository {}

void main() {
  late AccountsRepository repository;
  late AddAccountUsecase usecase;

  setUpAll(() {
    registerFallbackValue(AccountEntity(
        balance: 1, icon: IconEntity(name: 'a', path: '/n'), name: ''));
  });

  setUp(() {
    repository = RepositoryMock();
    usecase = AddAccountUsecaseImp(repository);
  });

  test('should return true when account is added', () async {
    when(() => repository.addAccount(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase(
      AccountEntity(
        balance: 1,
        icon: IconEntity(name: 'a', path: '/n'),
        name: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), true);
  });

  test('should return invalid argument when name is not provided', () async {
    final result = await usecase(
      AccountEntity(
        balance: 1,
        icon: IconEntity(name: 'a', path: '/n'),
        name: '',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'name account is necessary');
  });

  test('should return invalid argument when icon is not provided', () async {
    final result = await usecase(
      AccountEntity(
        balance: 1,
        icon: IconEntity(name: 'a', path: ''),
        name: 'a',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'icon is necessary');
  });
}
