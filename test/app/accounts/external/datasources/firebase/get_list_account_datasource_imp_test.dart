import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_account_errors.dart';
import 'package:organizze_app/app/accounts/external/datasources/firebase/get_list_account_datasource_imp.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_account_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference accountCollection;
  late GetListAccountDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    accountCollection = firebaseFirestore.collection('users/userId/accounts');
    datasource = GetListAccountDatasourceImp(accountCollection);
  });

  test('should return list of account entity', () async {
    await accountCollection.add({
      'balance': 1.2,
      'iconPath': '/n',
      'name': 'name',
    });
    await accountCollection.add({
      'balance': 1,
      'iconPath': '/n',
      'name': 'name1',
    });

    final result = await datasource();

    expect(result, isA<List<AccountEntity>>());
    expect(result.length, 2);
  });

  test('should throw error when not found any account', () async {
    final result = datasource();

    expect(result, throwsA(isA<NoAccountsFound>()));
  });
}
