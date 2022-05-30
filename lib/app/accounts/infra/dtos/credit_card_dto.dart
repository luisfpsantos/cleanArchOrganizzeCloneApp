import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';

class CreditCardDto extends CreditCardEntity {
  CreditCardDto({
    required super.closedDay,
    required super.dueDay,
    required super.iconPath,
    required super.limit,
    required super.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'closedDay': closedDay,
      'dueDay': dueDay,
      'iconPath': iconPath,
      'limit': limit,
      'name': name,
    };
  }
}
