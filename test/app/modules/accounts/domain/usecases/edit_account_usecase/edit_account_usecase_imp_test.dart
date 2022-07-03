import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_account_usecase/edit_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_account_usecase/edit_account_usecase_imp.dart';

class RepositoryMock extends Mock implements AccountsRepository {}

void main() {
  late AccountsRepository repository;
  late EditAccountUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = EditAccountUsecaseImp(repository);
  });

  registerFallbackValue(AccountEntity(
      id: '', balance: 1, icon: IconEntity(name: '', path: ''), name: ''));

  test('should return true when account is updated', () async {
    when(() => repository.editAccount(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase(
      AccountEntity(
          id: '',
          balance: 1,
          icon: IconEntity(name: '', path: 'aa'),
          name: 'aa'),
      'userId',
    );

    expect(result.fold(id, id), true);
  });

  test('should return error when arguments is invalid', () async {
    when(() => repository.editAccount(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase(
      AccountEntity(
          id: '', balance: 1, icon: IconEntity(name: '', path: ''), name: ''),
      'userId',
    );

    expect(result.fold(id, id), isA<EditAccountInvalidArgument>());
  });
}
