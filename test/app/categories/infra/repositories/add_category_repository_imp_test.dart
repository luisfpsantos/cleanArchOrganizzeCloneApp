import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/categories/domain/repositories/add_category_repository.dart';
import 'package:organizze_app/app/categories/infra/datasources/add_category_datasource.dart';
import 'package:organizze_app/app/categories/infra/repositories/add_category_repository_imp.dart';

class DatasourceMock extends Mock implements AddCategoryDatasource {}

void main() {
  late AddCategoryDatasource datasource;
  late AddCategoryRepository repository;

  setUpAll(() {
    registerFallbackValue(
      CategoryEntity(categoryType: '', name: '', iconPath: ''),
    );
  });

  setUp(() {
    datasource = DatasourceMock();
    repository = AddCategoryRepositoryImp(datasource);
  });

  test('should return true when add is succeed', () async {
    when(() => datasource(any())).thenAnswer((_) async => true);

    var result = await repository(
        CategoryEntity(name: '', categoryType: '', iconPath: ''));

    expect(result.fold(id, id), true);
  });

  test('should return AddError when datasource is incapable to save', () async {
    when(() => datasource(any())).thenThrow(AddError('test'));

    var result = await repository(
        CategoryEntity(name: '', categoryType: '', iconPath: ''));

    expect(result.fold(id, id), isA<AddError>());
  });

  test('should return category already exists', () async {
    when(() => datasource(any())).thenThrow(CategoryAlreadyExists('test'));

    var result = await repository(
        CategoryEntity(name: '', categoryType: '', iconPath: ''));

    expect(result.fold(id, id), isA<CategoryAlreadyExists>());
  });

  test('should return repositoryError when something is wrong', () async {
    when(() => datasource(any())).thenThrow(Exception());

    var result = await repository(
        CategoryEntity(name: '', categoryType: '', iconPath: ''));

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
