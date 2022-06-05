import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/add_entry_errors.dart';
import 'package:organizze_app/app/entries/infra/datasources/add_entry_datasource.dart';
import 'package:organizze_app/app/entries/infra/dtos/entry_dto.dart';

class AddEntryDatasourceImp implements AddEntryDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AddEntryDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(EntryEntity entry, String userId) async {
    final entryCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.entries}',
    );

    final entryDto = EntryDto(
      date: entry.date,
      amount: entry.amount,
      category: entry.category,
      description: entry.description,
      entryType: entry.entryType,
      status: entry.status,
      accountType: entry.accountType,
    );

    await entryCollection
        .add(entryDto.toMap())
        .onError((error, stackTrace) => throw AddError('Error to add entry'));

    return true;
  }
}
