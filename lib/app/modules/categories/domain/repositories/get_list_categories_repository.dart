import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/modules/categories/domain/errors/get_list_categories_erros.dart';

abstract class GetListCategoriesRepository {
  Future<Either<GetListCategoriesErrors, List<CategoryEntity>>> call(
    String categoryType,
    String userId,
  );
}
