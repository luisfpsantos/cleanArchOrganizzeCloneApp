import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/entries/domain/entities/entry_entity.dart';
import 'package:organizze_app/app/entries/external/datasources/firebase/add_entry_datasource_imp.dart';
import 'package:organizze_app/app/entries/infra/datasources/add_entry_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late AddEntryDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = AddEntryDatasourceImp(firebaseFirestore);
  });

  test('should return true when addedd', () async {
    final result = await datasource(
      EntryEntity(
        date: DateTime.now(),
        amount: 1,
        category: 'a',
        description: 'a',
        entryType: 'a',
        status: 'a',
        accountType: 'a',
      ),
      'userId',
    );

    expect(result, true);
  });
}
