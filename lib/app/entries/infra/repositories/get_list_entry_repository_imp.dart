import 'package:organizze_app/app/entries/domain/entities/query_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/get_list_entry_errors.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/entries/domain/repositories/get_list_entry_repository.dart';
import 'package:organizze_app/app/entries/infra/datasources/get_list_entry_datasource.dart';

class GetListEntryRepositoryImp implements GetListEntryRepository {
  final GetListEntryDatasource _getListEntryDatasource;

  GetListEntryRepositoryImp(this._getListEntryDatasource);

  @override
  Future<Either<GetListEntryErrors, List<EntryEntity>>> call({
    List<QueryEntity>? query,
  }) async {
    try {
      final result = await _getListEntryDatasource(query: query);
      return right(result);
    } on NoEntryFound catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('Unknown error: ${e.toString()}'));
    }
  }
}
