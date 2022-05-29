import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/get_list_categories_erros.dart';
import 'package:organizze_app/app/categories/domain/repositories/get_list_categories_repository.dart';
import 'package:organizze_app/app/categories/infra/datasources/get_list_categories_datasource.dart';
import 'package:organizze_app/app/categories/infra/repositories/get_list_categories_repository_imp.dart';

class DatasourceMock extends Mock implements GetListCategoriesDatasource {}

void main() {
  late GetListCategoriesDatasource datasource;
  late GetListCategoriesRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = GetListCategoriesRepositoryImp(datasource);
  });

  test('should return List of CategoriEntity', () async {
    when(() => datasource(any())).thenAnswer((_) async => <CategoryEntity>[]);

    final result = await repository('expanse');

    expect(result.fold(id, id), isA<List<CategoryEntity>>());
  });

  test('should return error when list is empty', () async {
    when(() => datasource(any())).thenThrow(NoCategoriesFound('test'));

    final result = await repository('income');

    expect(result.fold(id, id), isA<NoCategoriesFound>());
  });

  test('should return repository error when datasource throw unknown error',
      () async {
    when(() => datasource(any())).thenThrow(NoCategoriesFound('test'));

    final result = await repository('income');

    expect(result.fold(id, id), isA<NoCategoriesFound>());
  });
}
