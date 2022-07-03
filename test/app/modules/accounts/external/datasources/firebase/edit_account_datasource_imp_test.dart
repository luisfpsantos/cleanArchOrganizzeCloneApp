import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/accounts/external/datasources/firebase/edit_account_datasource_imp.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/edit_account_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late EditAccountDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = EditAccountDatasourceImp(firebaseFirestore);
  });

  test('should true when account is edited', () async {
    firebaseFirestore.collection('users/userId/accounts').doc('conta1').set({
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
      'conta1',
      'userId',
    );

    expect(result, true);
  });
}
