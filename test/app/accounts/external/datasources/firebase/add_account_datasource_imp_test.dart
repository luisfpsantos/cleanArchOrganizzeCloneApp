import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_account_error.dart';
import 'package:organizze_app/app/accounts/external/datasources/firebase/add_account_datasource_imp.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_account_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference accountCollection;
  late AddAccountDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    accountCollection = firebaseFirestore.collection('users/userId/accounts');
    datasource = AddAccountDatasourceImp(accountCollection);
  });

  test('should return true when account is added', () async {
    final result =
        await datasource(AccountEntity(balance: 1, iconPath: '/n', name: 'a'));

    expect(result, true);
  });

  test('should throw account already exists', () async {
    await accountCollection.add({
      'balance': 1,
      'iconPath': '/n',
      'name': 'a',
    });

    final result =
        datasource(AccountEntity(balance: 1, iconPath: '/n', name: 'a'));

    expect(result, throwsA(isA<AccountAlreadyExists>()));
  });
}
