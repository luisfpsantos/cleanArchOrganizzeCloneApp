import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_credit_card_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/remove_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/remove_account_datasource.dart';
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

class EditAccountDatasourceMock extends Mock implements EditAccountDatasource {}

class RemoveAccountDatasourceMock extends Mock
    implements RemoveAccountDatasource {}

class EditCreditCardDatasourceMoc extends Mock
    implements EditCreditCardDatasource {}

void main() {
  late EditCreditCardDatasource editCreditCardDatasource;
  late RemoveAccountDatasource removeAccountDatasource;
  late EditAccountDatasource editAccountDatasource;
  late AddAccountDatasource addAccountDatasource;
  late AddCreditCardDatasource addCreditCardDatasource;
  late GetListAccountDatasource getListAccountDatasource;
  late GetListCreditCardDatasource getListCreditCardDatasource;
  late GetListIconsDatasource getListIconsDatasource;
  late AccountsRepository repository;

  setUp(() {
    editCreditCardDatasource = EditCreditCardDatasourceMoc();
    removeAccountDatasource = RemoveAccountDatasourceMock();
    editAccountDatasource = EditAccountDatasourceMock();
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
      editAccountDatasource,
      removeAccountDatasource,
      editCreditCardDatasource,
    );
  });

  group('addAccount', () {
    test('should return true when account is added', () async {
      when(() => addAccountDatasource(any(), any())).thenAnswer(
        (_) async => true,
      );

      final result = await repository.addAccount(
        AccountEntity(
          id: '',
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
          id: '',
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
          id: '',
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
          id: '',
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
          id: '',
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
          id: '',
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

  group('editAccount', () {
    test('should return true when account is modified', () async {
      when(() => editAccountDatasource(any(), any(), any())).thenAnswer(
        (_) async => true,
      );

      final result = await repository.editAccount(
        AccountEntity(
            id: '', balance: 1, icon: IconEntity(name: '', path: ''), name: ''),
        'userId',
      );

      expect(result.fold(id, id), true);
    });

    test('should return EditAccountError', () async {
      when(() => editAccountDatasource(any(), any(), any())).thenThrow(
        EditAccountError(''),
      );

      final result = await repository.editAccount(
        AccountEntity(
            id: '', balance: 1, icon: IconEntity(name: '', path: ''), name: ''),
        'userId',
      );

      expect(result.fold(id, id), isA<EditAccountError>());
    });
  });

  group('removeAccount', () {
    test('should return true when account is removed', () async {
      when(() => removeAccountDatasource(any(), any())).thenAnswer(
        (_) async => true,
      );

      final result = await repository.removeAccount('userID', 'accountID');

      expect(result.fold(id, id), true);
    });

    test('should return RemoveAccountError', () async {
      when(() => removeAccountDatasource(any(), any())).thenThrow(
        RemoveAccountError(''),
      );

      final result = await repository.removeAccount('userID', 'accountID');

      expect(result.fold(id, id), isA<RemoveAccountError>());
    });
  });

  group('editCreditCard', () {
    test('should return true when account is modified', () async {
      when(() => editCreditCardDatasource(any(), any(), any())).thenAnswer(
        (_) async => true,
      );

      final result = await repository.editCreditCard(
        CreditCardEntity(
          id: '',
          closedDay: 1,
          dueDay: 1,
          icon: IconEntity(name: '', path: ''),
          limit: 1,
          name: 'name',
        ),
        'idUser',
      );

      expect(result.fold(id, id), true);
    });

    test('should return EditCreditCardError', () async {
      when(() => editCreditCardDatasource(any(), any(), any())).thenThrow(
        EditCreditCardError(''),
      );

      final result = await repository.editCreditCard(
        CreditCardEntity(
          id: '',
          closedDay: 1,
          dueDay: 1,
          icon: IconEntity(name: '', path: ''),
          limit: 1,
          name: 'name',
        ),
        'idUser',
      );

      expect(result.fold(id, id), isA<EditCreditCardError>());
    });
  });
}
