import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/modules/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/modules/categories/external/datasources/firebase/get_list_categories_datasource_imp.dart';
import 'package:organizze_app/app/modules/categories/infra/datasources/get_list_categories_datasource.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

void main() {
  late FirebaseFirestore firebaseFirestore;
  late GetListCategoriesDatasource datasource;

  setUp(() {
    firebaseFirestore = FakeFirebaseFirestore();
    datasource = GetListCategoriesDatasourceImp(firebaseFirestore);
  });

  test('should return list of CategoryEntity', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.categories}')
        .add({
      'categoryType': 'income',
      'name': 'name',
      'iconPath': '/a/a',
    });

    final result = await datasource('income', 'userId');

    expect(result, isA<List<CategoryEntity>>());
  });

  test('should throw error when not found a category', () async {
    await firebaseFirestore
        .collection(
            '${FirebaseCollections.users}/userId/${FirebaseCollections.categories}')
        .add({
      'categoryType': 'income',
      'name': 'name',
      'iconPath': '/a/a',
    });

    final result = datasource('expense', 'userId');

    expect(result, throwsA(isA<NoCategoriesFound>()));
  });
}
