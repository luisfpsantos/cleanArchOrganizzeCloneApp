import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/add_category_errors.dart';

abstract class AddCategoryUsecase {
  Future<Either<AddCategoryErrors, bool>> call(
    CategoryEntity category,
    String userId,
  );
}
