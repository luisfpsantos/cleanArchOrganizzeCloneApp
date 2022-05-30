import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/categories/external/datasources/firebase/add_category_datasource_imp.dart';
import 'package:organizze_app/app/categories/infra/datasources/add_category_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late AddCategoryDatasource datasource;
  late CollectionReference categoryCollection;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    categoryCollection =
        firebaseFirestore.collection('users/idUser/categories');
    datasource = AddCategoryDatasourceImp(categoryCollection);
  });

  test('should return true when category addedd', () async {
    var result = await datasource(
      CategoryEntity(name: 'test', iconPath: '/a/a', categoryType: 'income'),
    );

    expect(result, true);
  });

  test('should throw category already exists', () async {
    await categoryCollection.add({
      'name': 'test',
      'iconPath': '/a/a',
      'categoryType': 'income',
    });

    final result = datasource(
        CategoryEntity(name: 'test', iconPath: '/a/a', categoryType: 'income'));

    expect(result, throwsA(isA<CategoryAlreadyExists>()));
  });
}
