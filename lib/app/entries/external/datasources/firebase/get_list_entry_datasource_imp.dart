import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/entities/query_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/get_list_entry_errors.dart';
import 'package:organizze_app/app/entries/infra/datasources/get_list_entry_datasource.dart';
import 'package:organizze_app/app/entries/infra/dtos/entry_dto.dart';

class GetListEntryDatasourceImp implements GetListEntryDatasource {
  final CollectionReference _entriesCollection;

  GetListEntryDatasourceImp(this._entriesCollection);

  @override
  Future<List<EntryEntity>> call({List<QueryEntity>? query}) async {
    List<EntryEntity> listEntries = [];

    Query entriesQuery = _entriesCollection.orderBy('date');

    if (query != null) {
      for (var q in query) {
        entriesQuery = entriesQuery.where(q.field, isEqualTo: q.value);
      }
    }

    final entries = await entriesQuery.get();

    if (entries.docs.isEmpty) {
      throw NoEntryFound('any antries found');
    }

    for (var entry in entries.docs) {
      listEntries.add(EntryDto.fromMap(entry.data() as Map<String, dynamic>));
    }

    return listEntries;
  }
}
