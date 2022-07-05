import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_credit_card_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_icons_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/remove_account_errors.dart';

abstract class AccountsRepository {
  Future<Either<AddAccountErrors, bool>> addAccount(
    AccountEntity account,
    String userId,
  );

  Future<Either<AddCreditCardErrors, bool>> addCreditCard(
    CreditCardEntity creditCard,
    String userId,
  );

  Future<Either<GetListAccountErrors, List<AccountEntity>>> getAccounts(
    String userId,
  );

  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> getCreditCards(
    String userId,
  );

  Future<Either<GetListIconsErrors, List<IconEntity>>> getIcons(
    String assetPath,
  );

  Future<Either<EditAccountErrors, bool>> editAccount(
    AccountEntity account,
    String userID,
  );

  Future<Either<RemoveAccountErrors, bool>> removeAccount(
    String userID,
    String accountID,
  );

  Future<Either<EditCreditCardsErrors, bool>> editCreditCard(
    CreditCardEntity creditCard,
    String userID,
  );
}
