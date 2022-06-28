import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class AddAccountDatasourceImp implements AddAccountDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AddAccountDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(Map<String, dynamic> account, String userId) async {
    final accountCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.accounts}',
    );

    final query =
        await accountCollection.where('name', isEqualTo: account['name']).get();

    if (query.docs.isNotEmpty) {
      throw AccountAlreadyExists('account already exists');
    }

    await accountCollection.add(account).onError((e, _) =>
        throw AddAccountError('Error to add new account: ${e.toString()}'));

    return true;
  }
}
