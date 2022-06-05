import 'package:organizze_app/app/accounts/domain/entities/credit_card_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:organizze_app/app/accounts/domain/errors/get_list_credit_card_erros.dart';
import 'package:organizze_app/app/accounts/domain/repositories/get_list_credit_card_repository.dart';
import 'package:organizze_app/app/accounts/domain/usecases/get_list_credit_card_usecase/get_list_credit_card_usecase.dart';

class GetListCreditCardUsecaseImp implements GetListCreditCardUsecase {
  final GetListCreditCardRepository _getListCreditCardRepository;

  GetListCreditCardUsecaseImp(this._getListCreditCardRepository);

  @override
  Future<Either<GetListCreditCardErros, List<CreditCardEntity>>> call(
    String userId,
  ) async {
    return await _getListCreditCardRepository(userId);
  }
}
