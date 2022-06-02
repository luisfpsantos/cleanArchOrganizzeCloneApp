import 'package:cloud_firestore/cloud_firestore.dart';
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

  static EntryDto fromMap(Map<String, dynamic> map) {
    return EntryDto(
      date: (map['date'] as Timestamp).toDate(),
      amount: map['amount'],
      category: map['category'],
      description: map['description'],
      entryType: map['entryType'],
      status: map['status'],
      accountType: map['accountType'],
    );
  }

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
