import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';

abstract class AddEntryDatasource {
  Future<bool> call(EntryEntity entry, String userId);
}
