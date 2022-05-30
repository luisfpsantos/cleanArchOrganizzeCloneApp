import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/categories/infra/datasources/add_category_datasource.dart';
import 'package:organizze_app/app/categories/infra/dtos/category_dto.dart';

class AddCategoryDatasourceImp implements AddCategoryDatasource {
  final CollectionReference _categoryCollection;

  AddCategoryDatasourceImp(this._categoryCollection);

  @override
  Future<bool> call(CategoryEntity category) async {
    final query =
        await _categoryCollection.where('name', isEqualTo: category.name).get();

    if (query.docs.isNotEmpty) {
      throw CategoryAlreadyExists('category already exists');
    }

    final categoryDto = CategoryDto(
      categoryType: category.categoryType,
      name: category.name,
      iconPath: category.iconPath,
    );

    await _categoryCollection
        .add(categoryDto.toMap())
        .onError((e, _) => throw AddError(e.toString()));

    return true;
  }
}
