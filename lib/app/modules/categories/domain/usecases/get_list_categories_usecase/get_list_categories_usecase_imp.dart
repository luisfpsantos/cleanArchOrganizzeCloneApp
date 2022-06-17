import 'package:organizze_app/app/modules/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/categories/domain/repositories/get_list_categories_repository.dart';
import 'package:organizze_app/app/modules/categories/domain/usecases/get_list_categories_usecase/get_list_categories_usecase.dart';

class GetListCategoriesUsecaseImp implements GetListCategoriesUsecase {
  final GetListCategoriesRepository _getListCategoriesRepository;

  GetListCategoriesUsecaseImp(this._getListCategoriesRepository);

  @override
  Future<Either<GetListCategoriesErrors, List<CategoryEntity>>> call(
    String categoryType,
    String userId,
  ) async {
    return await _getListCategoriesRepository(categoryType, userId);
  }
}
