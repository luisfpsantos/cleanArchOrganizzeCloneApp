import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/accounts/domain/entities/account_entity.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_account_repository.dart';
import 'package:organizze_app/app/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase.dart';
import 'package:organizze_app/app/accounts/domain/usecases/get_list_account_usecase/get_list_account_usecase_imp.dart';

class RepositoryMock extends Mock implements GetListAccountRepository {}

void main() {
  late GetListAccountRepository repository;
  late GetListAccountUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = GetListAccountUsecaseImp(repository);
  });

  test('should return list AccountEntity', () async {
    when(() => repository()).thenAnswer((_) async => right(<AccountEntity>[]));

    final result = await usecase();

    expect(result.fold(id, id), isA<List<AccountEntity>>());
  });
}
