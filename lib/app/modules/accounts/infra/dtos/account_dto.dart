import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/infra/dtos/icon_dto.dart';

class AccountDto extends AccountEntity {
  AccountDto({
    required super.balance,
    required super.icon,
    required super.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'balance': balance,
      'icon': {'name': icon.name, 'path': icon.path},
      'name': name,
    };
  }

  static AccountDto fromMap(Map map) {
    return AccountDto(
      balance: map['balance'].toDouble(),
      icon: IconDto.fromMap(map['icon']),
      name: map['name'],
    );
  }
}
