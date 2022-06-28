import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/repositories/accounts_repository_imp.dart';

class AddAccountDatasourceMock extends Mock implements AddAccountDatasource {}

class AddCreditCardDatasourceMock extends Mock
    implements AddCreditCardDatasource {}

class GetListAccountDatasourceMock extends Mock
    implements GetListAccountDatasource {}

class GetListCreditCardDatasourceMock extends Mock
    implements GetListCreditCardDatasource {}

class GetListIconsDatasourceMock extends Mock
    implements GetListIconsDatasource {}

void main() {
  late AddAccountDatasource addAccountDatasource;
  late AddCreditCardDatasource addCreditCardDatasource;
  late GetListAccountDatasource getListAccountDatasource;
  late GetListCreditCardDatasource getListCreditCardDatasource;
  late GetListIconsDatasource getListIconsDatasource;
  late AccountsRepository repository;

  setUp(() {
    addAccountDatasource = AddAccountDatasourceMock();
    addCreditCardDatasource = AddCreditCardDatasourceMock();
    getListAccountDatasource = GetListAccountDatasourceMock();
    getListCreditCardDatasource = GetListCreditCardDatasourceMock();
    getListIconsDatasource = GetListIconsDatasourceMock();

    repository = AccountsRepositoryImp(
      addAccountDatasource,
      addCreditCardDatasource,
      getListAccountDatasource,
      getListCreditCardDatasource,
      getListIconsDatasource,
    );
  });

  group('addAccount', () {
    test('should return true when account is added', () async {
      when(() => addAccountDatasource(any(), any())).thenAnswer(
        (_) async => true,
      );

      final result = await repository.addAccount(
        AccountEntity(
          balance: 1,
          icon: IconEntity(name: 'a', path: '/n'),
          name: 'a',
        ),
        'userId',
      );

      expect(result.fold(id, id), true);
    });

    test('should return addError when datasource is incapable to add',
        () async {
      when(() => addAccountDatasource(any(), any())).thenThrow(
        AddAccountError('test'),
      );

      final result = await repository.addAccount(
        AccountEntity(
          balance: 1,
          icon: IconEntity(name: 'a', path: '/n'),
          name: 'a',
        ),
        'userId',
      );

      expect(result.fold(id, id), isA<AddAccountError>());
    });

    test('should return account already exists', () async {
      when(() => addAccountDatasource(any(), any())).thenThrow(
        AccountAlreadyExists('test'),
      );

      final result = await repository.addAccount(
        AccountEntity(
          balance: 1,
          icon: IconEntity(name: 'a', path: '/n'),
          name: 'a',
        ),
        'userId',
      );

      expect(result.fold(id, id), isA<AccountAlreadyExists>());
    });
  });

  group('addCreditCard', () {
    test('should return true when credit card is added', () async {
      when(() => addCreditCardDatasource(any(), any())).thenAnswer(
        (_) async => true,
      );

      final result = await repository.addCreditCard(
        CreditCardEntity(
          closedDay: 1,
          dueDay: 1,
          icon: IconEntity(name: 's', path: 'a'),
          limit: 1,
          name: '',
        ),
        'userID',
      );

      expect(result.fold(id, id), true);
    });

    test('should return addError when datasource is incapable to add',
        () async {
      when(() => addCreditCardDatasource(any(), any())).thenThrow(
        AddCreditCardError('test'),
      );

      final result = await repository.addCreditCard(
        CreditCardEntity(
          closedDay: 1,
          dueDay: 1,
          icon: IconEntity(name: 's', path: 'a'),
          limit: 1,
          name: '',
        ),
        'userID',
      );

      expect(result.fold(id, id), isA<AddCreditCardError>());
    });

    test('should return credit card already exists', () async {
      when(() => addCreditCardDatasource(any(), any())).thenThrow(
        CreditCardAlreadyExists('test'),
      );

      final result = await repository.addCreditCard(
        CreditCardEntity(
          closedDay: 1,
          dueDay: 1,
          icon: IconEntity(name: 's', path: 'a'),
          limit: 1,
          name: '',
        ),
        'userID',
      );

      expect(result.fold(id, id), isA<CreditCardAlreadyExists>());
    });
  });

  group('getAccounts', () {
    test('should return list of AccountEntity', () async {
      when(() => getListAccountDatasource(any())).thenAnswer(
        (_) async => <Map>[],
      );

      final result = await repository.getAccounts('userId');

      expect(result.fold(id, id), isA<List<AccountEntity>>());
    });

    test('should return error when not found any account', () async {
      when(() => getListAccountDatasource(any())).thenThrow(
        NoAccountsFound('test'),
      );

      final result = await repository.getAccounts('userId');

      expect(result.fold(id, id), isA<NoAccountsFound>());
    });
  });

  group('getCreditCards', () {
    test('should return list of CreditCardEntity', () async {
      when(() => getListCreditCardDatasource(any())).thenAnswer(
        (_) async => <Map>[],
      );

      final result = await repository.getCreditCards('userId');

      expect(result.fold(id, id), isA<List<CreditCardEntity>>());
    });

    test('should return error when not found any creditCard', () async {
      when(() => getListCreditCardDatasource(any())).thenThrow(
        NoCreditCardFound('test'),
      );

      final result = await repository.getCreditCards('userId');

      expect(result.fold(id, id), isA<NoCreditCardFound>());
    });
  });
}
