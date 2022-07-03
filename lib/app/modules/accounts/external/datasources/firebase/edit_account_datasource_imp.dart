import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_account_datasource.dart';

class EditAccountDatasourceImp implements EditAccountDatasource {
  final FirebaseFirestore _firebaseFirestore;

  EditAccountDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(
    Map<String, dynamic> newAccount,
    String accountID,
    String userID,
  ) async {
    final account = _firebaseFirestore.doc(
        '${FirebaseCollections.users}/$userID/${FirebaseCollections.accounts}/$accountID');

    account.update(newAccount).onError(
          (error, stackTrace) => throw EditAccountError(
            'Error update account: $error',
          ),
        );

    return true;
  }
}
