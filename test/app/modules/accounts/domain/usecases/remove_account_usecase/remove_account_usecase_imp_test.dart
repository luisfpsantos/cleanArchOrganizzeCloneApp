import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/remove_account_usecase/remove_account_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/remove_account_usecase/remove_account_usecase_imp.dart';

class RepositoryMock extends Mock implements AccountsRepository {}

void main() {
  late AccountsRepository repository;
  late RemoveAccountUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = RemoveAccountUsecaseImp(repository);
  });

  test('should return true when account is removed', () async {
    when(() => repository.removeAccount(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase('userId', 'accountId');

    expect(result.fold(id, id), true);
  });
}
