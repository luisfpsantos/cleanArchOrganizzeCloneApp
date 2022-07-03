import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';

class AccountEntity {
  final String id;
  final double balance;
  final IconEntity icon;
  final String name;

  AccountEntity({
    required this.id,
    required this.balance,
    required this.icon,
    required this.name,
  });
}
