import 'package:organizze_app/app/modules/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/categories/domain/repositories/add_category_repository.dart';
import 'package:organizze_app/app/modules/categories/domain/usecases/add_category_usecase/add_category_usecase.dart';

class AddCategoryUsecaseImp implements AddCategoryUsecase {
  final AddCategoryRepository _addCategoryRepository;

  AddCategoryUsecaseImp(this._addCategoryRepository);

  @override
  Future<Either<AddCategoryErrors, bool>> call(
    CategoryEntity category,
    String userId,
  ) async {
    if (category.name.isEmpty) {
      return left(InvalidArgument('name cant be null'));
    }

    if (category.iconPath.isEmpty) {
      return left(InvalidArgument('icon cant be null'));
    }

    return await _addCategoryRepository(category, userId);
  }
}
