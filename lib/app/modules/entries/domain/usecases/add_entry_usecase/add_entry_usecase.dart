import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/modules/entries/domain/errors/add_entry_errors.dart';

abstract class AddEntryUsecase {
  Future<Either<AddEntryErrors, bool>> call(EntryEntity entry, String userId);
}
