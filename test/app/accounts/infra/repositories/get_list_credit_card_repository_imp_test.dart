import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_credit_card_repository.dart';
import 'package:organizze_app/app/accounts/infra/datasources/get_list_credit_card_datasource.dart';
import 'package:organizze_app/app/accounts/infra/repositories/get_list_credit_card_repository_imp.dart';

class DatasourceMock extends Mock implements GetListCreditCardDatasource {}

void main() {
  late GetListCreditCardDatasource datasource;
  late GetListCreditCardRepository repository;

  setUp(() {
    datasource = DatasourceMock();
    repository = GetListCreditCardRepositoryImp(datasource);
  });

  test('should return list of CreditCardEntity', () async {
    when(() => datasource(any())).thenAnswer((_) async => <CreditCardEntity>[]);

    final result = await repository('userId');

    expect(result.fold(id, id), isA<List<CreditCardEntity>>());
  });

  test('should return error when not found any creditCard', () async {
    when(() => datasource(any())).thenThrow(NoCreditCardFound('test'));

    final result = await repository('userId');

    expect(result.fold(id, id), isA<NoCreditCardFound>());
  });

  test('should return repository error when data source throw unknown error',
      () async {
    when(() => datasource(any())).thenThrow(Exception('test'));

    final result = await repository('userId');

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
