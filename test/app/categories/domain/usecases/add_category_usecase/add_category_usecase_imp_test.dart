import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/errors/add_category_errors.dart';
import 'package:organizze_app/app/categories/domain/repositories/add_category_repository.dart';
import 'package:organizze_app/app/categories/domain/usecases/add_category_usecase/add_category_usecase.dart';
import 'package:organizze_app/app/categories/domain/usecases/add_category_usecase/add_category_usecase_imp.dart';

class RepositoryMock extends Mock implements AddCategoryRepository {}

void main() {
  late AddCategoryRepository repository;
  late AddCategoryUsecase usecase;

  setUpAll(() {
    registerFallbackValue(
      CategoryEntity(categoryType: '', name: '', iconPath: ''),
    );
  });

  setUp(() {
    repository = RepositoryMock();
    usecase = AddCategoryUsecaseImp(repository);
  });

  test('should return true when add is succeed', () async {
    when(() => repository(any(), any())).thenAnswer((_) async => right(true));

    var result = await usecase(
        CategoryEntity(name: 'test', categoryType: 'test', iconPath: 'test'),
        'userId');

    expect(result.fold(id, id), true);
  });

  test('should return error when name is empty', () async {
    var result = await usecase(
        CategoryEntity(name: '', categoryType: 'test', iconPath: 'test'),
        'userId');

    expect(result.fold(id, id), isA<InvalidArgument>());
  });

  test('should return error when iconPath is empty', () async {
    var result = await usecase(
        CategoryEntity(name: 'test', categoryType: 'test', iconPath: ''),
        'userId');

    expect(result.fold(id, id), isA<InvalidArgument>());
  });
}
