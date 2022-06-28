import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/login/domain/errors/login_errors.dart';
import 'package:organizze_app/app/modules/login/external/datasources/firebase/login_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/login_datasource.dart';

void main() async {
  late FirebaseFirestore firebaseInstance;
  late LoginDatasource datasource;

  setUp(() {
    firebaseInstance = FakeFirebaseFirestore();
    datasource = LoginDatasourceImp(firebaseInstance);
  });

  test('should return userEntity', (() async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'user': 'luis',
      'password': '1234',
    });

    var result = await datasource('luis', '1234');

    expect(result, isA<Map>());
    expect(result['user']['user'], 'luis');
  }));

  test('should throw UserOrPasswordInvalid, when user not exits', () async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'user': 'luis',
      'password': '1234',
    });

    var result = datasource('blabla', '1234');

    expect(result, throwsA(isA<UserOrPasswordInvalid>()));
  });

  test('should throw UserOrPasswordInvalid, when password does not match',
      () async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'user': 'luis',
      'password': '1234',
    });

    var result = datasource('luis', 'blablab');

    expect(result, throwsA(isA<UserOrPasswordInvalid>()));
  });
}
