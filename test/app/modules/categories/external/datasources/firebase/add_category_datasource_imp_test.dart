import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/modules/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/modules/categories/external/datasources/firebase/add_category_datasource_imp.dart';
import 'package:organizze_app/app/modules/categories/infra/datasources/add_category_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late AddCategoryDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = AddCategoryDatasourceImp(firebaseFirestore);
  });

  test('should return true when category addedd', () async {
    var result = await datasource(
        CategoryEntity(name: 'test', iconPath: '/a/a', categoryType: 'income'),
        'userId');

    expect(result, true);
  });

  test('should throw category already exists', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.categories}')
        .add({
      'name': 'test',
      'iconPath': '/a/a',
      'categoryType': 'income',
    });

    final result = datasource(
        CategoryEntity(name: 'test', iconPath: '/a/a', categoryType: 'income'),
        'userId');

    expect(result, throwsA(isA<CategoryAlreadyExists>()));
  });
}
