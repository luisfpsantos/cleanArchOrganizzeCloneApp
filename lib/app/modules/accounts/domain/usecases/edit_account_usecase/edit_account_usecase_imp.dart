import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/edit_account_usecase/edit_account_usecase.dart';

class EditAccountUsecaseImp implements EditAccountUsecase {
  final AccountsRepository _accountsRepository;

  EditAccountUsecaseImp(this._accountsRepository);
  @override
  Future<Either<EditAccountErrors, bool>> call(
    AccountEntity account,
    String userID,
  ) async {
    if (account.name.isEmpty) {
      return left(EditAccountInvalidArgument('name account is necessary'));
    }

    if (account.icon.path.isEmpty) {
      return left(EditAccountInvalidArgument('icon is necessary'));
    }

    return await _accountsRepository.editAccount(account, userID);
  }
}
