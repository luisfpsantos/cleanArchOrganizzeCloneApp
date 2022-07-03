import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';

abstract class EditAccountViewEvents {}

class OnEditAccountEvent extends EditAccountViewEvents {
  final AccountEntity account;
  final String userId;

  OnEditAccountEvent(this.account, this.userId);
}

class OnEditAccountChangeEvent extends EditAccountViewEvents {}

class ToEditAccountDefault extends EditAccountViewEvents {}

class OnRemoveAccountEvent extends EditAccountViewEvents {
  final String userId;
  final String accountId;

  OnRemoveAccountEvent(this.userId, this.accountId);
}
