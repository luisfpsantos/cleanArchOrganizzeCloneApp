import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/accounts_repository.dart';
import 'package:organizze_app/app/modules/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';

class GetListAccountUsecaseImp implements GetListAccountUsecase {
  final AccountsRepository _accountsRepository;

  GetListAccountUsecaseImp(this._accountsRepository);

  @override
  Future<Either<GetListAccountErrors, List<AccountEntity>>> call(
    String userId,
  ) async {
    return await _accountsRepository.getAccounts(userId);
  }
}
