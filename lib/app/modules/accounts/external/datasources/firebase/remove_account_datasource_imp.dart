import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/remove_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/remove_account_datasource.dart';

class RemoveAccountDatasourceImp implements RemoveAccountDatasource {
  final FirebaseFirestore _firebaseFirestore;

  RemoveAccountDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(String userID, String accountID) async {
    _firebaseFirestore
        .doc(
            '${FirebaseCollections.users}/$userID/${FirebaseCollections.accounts}/$accountID')
        .delete()
        .onError(
          (error, stackTrace) => throw RemoveAccountError(
            'Not possible to remove account: $error',
          ),
        );
    return true;
  }
}
