import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/accounts/infra/dtos/account_dto.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class GetListAccountDatasourceImp implements GetListAccountDatasource {
  final FirebaseFirestore _firebaseFirestore;

  GetListAccountDatasourceImp(this._firebaseFirestore);

  @override
  Future<List<AccountEntity>> call(String userId) async {
    final accountCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.accounts}',
    );

    List<AccountEntity> listAccounts = [];

    final accounts = await accountCollection.get();

    if (accounts.docs.isEmpty) {
      throw NoAccountsFound('any accounts founded');
    }

    for (var account in accounts.docs) {
      listAccounts.add(AccountDto.fromMap(account.data()));
    }

    return listAccounts;
  }
}
