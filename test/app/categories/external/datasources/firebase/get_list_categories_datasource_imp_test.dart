import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/categories/external/datasources/firebase/get_list_categories_datasource_imp.dart';
import 'package:organizze_app/app/categories/infra/datasources/get_list_categories_datasource.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late CollectionReference categoryCollection;
  late GetListCategoriesDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    categoryCollection =
        firebaseFirestore.collection('users/userId/categories');
    datasource = GetListCategoriesDatasourceImp(categoryCollection);
  });

  test('should return list of CategoryEntity', () async {
    await categoryCollection.add({
      'categoryType': 'income',
      'name': 'name',
      'iconPath': '/a/a',
    });

    final result = await datasource('income');

    expect(result, isA<List<CategoryEntity>>());
  });

  test('should throw error when not found a category', () async {
    await categoryCollection.add({
      'categoryType': 'income',
      'name': 'name',
      'iconPath': '/a/a',
    });

    final result = datasource('expense');

    expect(result, throwsA(isA<NoCategoriesFound>()));
  });
}
