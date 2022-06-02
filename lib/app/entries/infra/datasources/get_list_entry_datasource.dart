import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';

abstract class GetListEntryDatasource {
  Future<List<EntryEntity>> call();
}
