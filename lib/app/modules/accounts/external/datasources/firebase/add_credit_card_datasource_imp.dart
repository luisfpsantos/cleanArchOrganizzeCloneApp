import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class AddCreditCardDatasourceImp implements AddCreditCardDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AddCreditCardDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(Map<String, dynamic> creditCard, String userId) async {
    final creditCardCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.creditCards}',
    );

    final query = await creditCardCollection
        .where('name', isEqualTo: creditCard['name'])
        .get();

    if (query.docs.isNotEmpty) {
      throw CreditCardAlreadyExists('Credit card already exists');
    }

    await creditCardCollection.add(creditCard).onError(
        (error, _) => throw AddCreditCardError('Error to add new creditCard'));

    return true;
  }
}
