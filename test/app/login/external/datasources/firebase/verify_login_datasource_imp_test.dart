import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/verify_login_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/datasources/verify_login_datasource.dart';

void main() async {
  late FakeFirebaseFirestore firebaseInstance;
  late VerifyLoginDatasource datasource;

  setUp(() {
    firebaseInstance = FakeFirebaseFirestore();
    datasource = VerifyLoginDatasourceImp(firebaseInstance);
  });

  test('should return true, user authenticated', (() async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'user': 'luis',
      'password': '1234',
    });

    var result = await datasource('luis', '1234');

    expect(result, true);
  }));

  test('should throw UserOrPasswordInvalid, when user not exits', () async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'user': 'luis',
      'password': '1234',
    });

    var result = datasource.call;

    expect(result('blabla', '1234'), throwsA(isA<UserOrPasswordInvalid>()));
  });

  test('should throw UserOrPasswordInvalid, when password does not match',
      () async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'user': 'luis',
      'password': '1234',
    });

    var result = datasource.call;

    expect(result('luis', 'blablab'), throwsA(isA<UserOrPasswordInvalid>()));
  });
}
