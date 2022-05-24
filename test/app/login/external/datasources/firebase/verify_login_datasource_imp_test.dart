import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/verify_login_datasource_imp.dart';

void main() async {
  final firebaseInstance = FakeFirebaseFirestore();

  final collectionReference = firebaseInstance.collection('users');

  await collectionReference.add({
    'user': 'luis',
    'password': '1234',
  });

  final datasource = VerifyLoginDatasourceImp(collectionReference);

  test('should return true, user authenticated', (() async {
    var result = await datasource('luis', '1234');

    expect(result, true);
  }));

  test('should throw UserOrPasswordInvalid, when user not exits', (() async {
    expect(
      () async => await datasource('blabla', '1234'),
      throwsA(isA<UserOrPasswordInvalid>()),
    );
  }));

  test('should throw UserOrPasswordInvalid, when password does not match',
      (() async {
    expect(
      () async => await datasource('luis', 'blablab'),
      throwsA(isA<UserOrPasswordInvalid>()),
    );
  }));
}
