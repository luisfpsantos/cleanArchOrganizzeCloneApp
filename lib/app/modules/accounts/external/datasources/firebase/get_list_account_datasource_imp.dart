import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class GetListAccountDatasourceImp implements GetListAccountDatasource {
  final FirebaseFirestore _firebaseFirestore;

  GetListAccountDatasourceImp(this._firebaseFirestore);

  @override
  Future<List<Map>> call(String userId) async {
    final accountCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.accounts}',
    );

    List<Map> listAccounts = [];

    final accounts = await accountCollection.get();

    if (accounts.docs.isEmpty) {
      throw NoAccountsFound('any accounts founded');
    }

    for (var account in accounts.docs) {
      listAccounts.add(account.data());
    }

    return listAccounts;
  }
}
