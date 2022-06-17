import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/modules/login/domain/entities/logged_user_entity.dart';
import 'package:organizze_app/app/modules/login/domain/errors/get_user_in_database_errors.dart';
import 'package:organizze_app/app/modules/login/external/datasources/firebase/get_user_in_database_datasource_imp.dart';
import 'package:organizze_app/app/modules/login/infra/datasources/get_user_in_database_datasource.dart';

void main() {
  late FakeFirebaseFirestore firebaseInstance;
  late GetUserInDatabaseDatasource datasource;

  setUp(() {
    firebaseInstance = FakeFirebaseFirestore();
    datasource = GetUserInDatabaseDatasourceImp(firebaseInstance);
  });

  test('should return loggedUserEntity', () async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'name': 'luis fernando pessoni',
      'user': 'luis',
      'authenticated': true,
    });

    var result = await datasource('luis');

    expect(result, isA<LoggedUserEntity>());
  });

  test('should throw error when user is not found', () async {
    await firebaseInstance.collection(FirebaseCollections.users).add({
      'name': 'luis fernando pessoni',
      'user': 'luis',
      'authenticated': true,
    });

    var result = datasource.call;

    expect(result('asdfas'), throwsA(isA<UserNotFound>()));
  });
}
