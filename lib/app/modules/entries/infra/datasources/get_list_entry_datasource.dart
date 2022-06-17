import 'package:organizze_app/app/modules/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/modules/entries/domain/entities/query_entity.dart';

abstract class GetListEntryDatasource {
  Future<List<EntryEntity>> call(String userId, {List<QueryEntity>? query});
}
