import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/remove_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/remove_account_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late RemoveAccountDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = RemoveAccountDatasourceImp(firebaseFirestore);
  });

  test('should return true when account is removed', () async {
    firebaseFirestore.doc('users/userID/accounts/accountId').set({'teste': 1});

    final result = await datasource('userID', 'accountId');

    expect(result, true);
  });
}
