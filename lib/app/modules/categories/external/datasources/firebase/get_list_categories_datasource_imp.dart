import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/modules/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/modules/categories/infra/datasources/get_list_categories_datasource.dart';
import 'package:organizze_app/app/modules/categories/infra/dtos/category_dto.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class GetListCategoriesDatasourceImp implements GetListCategoriesDatasource {
  final FirebaseFirestore _firebaseFirestore;

  GetListCategoriesDatasourceImp(this._firebaseFirestore);

  @override
  Future<List<CategoryEntity>> call(
    String categoryType,
    String userId,
  ) async {
    final categoryCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.categories}',
    );

    var listCategories = <CategoryEntity>[];

    final categories = await categoryCollection
        .where('categoryType', isEqualTo: categoryType)
        .get();

    if (categories.docs.isEmpty) {
      throw NoCategoriesFound('any categories found');
    }

    for (var category in categories.docs) {
      listCategories.add(CategoryDto.fromMap(category.data()));
    }

    return listCategories;
  }
}
