import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/get_list_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_account_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late GetListAccountDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = GetListAccountDatasourceImp(firebaseFirestore);
  });

  test('should return list of account entity', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.accounts}')
        .add({
      'balance': 1.2,
      'iconPath': '/n',
      'name': 'name',
    });
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.accounts}')
        .add({
      'balance': 1,
      'iconPath': '/n',
      'name': 'name1',
    });

    final result = await datasource('userId');

    expect(result, isA<List<AccountEntity>>());
    expect(result.length, 2);
  });

  test('should throw error when not found any account', () async {
    final result = datasource('userId');

    expect(result, throwsA(isA<NoAccountsFound>()));
  });
}
