import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/add_entry_errors.dart';

abstract class AddEntryRepository {
  Future<Either<AddEntryErrors, bool>> call(EntryEntity entry);
}
