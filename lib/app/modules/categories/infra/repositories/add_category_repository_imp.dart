import 'package:organizze_app/app/modules/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/modules/categories/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/categories/domain/repositories/add_category_repository.dart';
import 'package:organizze_app/app/modules/categories/infra/datasources/add_category_datasource.dart';

class AddCategoryRepositoryImp implements AddCategoryRepository {
  final AddCategoryDatasource _addCategoryDatasource;

  AddCategoryRepositoryImp(this._addCategoryDatasource);

  @override
  Future<Either<AddCategoryErrors, bool>> call(
    CategoryEntity category,
    String userId,
  ) async {
    try {
      var result = await _addCategoryDatasource(category, userId);
      return right(result);
    } on AddError catch (e) {
      return left(e);
    } on CategoryAlreadyExists catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('unknown error'));
    }
  }
}
