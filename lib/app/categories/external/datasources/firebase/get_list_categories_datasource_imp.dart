import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/categories/infra/datasources/get_list_categories_datasource.dart';
import 'package:organizze_app/app/categories/infra/dtos/category_dto.dart';

class GetListCategoriesDatasourceImp implements GetListCategoriesDatasource {
  final CollectionReference _categoriesColletction;

  GetListCategoriesDatasourceImp(this._categoriesColletction);

  @override
  Future<List<CategoryEntity>> call(String categoryType) async {
    var listCategories = <CategoryEntity>[];

    final categories = await _categoriesColletction
        .where('categoryType', isEqualTo: categoryType)
        .get();

    if (categories.docs.isEmpty) {
      throw NoCategoriesFound('any categories found');
    }

    for (var category in categories.docs) {
      listCategories
          .add(CategoryDto.fromMap(category.data() as Map<String, dynamic>));
    }

    return listCategories;
  }
}
