import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_credit_card_usecase/add_account_usecase_imp.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_credit_card_usecase/add_credit_card_usecase.dart';

class RepositoryMock extends Mock implements AccountsRepository {}

void main() {
  late AccountsRepository repository;
  late AddCreditCardUsecase usecase;

  setUpAll(() {
    registerFallbackValue(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: '',
      ),
    );
  });

  setUp(() {
    repository = RepositoryMock();
    usecase = AddCreditCardUsecaseImp(repository);
  });

  test('should return true when credit card is added', () async {
    when(() => repository.addCreditCard(any(), any())).thenAnswer(
      (_) async => right(true),
    );

    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), true);
  });

  test('should return invalid argument when name is not provided', () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: '',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'name credit card is necessary');
  });

  test('should return invalid argument when icon is not provided', () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: 's', path: ''),
        limit: 1,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'icon is necessary');
  });

  test('should return invalid argument when closed day is equal 0', () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 0,
        dueDay: 1,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'closed day is invalid');
  });

  test('should return invalid argument when closed day greater than 31',
      () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 312,
        dueDay: 1,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'closed day is invalid');
  });

  test('should return invalid argument when due Day is equal 0', () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 0,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'due day is invalid');
  });

  test('should return invalid argument when due Day greater than 31', () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 32,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 1,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'due day is invalid');
  });

  test('should return invalid argument when limit is equal 0', () async {
    final result = await usecase(
      CreditCardEntity(
        id: '',
        closedDay: 1,
        dueDay: 1,
        icon: IconEntity(name: 's', path: 'a'),
        limit: 0,
        name: 'a',
      ),
      'userID',
    );

    expect(result.fold(id, id), isA<InvalidArgument>());
    expect(result.fold((l) => l.msg, id), 'limit is invalid');
  });
}
