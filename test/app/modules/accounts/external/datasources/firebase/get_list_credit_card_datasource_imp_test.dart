import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_credit_card_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late GetListCreditCardDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = GetListCreditCardDatasourceImp(firebaseFirestore);
  });

  test('should return list of creditCardEntity', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.creditCards}')
        .add({
      'closedDay': 2,
      'dueDay': 2,
      'iconPath': '/n',
      'limit': 2.0,
      'name': 'name',
    });

    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.creditCards}')
        .add({
      'closedDay': 2,
      'dueDay': 2,
      'iconPath': '/n',
      'limit': 2.0,
      'name': 'name1',
    });

    final result = await datasource('userId');

    expect(result, isA<List<CreditCardEntity>>());
    expect(result.length, 2);
  });

  test('should throw error when not found any account', () async {
    final result = datasource('userId');

    expect(result, throwsA(isA<NoCreditCardFound>()));
  });
}
