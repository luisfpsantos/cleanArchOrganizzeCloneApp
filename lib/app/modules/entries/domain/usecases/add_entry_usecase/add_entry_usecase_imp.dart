import 'package:organizze_app/app/modules/entries/domain/errors/add_entry_errors.dart';
import 'package:organizze_app/app/modules/entries/domain/entities/entry_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/entries/domain/repositories/add_entry_repository.dart';
import 'package:organizze_app/app/modules/entries/domain/usecases/add_entry_usecase/add_entry_usecase.dart';

class AddEntryUsecaseImp implements AddEntryUsecase {
  final AddEntryRepository _addEntryRepository;

  AddEntryUsecaseImp(this._addEntryRepository);

  @override
  Future<Either<AddEntryErrors, bool>> call(
    EntryEntity entry,
    String userId,
  ) async {
    if (entry.accountType.isEmpty) {
      return left(InvalidArgument('account type is necessary'));
    }

    if (entry.amount <= 0) {
      return left(InvalidArgument('amount is invalid'));
    }

    if (entry.category.isEmpty) {
      return left(InvalidArgument('category is necessary'));
    }

    if (entry.description.isEmpty) {
      return left(InvalidArgument('desciption is necessary'));
    }

    if (entry.entryType.isEmpty) {
      return left(InvalidArgument('entry type is necessary'));
    }

    if (entry.status.isEmpty) {
      return left(InvalidArgument('status is necessary'));
    }

    return await _addEntryRepository(entry, userId);
  }
}
