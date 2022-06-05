import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/categories/domain/entities/category_entity.dart';
import 'package:organizze_app/app/categories/domain/repositories/get_list_categories_repository.dart';
import 'package:organizze_app/app/categories/domain/usecases/get_list_categories_usecase/get_list_categories_usecase.dart';
import 'package:organizze_app/app/categories/domain/usecases/get_list_categories_usecase/get_list_categories_usecase_imp.dart';

class RepositoryMock extends Mock implements GetListCategoriesRepository {}

void main() {
  late GetListCategoriesUsecase usecase;
  late GetListCategoriesRepository repository;

  setUp(() {
    repository = RepositoryMock();
    usecase = GetListCategoriesUsecaseImp(repository);
  });

  test('should return list of CategoryEntity', () async {
    when(() => repository(any(), any()))
        .thenAnswer((_) async => right(<CategoryEntity>[]));

    final result = await usecase('income', 'userId');

    expect(result.fold(id, id), isA<List<CategoryEntity>>());
  });
}
