import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/login/external/datasources/firebase/get_user_in_database_datasource_imp.dart';

void main() async {
  final firebaseInstance = FakeFirebaseFirestore();
  final collectionReference = firebaseInstance.collection('users');

  await collectionReference.add({
    'name': 'luis fernando pessoni',
    'user': 'luis',
    'authenticated': true,
  });

  final datasource = GetUserInDatabaseDatasourceImp(collectionReference);

  test('should return loggedUserEntity', () async {
    var result = await datasource('luis');

    expect(result, isA<LoggedUserEntity>());
  });

  test('should throw error when user is not found', () async {
    expect(
      () async => await datasource('asçdlkfjad'),
      throwsA(isA<UserNotFound>()),
    );
  });
}
