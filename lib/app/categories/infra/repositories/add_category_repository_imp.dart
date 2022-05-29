import 'package:organizze_app/app/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/categories/domain/repositories/add_category_repository.dart';
import 'package:organizze_app/app/categories/infra/datasources/add_category_datasource.dart';

class AddCategoryRepositoryImp implements AddCategoryRepository {
  final AddCategoryDatasource _addCategoryDatasource;

  AddCategoryRepositoryImp(this._addCategoryDatasource);

  @override
  Future<Either<AddCategoryErrors, bool>> call(CategoryEntity category) async {
    try {
      var result = await _addCategoryDatasource(category);
      return Right(result);
    } on AddError catch (e) {
      return Left(e);
    } catch (e) {
      return left(RepositoryError('unknown error'));
    }
  }
}
