import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_credit_card_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_credit_card_usecase/edit_credit_card_usecase.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_credit_card_usecase/edit_credit_card_usecase_imp.dart';

class AccountsRepositoryMock extends Mock implements AccountsRepository {}

void main() {
  late AccountsRepository repository;
  late EditCreditCardUsecase usecase;

  setUp(() {
    repository = AccountsRepositoryMock();
    usecase = EditCreditCardUsecaseImp(repository);
  });

  registerFallbackValue(
    CreditCardEntity(
      id: '',
      closedDay: 1,
      dueDay: 1,
      icon: IconEntity(name: '', path: ''),
      limit: 1,
      name: '',
    ),
  );

  test('should return true when account is updated', () async {
    when(() => repository.editCreditCard(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: '', path: 'a'),
        limit: 1,
        name: 'name',
      ),
      'userId',
    );

    expect(result.fold(id, id), true);
  });

  test('should return error when arguments is invalid', () async {
    when(() => repository.editCreditCard(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: '', path: ''),
        limit: 1,
        name: '',
      ),
      'userId',
    );

    expect(result.fold(id, id), isA<EditCreditCardInvalidArgument>());
  });
}
