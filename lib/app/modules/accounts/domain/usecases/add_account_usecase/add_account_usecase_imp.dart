import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/add_account_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/add_account_usecase/add_account_usecase.dart';

class AddAccountUsecaseImp implements AddAccountUsecase {
  final AddAccountRepository _addAccountRepository;

  AddAccountUsecaseImp(this._addAccountRepository);

  @override
  Future<Either<AddAccountError, bool>> call(
    AccountEntity account,
    String userId,
  ) async {
    if (account.name.isEmpty) {
      return left(InvalidArgument('name account is necessary'));
    }

    if (account.iconPath.isEmpty) {
      return left(InvalidArgument('icon is necessary'));
    }

    return await _addAccountRepository(account, userId);
  }
}
