import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/modules/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/modules/categories/infra/datasources/add_category_datasource.dart';
import 'package:organizze_app/app/modules/categories/infra/dtos/category_dto.dart';
import 'package:organizze_app/app/core/utils/firebase_collections.dart';

class AddCategoryDatasourceImp implements AddCategoryDatasource {
  final FirebaseFirestore _firebaseFirestore;

  AddCategoryDatasourceImp(this._firebaseFirestore);

  @override
  Future<bool> call(CategoryEntity category, String userId) async {
    final categoryCollection = _firebaseFirestore.collection(
      '${FirebaseCollections.users}/$userId/${FirebaseCollections.categories}',
    );

    final query =
        await categoryCollection.where('name', isEqualTo: category.name).get();

    if (query.docs.isNotEmpty) {
      throw CategoryAlreadyExists('category already exists');
    }

    final categoryDto = CategoryDto(
      categoryType: category.categoryType,
      name: category.name,
      iconPath: category.iconPath,
    );

    await categoryCollection
        .add(categoryDto.toMap())
        .onError((e, _) => throw AddError(e.toString()));

    return true;
  }
}
