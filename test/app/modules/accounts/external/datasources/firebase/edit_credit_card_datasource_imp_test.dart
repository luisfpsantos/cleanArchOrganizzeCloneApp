import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/edit_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_credit_card_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late EditCreditCardDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = EditCreditCardDatasourceImp(firebaseFirestore);
  });

  test('should true when creditCard is edited', () async {
    firebaseFirestore
        .collection('users/userId/creditcards')
        .doc('credit1')
        .set({
      'balance': 2,
      'icon': {'name': 'icon', 'path': 'path'},
      'name': 'teste',
    });

    final result = await datasource(
      {
        'balance': 300,
        'icon': {'name': 'icon', 'path': 'path'},
        'name': 'teste2',
      },
      'credit1',
      'userId',
    );

    expect(result, true);
  });
}
