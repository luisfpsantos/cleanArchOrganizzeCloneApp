import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';

abstract class GetListCategoriesDatasource {
  Future<List<CategoryEntity>> call(String categoryType, String userId);
}
