import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/login/domain/errors/verify_login_errors.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/verify_login_datasource_imp.dart';
import 'package:organizze_app/app/login/infra/datasources/verify_login_datasource.dart';

void main() async {
  late FakeFirebaseFirestore firebaseInstance;
  late CollectionReference collectionReference;
  late VerifyLoginDatasource datasource;

  setUp(() {
    firebaseInstance = FakeFirebaseFirestore();
    collectionReference = firebaseInstance.collection('users');
    datasource = VerifyLoginDatasourceImp(collectionReference);
  });

  test('should return true, user authenticated', (() async {
    await collectionReference.add({
      'user': 'luis',
      'password': '1234',
    });

    var result = await datasource('luis', '1234');

    expect(result, true);
  }));

  test('should throw UserOrPasswordInvalid, when user not exits', () async {
    await collectionReference.add({
      'user': 'luis',
      'password': '1234',
    });

    var result = datasource.call;

    expect(result('blabla', '1234'), throwsA(isA<UserOrPasswordInvalid>()));
  });

  test('should throw UserOrPasswordInvalid, when password does not match',
      () async {
    await collectionReference.add({
      'user': 'luis',
      'password': '1234',
    });

    var result = datasource.call;

    expect(result('luis', 'blablab'), throwsA(isA<UserOrPasswordInvalid>()));
  });
}
