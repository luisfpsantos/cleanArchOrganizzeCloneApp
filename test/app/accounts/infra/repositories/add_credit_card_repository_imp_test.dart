import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/accounts/domain/repositories/add_credit_card_repository.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_credit_card_datasource.dart';
import 'package:organizze_app/app/accounts/infra/repositories/add_credit_card_repository_imp.dart';

class DatasourceMock extends Mock implements AddCreditCardDatasource {}

void main() {
  late AddCreditCardDatasource datasource;
  late AddCreditCardRepository repository;

  setUpAll(() {
    registerFallbackValue(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '', limit: 1, name: ''));
  });

  setUp(() {
    datasource = DatasourceMock();
    repository = AddCreditCardRepositoryImp(datasource);
  });

  test('should return true when credit card is added', () async {
    when(() => datasource(any())).thenAnswer((_) async => true);

    final result = await repository(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '/', limit: 1, name: 'a'));

    expect(result.fold(id, id), true);
  });

  test('should return addError when datasource is incapable to add', () async {
    when(() => datasource(any())).thenThrow(AddError('test'));

    final result = await repository(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '/', limit: 1, name: 'a'));

    expect(result.fold(id, id), isA<AddError>());
  });

  test('should return credit card already exists', () async {
    when(() => datasource(any())).thenThrow(CreditCardAlreadyExists('test'));

    final result = await repository(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '/', limit: 1, name: 'a'));

    expect(result.fold(id, id), isA<CreditCardAlreadyExists>());
  });

  test('should return RepositoryError when datasource throw unknown error',
      () async {
    when(() => datasource(any())).thenThrow(Exception('asdfasdf'));

    final result = await repository(CreditCardEntity(
        closedDay: 1, dueDay: 1, iconPath: '/', limit: 1, name: 'a'));

    expect(result.fold(id, id), isA<RepositoryError>());
  });
}
