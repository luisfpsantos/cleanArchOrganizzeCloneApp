import 'package:organizze_app/app/modules/accounts/domain/entities/icon_entity.dart';

class CreditCardEntity {
  final int closedDay;
  final int dueDay;
  final IconEntity icon;
  final double limit;
  final String name;

  CreditCardEntity({
    required this.closedDay,
    required this.dueDay,
    required this.icon,
    required this.limit,
    required this.name,
  });
}
