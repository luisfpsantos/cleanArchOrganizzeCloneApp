import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_account_repository.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_account_datasource.dart';

class GetListAccountRepositoryImp implements GetListAccountRepository {
  final GetListAccountDatasource _getListAccountDatasource;

  GetListAccountRepositoryImp(this._getListAccountDatasource);

  @override
  Future<Either<GetListAccountErrors, List<AccountEntity>>> call(
    String userId,
  ) async {
    try {
      final result = await _getListAccountDatasource(userId);
      return right(result);
    } on NoAccountsFound catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('unknown error: ${e.toString()}'));
    }
  }
}
