import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/accounts/infra/dtos/account_dto.dart';

class AddAccountDatasourceImp implements AddAccountDatasource {
  final CollectionReference _accountCollection;

  AddAccountDatasourceImp(this._accountCollection);

  @override
  Future<bool> call(AccountEntity account) async {
    final query =
        await _accountCollection.where('name', isEqualTo: account.name).get();

    if (query.docs.isNotEmpty) {
      throw AccountAlreadyExists('account already exists');
    }

    final accountDto = AccountDto(
      name: account.name,
      balance: account.balance,
      iconPath: account.iconPath,
    );

    await _accountCollection.add(accountDto.toMap()).onError(
        (e, _) => throw AddError('Error to add new account: ${e.toString()}'));

    return true;
  }
}
