import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_icons_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_icons_datasource.dart';
import 'package:organizze_app/app/modules/accounts/infra/dtos/account_dto.dart';
import 'package:organizze_app/app/modules/accounts/infra/dtos/credit_card_dto.dart';

class AccountsRepositoryImp implements AccountsRepository {
  final AddAccountDatasource _addAccountDatasource;
  final AddCreditCardDatasource _addCreditCardDatasource;
  final GetListAccountDatasource _getListAccountDatasource;
  final GetListCreditCardDatasource _getListCreditCardDatasource;
  final GetListIconsDatasource _getListIconsDatasource;

  AccountsRepositoryImp(
    this._addAccountDatasource,
    this._addCreditCardDatasource,
    this._getListAccountDatasource,
    this._getListCreditCardDatasource,
    this._getListIconsDatasource,
  );

  @override
  Future<Either<AddAccountErrors, bool>> addAccount(
      AccountEntity account, String userId) async {
    try {
      final accountDto = AccountDto(
        name: account.name,
        balance: account.balance,
        icon: account.icon,
      ).toMap();

      final result = await _addAccountDatasource(accountDto, userId);
      return right(result);
    } on AddAccountError catch (e) {
      return left(e);
    } on AccountAlreadyExists catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<AddCreditCardErrors, bool>> addCreditCard(
      CreditCardEntity creditCard, String userId) async {
    try {
      final creditCardDto = CreditCardDto(
        closedDay: creditCard.closedDay,
        dueDay: creditCard.dueDay,
        icon: creditCard.icon,
        limit: creditCard.limit,
        name: creditCard.name,
      ).toMap();

      final result = await _addCreditCardDatasource(creditCardDto, userId);
      return right(result);
    } on AddCreditCardError catch (e) {
      return left(e);
    } on CreditCardAlreadyExists catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<GetListAccountErrors, List<AccountEntity>>> getAccounts(
      String userId) async {
    try {
      final result = await _getListAccountDatasource(userId);
      List<AccountEntity> list = [];

      for (var account in result) {
        list.add(AccountDto.fromMap(account));
      }
      return right(list);
    } on NoAccountsFound catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> getCreditCards(
      String userId) async {
    try {
      final result = await _getListCreditCardDatasource(userId);
      List<CreditCardEntity> list = [];

      for (var creditCard in result) {
        list.add(CreditCardDto.fromMap(creditCard));
      }
      return right(list);
    } on NoCreditCardFound catch (e) {
      return left(e);
    }
  }

  @override
  Future<Either<GetListIconsErrors, List<String>>> getIcons(
    String assetPath,
  ) async {
    try {
      final result = await _getListIconsDatasource(assetPath);
      return right(result);
    } on NoAssetsFound catch (e) {
      return left(e);
    }
  }
}
