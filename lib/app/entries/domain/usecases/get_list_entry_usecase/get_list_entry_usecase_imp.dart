import 'package:organizze_app/app/entries/domain/entities/query_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/get_list_entry_errors.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/entries/domain/repositories/get_list_entry_repository.dart';
import 'package:organizze_app/app/entries/domain/usecases/get_list_entry_usecase/get_list_entry_usecase.dart';

class GetListEntryUsecaseImp implements GetListEntryUsecase {
  final GetListEntryRepository _getListEntryRepository;

  GetListEntryUsecaseImp(this._getListEntryRepository);

  @override
  Future<Either<GetListEntryErrors, List<EntryEntity>>> call({
    List<QueryEntity>? query,
  }) async {
    return await _getListEntryRepository(query: query);
  }
}
