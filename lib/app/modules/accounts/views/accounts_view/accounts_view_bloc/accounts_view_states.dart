import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';

abstract class AccountsViewStates {}

class AccountsIdle extends AccountsViewStates {}

class AccountsLoading extends AccountsViewStates {}

class AccountsError extends AccountsViewStates {
  final String msg;

  AccountsError(this.msg);
}

class AccountsNotFound extends AccountsError {
  AccountsNotFound(super.msg);
}

class AccountsSuccess extends AccountsViewStates {
  final List<AccountEntity> accounts;

  AccountsSuccess(this.accounts);
}

class CreditCardSuccess extends AccountsViewStates {
  final List<CreditCardEntity> creditCards;

  CreditCardSuccess(this.creditCards);
}
