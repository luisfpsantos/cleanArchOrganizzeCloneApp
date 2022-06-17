import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';

abstract class AddCategoryDatasource {
  Future<bool> call(CategoryEntity category, String userId);
}
