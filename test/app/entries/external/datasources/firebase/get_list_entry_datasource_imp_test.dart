import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/domain/entities/query_entity.dart';
import 'package:organizze_app/app/entries/domain/errors/get_list_entry_errors.dart';
import 'package:organizze_app/app/entries/external/datasources/firebase/get_list_entry_datasource_imp.dart';
import 'package:organizze_app/app/entries/infra/datasources/get_list_entry_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late GetListEntryDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = GetListEntryDatasourceImp(firebaseFirestore);
  });

  test('should return a list of entry entity', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.entries}')
        .add({
      'date': DateTime.now(),
      'amount': 1.0,
      'category': 'a',
      'description': 'a',
      'entryType': 'a',
      'status': 'a',
      'accountType': 'a',
    });
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.entries}')
        .add({
      'date': DateTime.now(),
      'amount': 1.0,
      'category': 'a',
      'description': 'a',
      'entryType': 'a',
      'status': 'a',
      'accountType': 'a',
    });

    final result = await datasource('userId');

    expect(result, isA<List<EntryEntity>>());
    expect(result.length, 2);
  });

  test('should throw error when not found any entry', () async {
    final result = datasource('userId');

    expect(result, throwsA(isA<NoEntryFound>()));
  });

  test('should return a list of entry entity when passed a query', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.entries}')
        .add({
      'date': DateTime.now(),
      'amount': 1.0,
      'category': 'a',
      'description': 'test',
      'entryType': 'a',
      'status': 'a',
      'accountType': 'a',
    });
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.entries}')
        .add({
      'date': DateTime.now(),
      'amount': 1.0,
      'category': 'a',
      'description': 'a',
      'entryType': 'a',
      'status': 'a',
      'accountType': 'a',
    });

    final result = await datasource(
      'userId',
      query: [QueryEntity(field: 'description', value: 'test')],
    );

    expect(result, isA<List<EntryEntity>>());
    expect(result.length, 1);
  });

  test('should throw error when not found entry, passed a query', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.entries}')
        .add({
      'date': DateTime.now(),
      'amount': 1.0,
      'category': 'a',
      'description': 'a',
      'entryType': 'a',
      'status': 'a',
      'accountType': 'a',
    });
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.entries}')
        .add({
      'date': DateTime.now(),
      'amount': 1.0,
      'category': 'a',
      'description': 'a',
      'entryType': 'a',
      'status': 'a',
      'accountType': 'a',
    });

    final result = datasource(
      'userId',
      query: [QueryEntity(field: 'description', value: 'test')],
    );

    expect(result, throwsA(isA<NoEntryFound>()));
  });
}
