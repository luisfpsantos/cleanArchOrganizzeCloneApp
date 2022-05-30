import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';

class AccountDto extends AccountEntity {
  AccountDto({
    required super.balance,
    required super.iconPath,
    required super.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'iconPath': iconPath,
      'name': name,
    };
  }
}
