import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/add_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/add_account_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late AddAccountDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = AddAccountDatasourceImp(firebaseFirestore);
  });

  test('should return true when account is added', () async {
    final result = await datasource(
      {
        'name': 'teste',
        'balance': 213.4,
        'icon': {'name': 'iconName', 'path': 'iconPath'}
      },
      'userId',
    );

    expect(result, true);
  });

  test('should throw account already exists', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.accounts}')
        .add({
      'name': 'teste',
      'balance': 213.4,
      'icon': {'name': 'iconName', 'path': 'iconPath'}
    });

    final result = datasource(
      {
        'name': 'teste',
        'balance': 213.4,
        'icon': {'name': 'iconName', 'path': 'iconPath'}
      },
      'userId',
    );

    expect(result, throwsA(isA<AccountAlreadyExists>()));
  });
}
