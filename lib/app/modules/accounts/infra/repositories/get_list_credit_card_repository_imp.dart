import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/modules/accounts/domain/entities/credit_card_entity.dart';
import 'package:organizze_app/app/modules/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/modules/accounts/domain/repositories/get_list_credit_card_repository.dart';
import 'package:organizze_app/app/modules/accounts/infra/datasources/get_list_credit_card_datasource.dart';

class GetListCreditCardRepositoryImp implements GetListCreditCardRepository {
  final GetListCreditCardDatasource _getListCreditCardDatasource;

  GetListCreditCardRepositoryImp(this._getListCreditCardDatasource);

  @override
  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> call(
    String userId,
  ) async {
    try {
      final result = await _getListCreditCardDatasource(userId);
      return right(result);
    } on NoCreditCardFound catch (e) {
      return left(e);
    } catch (e) {
      return left(RepositoryError('unknown error: ${e.toString()}'));
    }
  }
}
