import 'package:organizze_app/app/entries/domain/errors/add_entry_errors.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/entries/domain/repositories/add_entry_repository.dart';
import 'package:organizze_app/app/entries/infra/datasources/add_entry_datasource.dart';

class AddEntryRepositoryImp implements AddEntryRepository {
  final AddEntryDatasource _addEntryDatasource;

  AddEntryRepositoryImp(this._addEntryDatasource);

  @override
  Future<Either<AddEntryErrors, bool>> call(
    EntryEntity entry,
    String userId,
  ) async {
    try {
      final result = await _addEntryDatasource(entry, userId);
      return right(result);
    } on AddError catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('Unknown error: ${e.toString()}'));
    }
  }
}
