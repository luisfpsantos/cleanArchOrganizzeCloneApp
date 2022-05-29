import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/get_list_categories_erros.dart';

abstract class GetListCategoriesRepository {
  Future<Either<GetListCategoriesErrors, List<CategoryEntity>>> call(
    String categoryType,
  );
}
