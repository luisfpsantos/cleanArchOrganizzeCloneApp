import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_credit_card_repository.dart';
import 'package:organizze_app/app/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase.dart';
import 'package:organizze_app/app/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase_imp.dart';

class RepositoryMock extends Mock implements GetListCreditCardRepository {}

void main() {
  late GetListCreditCardRepository repository;
  late GetListCreditCardUsecase usecase;

  setUp(() {
    repository = RepositoryMock();
    usecase = GetListCreditCardUsecaseImp(repository);
  });

  test('should return list CreditCardEntity', () async {
    when(() => repository())
        .thenAnswer((_) async => right(<CreditCardEntity>[]));

    final result = await usecase();

    expect(result.fold(id, id), isA<List<CreditCardEntity>>());
  });
}
