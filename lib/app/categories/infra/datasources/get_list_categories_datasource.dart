import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';

abstract class GetListCategoriesDatasource {
  Future<List<CategoryEntity>> call(String categoryType, String userId);
}
