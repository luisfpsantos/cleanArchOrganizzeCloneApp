import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';

class AddAccountUsecaseImp implements AddAccountUsecase {
  final AccountsRepository _accountsRepository;

  AddAccountUsecaseImp(this._accountsRepository);

  @override
  Future<Either<AddAccountErrors, bool>> call(
    AccountEntity account,
    String userId,
  ) async {
    if (account.name.isEmpty) {
      return left(InvalidArgument('name account is necessary'));
    }

    if (account.icon.path.isEmpty) {
      return left(InvalidArgument('icon is necessary'));
    }

    return await _accountsRepository.addAccount(account, userId);
  }
}
