import 'package:organizze_app/app/modules/accounts/domain/errors/remove_account_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/remove_account_usecase/remove_account_usecase.dart';

class RemoveAccountUsecaseImp implements RemoveAccountUsecase {
  final AccountsRepository _accountsRepository;

  RemoveAccountUsecaseImp(this._accountsRepository);

  @override
  Future<Either<RemoveAccountErrors, bool>> call(
    String userID,
    String accountID,
  ) async {
    return await _accountsRepository.removeAccount(userID, accountID);
  }
}
