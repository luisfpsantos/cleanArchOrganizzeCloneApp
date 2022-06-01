import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';

class EntryDto extends EntryEntity {
  EntryDto({
    required super.date,
    required super.amount,
    required super.category,
    required super.description,
    required super.entryType,
    required super.status,
    required super.accountType,
  });

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'amount': amount,
      'category': category,
      'description': description,
      'entryType': entryType,
      'status': status,
      'accountType': accountType
    };
  }
}
