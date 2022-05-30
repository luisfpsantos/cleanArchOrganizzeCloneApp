import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_account_repository.dart';
import 'package:organizze_app/app/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';

class GetListAccountUsecaseImp implements GetListAccountUsecase {
  final GetListAccountRepository _getListAccountRepository;

  GetListAccountUsecaseImp(this._getListAccountRepository);

  @override
  Future<Either<GetListAccountErrors, List<AccountEntity>>> call() async {
    return await _getListAccountRepository();
  }
}
