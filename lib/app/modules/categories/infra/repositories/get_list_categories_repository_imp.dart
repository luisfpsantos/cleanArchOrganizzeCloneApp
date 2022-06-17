import 'package:organizze_app/app/modules/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/categories/domain/repositories/get_list_categories_repository.dart';
import 'package:organizze_app/app/modules/categories/infra/datasources/get_list_categories_datasource.dart';

class GetListCategoriesRepositoryImp implements GetListCategoriesRepository {
  final GetListCategoriesDatasource _getListCategoriesDatasource;

  GetListCategoriesRepositoryImp(this._getListCategoriesDatasource);

  @override
  Future<Either<GetListCategoriesErrors, List<CategoryEntity>>> call(
    String categoryType,
    String userId,
  ) async {
    try {
      final result = await _getListCategoriesDatasource(categoryType, userId);
      return right(result);
    } on NoCategoriesFound catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('Unknown error: ${e.toString()}'));
    }
  }
}
