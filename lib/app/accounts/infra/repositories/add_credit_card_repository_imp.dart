import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/accounts/domain/errors/add_credit_card_error.dart';
import 'package:organizze_app/app/accounts/domain/repositories/add_credit_card_repository.dart';
import 'package:organizze_app/app/accounts/infra/datasources/add_credit_card_datasource.dart';

class AddCreditCardRepositoryImp implements AddCreditCardRepository {
  final AddCreditCardDatasource _addCreditCardDatasource;

  AddCreditCardRepositoryImp(this._addCreditCardDatasource);

  @override
  Future<Either<AddCreditCardErrors, bool>> call(
    CreditCardEntity creditCard,
    String userId,
  ) async {
    try {
      final result = await _addCreditCardDatasource(creditCard, userId);
      return right(result);
    } on AddError catch (e) {
      return left(e);
    } on CreditCardAlreadyExists catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('Unknown error: ${e.toString()}'));
    }
  }
}
