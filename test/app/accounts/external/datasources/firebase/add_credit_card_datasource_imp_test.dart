import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/accounts/external/datasources/firebase/add_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_credit_card_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference creditCardCollection;
  late AddCreditCardDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    creditCardCollection =
        firebaseFirestore.collection('users/userId/creditCards');
    datasource = AddCreditCardDatasourceImp(creditCardCollection);
  });

  test('should return true when credit card is added', () async {
    final result = await datasource(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '/', limit: 1, name: 'a'));

    expect(result, true);
  });

  test('should throw account already exists', () async {
    await creditCardCollection.add({
      'closedDay': 1,
      'dueDay': 1,
      'iconPath': '/',
      'limit': 1,
      'name': 'a',
    });

    final result = datasource(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '/', limit: 1, name: 'a'));

    expect(result, throwsA(isA<CreditCardAlreadyExists>()));
  });
}
