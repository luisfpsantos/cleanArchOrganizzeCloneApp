import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';

abstract class AddAccountViewEvents {}

class AddAccount extends AddAccountViewEvents {
  final AccountEntity account;
  final String userID;

  AddAccount(
    this.account,
    this.userID,
  );
}

class RemoveError extends AddAccountViewEvents {}
