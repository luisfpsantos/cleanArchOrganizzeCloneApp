import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/add_account_repository.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';

class AddAccountRepositoryImp implements AddAccountRepository {
  final AddAccountDatasource _addAccountDatasource;

  AddAccountRepositoryImp(this._addAccountDatasource);

  @override
  Future<Either<AddAccountError, bool>> call(
    AccountEntity account,
    String userId,
  ) async {
    try {
      final result = await _addAccountDatasource(account, userId);
      return right(result);
    } on AddError catch (e) {
      return left(e);
    } on AccountAlreadyExists catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('Unknown error: ${e.toString()}'));
    }
  }
}
