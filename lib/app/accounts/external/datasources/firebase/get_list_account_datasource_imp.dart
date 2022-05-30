import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/accounts/infra/dtos/account_dto.dart';

class GetListAccountDatasourceImp implements GetListAccountDatasource {
  final CollectionReference _accountCollection;

  GetListAccountDatasourceImp(this._accountCollection);

  @override
  Future<List<AccountEntity>> call() async {
    List<AccountEntity> listAccounts = [];

    final accounts = await _accountCollection.get();

    if (accounts.docs.isEmpty) {
      throw NoAccountsFound('any accounts founded');
    }

    for (var account in accounts.docs) {
      listAccounts
          .add(AccountDto.fromMap(account.data() as Map<String, dynamic>));
    }

    return listAccounts;
  }
}
