import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/edit_credit_card_errors.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_credit_card_datasource.dart';

class EditCreditCardDatasourceImp implements EditCreditCardDatasource {
  final FirebaseFirestore _firebaseFirestore;

  EditCreditCardDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(
    Map<String, dynamic> newCreditCard,
    String accountID,
    String userID,
  ) async {
    final account = _firebaseFirestore.doc(
        '${FirebaseCollections.users}/$userID/${FirebaseCollections.creditCards}/$accountID');

    account.update(newCreditCard).onError(
          (error, stackTrace) => throw EditCreditCardError(
            'Error update creditCard: $error',
          ),
        );

    return true;
  }
}
