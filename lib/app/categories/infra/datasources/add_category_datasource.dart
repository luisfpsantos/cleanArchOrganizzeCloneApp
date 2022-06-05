import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';

abstract class AddCategoryDatasource {
  Future<bool> call(CategoryEntity category, String userId);
}
