import 'package:organizze_app/app/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/repositories/add_account_repository.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_account_datasource.dart';

class AddAccountRepositoryImp implements AddAccountRepository {
  final AddAccountDatasource _addAccountDatasource;

  AddAccountRepositoryImp(this._addAccountDatasource);

  @override
  Future<Either<AddAccountError, bool>> call(AccountEntity account) async {
    try {
      final result = await _addAccountDatasource(account);
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
