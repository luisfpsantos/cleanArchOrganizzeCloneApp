import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/infra/dtos/icon_dto.dart';

class CreditCardDto extends CreditCardEntity {
  CreditCardDto({
    required super.id,
    required super.closedDay,
    required super.dueDay,
    required super.icon,
    required super.limit,
    required super.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'closedDay': closedDay,
      'dueDay': dueDay,
      'icon': {'name': icon.name, 'path': icon.path},
      'limit': limit,
      'name': name,
    };
  }

  static CreditCardDto fromMap(Map map) {
    return CreditCardDto(
      id: map['id'],
      closedDay: map['closedDay'],
      dueDay: map['dueDay'],
      icon: IconDto.fromMap(map['icon']),
      limit: map['limit'].toDouble(),
      name: map['name'],
    );
  }
}
