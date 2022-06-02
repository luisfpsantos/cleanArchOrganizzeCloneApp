import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/entities/query_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/get_list_entry_errors.dart';

abstract class GetListEntryUsecase {
  Future<Either<GetListEntryErrors, List<EntryEntity>>> call({
    List<QueryEntity>? query,
  });
}
